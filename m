Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AC9D6ACF0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 11:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWCcx-00040o-MJ; Thu, 18 Dec 2025 06:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vWCcv-0003zg-P5
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 06:57:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vWCcu-0000Ys-B6
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 06:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766059019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+PRhEn1VtLfKuqeHc74HbiDO/zOaafyDaIzYfq7OSk=;
 b=fiCpORDkywhQfHyrVatcR2o1bMWCwP1eL+K5gKySf6FIl76OC61bzXXwkDoE9jeBGlB6UH
 iJaPlUc+7RviZO/8uvLtt6qqnQTl5t+DDYQgTU9VTJupwOvONaiVS+bINf/e26B8+BXHcI
 LS3Q1oPOTQWDe6seQiQJOxayc/Q0Ars=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-b4gTBNLgOYmBVXPAgwqsIQ-1; Thu, 18 Dec 2025 06:56:57 -0500
X-MC-Unique: b4gTBNLgOYmBVXPAgwqsIQ-1
X-Mimecast-MFC-AGG-ID: b4gTBNLgOYmBVXPAgwqsIQ_1766059017
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0d058fc56so8196565ad.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 03:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766059017; x=1766663817; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+PRhEn1VtLfKuqeHc74HbiDO/zOaafyDaIzYfq7OSk=;
 b=dLL9HFqN2cdEat9AexUSFgX+WJ4+zcKwLAxbGqz5YHzB97ZqfyUoCqCSB5xajNo+9k
 78KblEl8cnM8tZ6xEM/ekrrxEtJ+TeuHkxZ5IPzFLNNKfgFZhcLzw7TAL8Vcv3mwK0+K
 MRdr2dxBmGvYXS0Q52WaMiYrzlBRmvDqqqUOo3lx38xZzY7BRtLbnNLu0amDe3X3DaVz
 2erKrLpiOImwqs3SqeLXXhaM6xyeo6QQ0L5j2D7PgWaTpq/bXfmgo9vb7ZktZKXcqBSE
 vuQ1/h1rJA5ZTVQhGMEE3PIRieJ3IGGbjSoZ+AvuSEv/z0V8xRAbUHg8595Vu9m+PEEF
 j8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766059017; x=1766663817;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+PRhEn1VtLfKuqeHc74HbiDO/zOaafyDaIzYfq7OSk=;
 b=CSl7bnQo+VzbVJnZpGWrjbHdV77cs0tJsFtrRzXWoXaEpQMAmvOKXSpITNNuzdh7SM
 SKk3vjzIJB2B3J4YUuFS1bwh6qRwr+pV1ITa6O9HBB+DycxSZnZSrYWP868JEl1rdF6p
 cfDc4MOb35yeEjr74J5M9yUwLisedgNe4ppnW6I3Uol5qu539Bken1pPhy/yO+nOO9My
 ejnHZ7SgGomujt06NR5gbAVeI756NjjWd80owDoznx/SknuEg9Ku8vrc/zzIhE+gzgdA
 UuS9EZTFHOHQNaFjTZfj1SU43Jk0PPaXQaJhiC7ac/eCsmJ3VKdFt2GJMXA+mfWFOYy3
 NMNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/atDX5JunlcfLTfYJpbS4PDf/FkomNhdp2H2ZMJ7Mw/MjviBSorrkLd/m3AkZtkGjakQngi1XWQAs@nongnu.org
X-Gm-Message-State: AOJu0YyMcws7SoZkKolUv9H/2cf/ldAb6nzu5yICWidcRTIiPq0CDT6Y
 KYuNAN8mWf8bVhj4TfXW5PSBYJPTvNiPVJv311Q7vHAXrph2cRZFq3QrRUE4h2YRaxETvaSRvKO
 WG70L6Bh9+bVAAhv8nSplCcc8gp/dMh5fCJrC/0HLgG9TVaeKDUojA0KB
X-Gm-Gg: AY/fxX5SECg7wm1OUUUfDDMyRGqfh6ATIDIN3GWcCWRp3zLulg9+mBosNH7jmY/3+XM
 HugPh7hkgeol2KTOUYW9geCSKPOGN8mJZG38jt3sFS+3/moToUfnFjiWpOqiduKO9FbH2kfaTH6
 QigGu+0NZ1WR+NIfb0HFQ+GgBKwKXI0T5Yhg1cZXR4BNyjZa4LlAdGmFS8Sup8FD5GcNwroE+QR
 W0xg+S2Qdb9a1JorOOMOWVJ/I3RlkW8+ZplCKSt/d6hWBkf12BKA8C0Ya3dwvbrOCbKrLF5+Xpu
 bR0+DyRgvEtvOYrqlMLWEeip5JAhL3Q3VfszB/KFVJS7BFrSPTdQUEueJiyY46oQIlHEdiQFuAh
 SywCK7YArbspx62o6dqUdN3K2LcrUA8WxF+JsJywHvBFiEekE29ipgg==
X-Received: by 2002:a17:903:190d:b0:2a0:941a:6b08 with SMTP id
 d9443c01a7336-2a0941a75bamr189665015ad.21.1766059016733; 
 Thu, 18 Dec 2025 03:56:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCDhXgvxHRUfsjNR+yqfhNO36J3c+URKsseFBLEvOWpZ0Vs6hZk0tAM1YOTEZxnl2LnXrp1Q==
X-Received: by 2002:a17:903:190d:b0:2a0:941a:6b08 with SMTP id
 d9443c01a7336-2a0941a75bamr189664875ad.21.1766059016356; 
 Thu, 18 Dec 2025 03:56:56 -0800 (PST)
Received: from smtpclient.apple ([27.58.53.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d16126d1sm23380515ad.49.2025.12.18.03.56.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Dec 2025 03:56:56 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v1 02/28] hw/accel: add a per-accelerator callback to
 change VM accelerator handle
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <g62pujgmeihlmi27yl5opbvpta2mob2k3kyqu52yezscx2ooi5@kuddvxmpu756>
Date: Thu, 18 Dec 2025 17:26:42 +0530
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <99622010-AC9C-4E67-87FF-8D5D01771A09@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-3-anisinha@redhat.com>
 <g62pujgmeihlmi27yl5opbvpta2mob2k3kyqu52yezscx2ooi5@kuddvxmpu756>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 17 Dec 2025, at 7:44=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
>  Hi,
>=20
>> +    /*
>> +     * different accelerators implement how to close the old file =
handle of
>> +     * the accelerator descriptor and create a new one here. =
Resetting
>> +     * file handle is necessary to create a new confidential VM =
context post
>> +     * VM reset.
>> +     */
>> +    if (current_machine->cgs && reason =3D=3D =
SHUTDOWN_CAUSE_GUEST_RESET) {
>=20
> So, the vmfd code is unly used in confidential VMs.  I think it makes
> sense to offer some option to enable that for non-confidential VMs =
too.
> Useful for development and also for testing this in qemu CI.

Good idea. However, for non-coco, there is really no reason to change vm =
file descriptor. So it has to be some config option only for testing and =
development. I am open to suggestions as to what kind of option we can =
consider.=


