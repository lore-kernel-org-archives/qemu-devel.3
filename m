Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B74BC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXyu-0006ks-Th; Mon, 27 May 2024 06:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBXys-0006jl-AJ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBXyq-000237-LI
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716807208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06/efgP++cvCr9aQmle2exNHgKBPrQtzUEN3DA3ZL/Q=;
 b=AZJHZQ4Y5GDTY3+EkkcDkvZR025KMRhm9dHTq8+h9hhAijMhx1bVlkqw6KqPhYUQ74mKZn
 n6A2wXMEE1Rw3GpHbUr6NYG8gEVU+3T0wxwnciFNtEvXC4mYt/KSqFl9xw8/Q7nkksuXYr
 qjnJiY5euGmzGMtPN+GEq1XrE96Fb/k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-2YSbDu33MIilaWnXzi9_qQ-1; Mon,
 27 May 2024 06:53:23 -0400
X-MC-Unique: 2YSbDu33MIilaWnXzi9_qQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3577629AA39D;
 Mon, 27 May 2024 10:53:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 147D9491032;
 Mon, 27 May 2024 10:53:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 070D421E6757; Mon, 27 May 2024 12:53:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  fam@euphon.net,
 kwolf@redhat.com,  hreitz@redhat.com,  marcandre.lureau@redhat.com,
 farosas@suse.de,  pbonzini@redhat.com,  richard.henderson@linaro.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 5/6] migration: Rephrase message on failure to save /
 load Xen device state
In-Reply-To: <Zk-cZFil8GYo0JY8@x1n> (Peter Xu's message of "Thu, 23 May 2024
 15:43:32 -0400")
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-6-armbru@redhat.com> <Zk-cZFil8GYo0JY8@x1n>
Date: Mon, 27 May 2024 12:53:22 +0200
Message-ID: <87wmnfcyql.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, May 13, 2024 at 04:17:02PM +0200, Markus Armbruster wrote:
>> Functions that use an Error **errp parameter to return errors should
>> not also report them to the user, because reporting is the caller's
>> job.  When the caller does, the error is reported twice.  When it
>> doesn't (because it recovered from the error), there is no error to
>> report, i.e. the report is bogus.
>> 
>> qmp_xen_save_devices_state() and qmp_xen_load_devices_state() violate
>> this principle: they call qemu_save_device_state() and
>> qemu_loadvm_state(), which call error_report_err().
>> 
>> I wish I could clean this up now, but migration's error reporting is
>> too complicated (confused?) for me to mess with it.
>
> :-(

If I understood how it's *supposed* to work, I might have a chance...

I can see a mixture of reporting errors directly (with error_report() &
friends), passing them to callers (via Error **errp), and storing them
in / retrieving them from MigrationState member @error.  This can't be
right.

I think a necessary first step towards getting it right is a shared
understanding how errors are to be handled in migration code.  This
includes how error data should flow from error source to error sink, and
what the possible sinks are.

>> Instead, I'm merely improving the error reported by
>> qmp_xen_load_devices_state() and qmp_xen_load_devices_state() to the
>> QMP core from
>> 
>>     An IO error has occurred
>> 
>> to
>>     saving Xen device state failed
>> 
>> and
>> 
>>     loading Xen device state failed
>> 
>> respectively.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks!


