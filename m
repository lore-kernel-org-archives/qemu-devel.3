Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEA7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whT4V-0006pY-79; Wed, 08 Jul 2026 10:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1whT4T-0006op-Rs
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1whT4R-0005RH-9W
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783520173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zc3P5sGLUXZ2J+nNypqlfuqU9Vng109dcjBCmM7bwyA=;
 b=fwNyJ366hXrQuTk18cXXDgbwovTlKZZ78xvxmIkpa+ZxWEbNYuG7Z/VaPjyOMwwRzbKnVC
 awacFhxIWcfESoDilQaaicZUS1Ts0xDSA85Q2HuBSLVL0FIgSE2v1EE0k/Gp0fJSP6x1YA
 U/iGuKjFSe9OwgIGxQogavig/sJ2FlI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-AAp6636eMG23SpQpXJl7fA-1; Wed,
 08 Jul 2026 10:16:10 -0400
X-MC-Unique: AAp6636eMG23SpQpXJl7fA-1
X-Mimecast-MFC-AGG-ID: AAp6636eMG23SpQpXJl7fA_1783520168
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E99A180059A; Wed,  8 Jul 2026 14:16:08 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDBBA1956086; Wed,  8 Jul 2026 14:16:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: freude@linux.ibm.com, Michael Tokarev <mjt@tls.msk.ru>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, qemu-stable
 <qemu-stable@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v11 01/21] target/s390x: Fix wrong address handling in
 address loops
In-Reply-To: <a38386d1eb7c0809e62a4e3399f8ea0e@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260707161815.40919-1-freude@linux.ibm.com>
 <20260707161815.40919-2-freude@linux.ibm.com>
 <3e31b38c-0561-4f37-b2c4-97c10e6f232f@tls.msk.ru>
 <d5436f34-5489-4335-bf83-74b924e04140@tls.msk.ru>
 <a38386d1eb7c0809e62a4e3399f8ea0e@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Wed, 08 Jul 2026 16:16:04 +0200
Message-ID: <87zf01in2z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 08 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 2026-07-08 13:18, Michael Tokarev wrote:
>> On 08.07.2026 13:37, Michael Tokarev wrote:
>>> On 07.07.2026 19:17, Harald Freudenberger wrote:
>>>> The loop increments addr by the element stride (+=3D 4) before calling
>>>> wrap_address, but then overwrites the loop addr with the wrapped
>>>> value. On the next iteration the stride is applied to the wrapped
>>>> address of the previous element, not to the original unwrapped
>>>> address. This results in every element after the first is read from a
>>>> wrong (wrapped) address.
>>>>=20
>>>> Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>> ---
>>>> =C2=A0 target/s390x/tcg/crypto_helper.c | 12 ++++--------
>>>> =C2=A0 1 file changed, 4 insertions(+), 8 deletions(-)
>>>=20
>>> This feels like qemu-stable material.
>>> I'm picking this change up for currently active stable qemu series.
>>> Please let me know if I shouldn't.
>>=20
>> Um, this was a bit premature.
>>=20
>> This particular commit requires a previous commit in this area,
>> de96db79 "target/s390x: Compile crypto_helper.c as common unit".
>> It's easy to back-port across, but since this change ("Fix wrong
>> address handling...") hasn't been marked as for-stable, I'm *not*
>> doing that.  If this change is actually needed in -stable, please
>> let me know.  Also, is it okay to pick up the previous change
>> ("compile as common unit") to -stable too, to avoid fixing up
>> subsequent changes.
>>=20
>> Thanks,
>>=20
>> /mjt
>
> Fine with me. However, Connie replied to my v10 series that she
> wants to pick this patch. However, it is yet not on the qemu
> master branch.

Should be now, as the s390 update was pulled?


