Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A73CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQeR-000786-Pw; Tue, 02 Dec 2025 08:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQQeM-00077L-4O
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQQeK-00063U-CL
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764682953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LN3ZRhlR55DAhXGZZfrNPYhGZ9yXyiDQHCZwNpQSxaQ=;
 b=ERf9CGUfE57H2NBngdn/38F7kZF6XToBCjXE2o0BMyFu7oX/BBlN48/gXDX4+LWmPE/knT
 qk+ZQdTSUKAdHys/qtzh6kXs30FOeQ4hBEC3OoLWWg8qEXIJnUM+3HleCXqgYYU/RKFi2w
 obENu0DYJskOLLGNpHPpILBwfmQf5cs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-V1al1FhNMyeFRg-VXnlFSw-1; Tue,
 02 Dec 2025 08:42:32 -0500
X-MC-Unique: V1al1FhNMyeFRg-VXnlFSw-1
X-Mimecast-MFC-AGG-ID: V1al1FhNMyeFRg-VXnlFSw_1764682951
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 828C71956080; Tue,  2 Dec 2025 13:42:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3732C180047F; Tue,  2 Dec 2025 13:42:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89B4221E6A27; Tue, 02 Dec 2025 14:42:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  kvm@vger.kernel.org,
 eesposit@redhat.com,  philmd@linaro.org,  qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2] kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl()
 return value
In-Reply-To: <db4b64b3-d40e-456f-b76a-bf8228e91946@tls.msk.ru> (Michael
 Tokarev's message of "Tue, 2 Dec 2025 16:14:56 +0300")
References: <20251128152050.3417834-1-armbru@redhat.com>
 <db4b64b3-d40e-456f-b76a-bf8228e91946@tls.msk.ru>
Date: Tue, 02 Dec 2025 14:42:26 +0100
Message-ID: <871pldt2yl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 11/28/25 18:20, Markus Armbruster wrote:
>> These functions wrap ioctl().  When ioctl() fails, it sets @errno.
>> The wrappers then return that @errno negated.
>>
>> Except they call accel_ioctl_end() between calling ioctl() and reading
>> @errno.  accel_ioctl_end() can clobber @errno, e.g. when a futex()
>> system call fails.  Seems unlikely, but it's a bug all the same.
>>
>> Fix by retrieving @errno before calling accel_ioctl_end().
>>
>> Fixes: a27dd2de68f3 (KVM: keep track of running ioctls)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Isn't this a qemu-stable material?

I think it is.  I should've thought of adding Cc: qemu-stable.  My
apologies!


