Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A273AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 12:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2VTm-000390-IU; Thu, 02 May 2024 08:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2VTk-00038V-CY
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2VTi-0002k2-EI
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714652637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xMQVy7oJq8SdNlUsNwqEI1Z9p1RrdR2ZtYybwfpuUg0=;
 b=RAo5t+Z7S65fqyENZRgpjA39rUilTIuY+9dFq/TqgA5Rlfl7CbD67Rb0mAlFO43BZ3+7Cq
 6tvWjtvhv1+sG7cPB+3fq+Jg9Nne/+fkuAg5OKDiTfdayKD9Org64F4pTcaqPy1ZpJodYs
 8DNZ9N/O2bFPu4t2sR1YrhDjeLLStts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-c34bWZKJN1Sunee46VzyBw-1; Thu, 02 May 2024 08:23:56 -0400
X-MC-Unique: c34bWZKJN1Sunee46VzyBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1FB38021A4;
 Thu,  2 May 2024 12:23:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B74EE40B4979;
 Thu,  2 May 2024 12:23:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6C2A21E6811; Thu,  2 May 2024 14:23:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe Mathieu-Daude
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V1 20/26] migration: cpr-exec mode
In-Reply-To: <1714406135-451286-21-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Mon, 29 Apr 2024 08:55:29 -0700")
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-21-git-send-email-steven.sistare@oracle.com>
Date: Thu, 02 May 2024 14:23:54 +0200
Message-ID: <87bk5o7679.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Steve Sistare <steven.sistare@oracle.com> writes:

> Add the cpr-exec migration mode.  Usage:
>   qemu-system-$arch -machine memfd-alloc=on ...
>   migrate_set_parameter mode cpr-exec
>   migrate_set_parameter cpr-exec-args \
>     <arg1> <arg2> ... -incoming <uri>
>   migrate -d <uri>
>
> The migrate command stops the VM, saves state to the URI,
> directly exec's a new version of QEMU on the same host,
> replacing the original process while retaining its PID, and
> loads state from the URI.  Guest RAM is preserved in place,
> albeit with new virtual addresses.
>
> Arguments for the new QEMU process are taken from the
> @cpr-exec-args parameter.  The first argument should be the
> path of a new QEMU binary, or a prefix command that exec's the
> new QEMU binary.
>
> Because old QEMU terminates when new QEMU starts, one cannot
> stream data between the two, so the URI must be a type, such as
> a file, that reads all data before old QEMU exits.
>
> Memory backend objects must have the share=on attribute, and
> must be mmap'able in the new QEMU process.  For example,
> memory-backend-file is acceptable, but memory-backend-ram is
> not.
>
> The VM must be started with the '-machine memfd-alloc=on'
> option.  This causes implicit ram blocks (those not explicitly
> described by a memory-backend object) to be allocated by
> mmap'ing a memfd.  Examples include VGA, ROM, and even guest
> RAM when it is specified without a memory-backend object.
>
> The implementation saves precreate vmstate at the end of normal
> migration in migrate_fd_cleanup, and tells the main loop to call
> cpr_exec.  Incoming qemu loads preceate state early, before objects
> are created.  The memfds are kept open across exec by clearing the
> close-on-exec flag, their values are saved in precreate vmstate,
> and they are mmap'd in new qemu.
>
> Note that the memfd-alloc option is not related to memory-backend-memfd.
> Later patches add support for memory-backend-memfd, and for additional
> devices, including vfio, chardev, and more.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 49710e7..7c5f45f 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -665,9 +665,37 @@
>  #     or COLO.
>  #
>  #     (since 8.2)
> +#
> +# @cpr-exec: The migrate command stops the VM, saves state to the URI,
> +#     directly exec's a new version of QEMU on the same host,
> +#     replacing the original process while retaining its PID, and
> +#     loads state from the URI.  Guest RAM is preserved in place,
> +#     albeit with new virtual addresses.

Do you mean the virtual addresses of guest RAM may differ betwen old and
new QEMU process?

> +#
> +#     Arguments for the new QEMU process are taken from the
> +#     @cpr-exec-args parameter.  The first argument should be the
> +#     path of a new QEMU binary, or a prefix command that exec's the
> +#     new QEMU binary.

What's a "prefix command"?  A wrapper script, perhaps?

> +#
> +#     Because old QEMU terminates when new QEMU starts, one cannot
> +#     stream data between the two, so the URI must be a type, such as
> +#     a file, that reads all data before old QEMU exits.

What happens when you specify a URI that doesn't?

> +#
> +#     Memory backend objects must have the share=on attribute, and
> +#     must be mmap'able in the new QEMU process.  For example,
> +#     memory-backend-file is acceptable, but memory-backend-ram is
> +#     not.
> +#
> +#     The VM must be started with the '-machine memfd-alloc=on'

What happens when you don't?

> +#     option.  This causes implicit ram blocks -- those not explicitly
> +#     described by a memory-backend object -- to be allocated by
> +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
> +#     RAM when it is specified without a memory-backend object.
> +#
> +#     (since 9.1)
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal', 'cpr-reboot' ] }
> +  'data': [ 'normal', 'cpr-reboot', 'cpr-exec' ] }
>  
>  ##
>  # @ZeroPageDetection:

[...]


