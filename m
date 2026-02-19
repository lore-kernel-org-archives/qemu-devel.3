Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58679E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt17p-0001oc-AU; Thu, 19 Feb 2026 05:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vt17k-0001oA-Uv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vt17j-0000F7-GC
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771496346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iT9uT2DjY1b9HxSIgqLjLQwzwM6ZtyvFJonzoY7L4hk=;
 b=DWVJuorubtgH6Y3vTQfBJwMaeW/kWqmKtEbFsbko7LOy7GH36CPuLxCEz0O3SHjcfCTkXX
 bvpQA7c5/Bkwqjh3upb1GCdBysfBmyaUUfw3DwRPXwXrVpFEAQQFj0uHku2AEt19xl3eqa
 OrcxpTNgT+ftO0lgYmIjwVkMlDAEZE4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-SRjL7uAUOmy-NLTF5aDOkw-1; Thu,
 19 Feb 2026 05:19:05 -0500
X-MC-Unique: SRjL7uAUOmy-NLTF5aDOkw-1
X-Mimecast-MFC-AGG-ID: SRjL7uAUOmy-NLTF5aDOkw_1771496344
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFAFE1800282; Thu, 19 Feb 2026 10:19:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DC543000C26; Thu, 19 Feb 2026 10:19:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C6B421E692D; Thu, 19 Feb 2026 11:19:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel Berrange
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Eric Blake
 <eblake@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 33/34] qom: add 'confidential-guest-reset' property
 for x86 confidential vms
In-Reply-To: <DD830601-D059-4702-9D08-8A461A02A287@redhat.com> (Ani Sinha's
 message of "Thu, 19 Feb 2026 14:59:02 +0530")
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-34-anisinha@redhat.com>
 <87wm093yer.fsf@pond.sub.org>
 <ECE353A6-A0BC-4A3A-8D80-581CE9150C5D@redhat.com>
 <87pl613wxi.fsf@pond.sub.org>
 <DD830601-D059-4702-9D08-8A461A02A287@redhat.com>
Date: Thu, 19 Feb 2026 11:19:02 +0100
Message-ID: <87pl612fzd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ani Sinha <anisinha@redhat.com> writes:

>> On 19 Feb 2026, at 2:57=E2=80=AFPM, Markus Armbruster <armbru@redhat.com=
> wrote:
>>=20
>> Ani Sinha <anisinha@redhat.com> writes:
>>=20
>>>> On 19 Feb 2026, at 2:25=E2=80=AFPM, Markus Armbruster <armbru@redhat.c=
om> wrote:
>>>>=20
>>>> Ani Sinha <anisinha@redhat.com> writes:
>>>>=20
>>>>> Through the new 'confidential-guest-reset' property, control plane sh=
ould be
>>>>> able to detect if the hypervisor supports x86 confidential guest rese=
ts. Older
>>>>> hypervisors that do not support resets will not have this property po=
pulated.
>>>>=20
>>>> Double-checking...  This is an static ability of QEMU, and QEMU alone.
>>>> It does not depend on QEMU's run-time environment (host kernel, ...) or
>>>> the guest.  Correct?
>>>=20
>>> The run time environment is the same as what is needed to spawn confide=
ntial guests. That is, the host should support confidential technology. The=
 host kernel/distribution should support confidential technologies. Plus th=
e guest should support confidential technologies. There is nothing addition=
ally needed to support resets. There are no additional dependencies with ho=
st kernel/environment and/or the guest etc to support reset.
>>=20
>> So...  if a QEMU with this feature succeeded at starting a confidential
>> guest, then x86 confidential guest reset is definitely supported for
>> that guest.  Correct?
>
> Yes :-)=20

Thank you!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


