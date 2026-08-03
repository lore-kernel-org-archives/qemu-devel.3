Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC16C55175
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 06:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqmVi-0006ny-Tz; Mon, 03 Aug 2026 02:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wqmVF-0006mt-Hm
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 02:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wqmVD-000772-VG
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 02:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785739819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XhEOq5tliL0h5JcuGxbhQ4wJP/IWchsYX28yEZxPic=;
 b=g1J54Fm7pqSbyyRi6mW89BdTMLanHvLwGd5yXzSZUjAK7SpmRiQu3hrBdIwdT+r3pjrl4o
 RTZui9bfAEb/SPDZ3mgHDCn6K9AwmElJ3p7KSXcCtK3AZlvs1JYhrPZ4HFnDzpLaOpf91C
 fybprh3TyD+ztwSzK5dOQ8wmHuVc8mM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-F_Pd0mQfObC_V_doY_8IDg-1; Mon, 03 Aug 2026 02:50:18 -0400
X-MC-Unique: F_Pd0mQfObC_V_doY_8IDg-1
X-Mimecast-MFC-AGG-ID: F_Pd0mQfObC_V_doY_8IDg_1785739817
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so2049670a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785739817; x=1786344617; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2XhEOq5tliL0h5JcuGxbhQ4wJP/IWchsYX28yEZxPic=;
 b=ZFF7O5vIGHaa11hg9OfVZndI1SPjfS+qrF23nWj1q4nYREj3xvEr437rAOQAqmGB2Y
 3zpc1hrH5u7znXOzGsxtimdyUPRFujJWZO0wbnIe8nMgCu886yfi7iJcAdAhm0YTtqDi
 jFMLKIYwQhyaK79ErLRq+0NHdfP8sZXJz6QVDvAb3UJ8elIYjxEci0tAAIiF2JSWP0DB
 DSiot4VpnlhFA4OswM97gMw29HGBHOm5MuXWBmluoYI61fROgA1dhk4mu0Gi7hRArlne
 eQzYMaJLY0xY/ppVgudec74vjg4dafQ+9/W2NvoSJtgT55N4hCb+Sit641RLx1cSxcmP
 Jruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785739817; x=1786344617;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2XhEOq5tliL0h5JcuGxbhQ4wJP/IWchsYX28yEZxPic=;
 b=iz+JCIvvdae5tCeXGTXAZt0HqgRV5S90N2ZWJFmLJijqzxzqnPDx9ad9i6KQKlY2+5
 2ULMU2DCKyDRu8SCxO/HAqBHbpOIn2i6oB8JGeBnXRk/YxRC/KNMWmk9iV6OqYGXnWs7
 v9rIHrKRnAl1r55b6nCqPTeOY34PBY9aLMdX/z0tVCkzDlbk+T8puPY46aZ+cPyMfDR/
 23o6kRgObExFiamuf8O6fae7v0IV39M1x4jZSDZX8tmlTA1DcGuu1D8LkCrNycqGWRdi
 mOOK0IS8NzTMq0GV6IxXWBnaAG0SnckEkJXJlJStuDmFPSsB7Vv0za4ooszolEjH5rGU
 5GfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeOtnStnJjoaq/CJsbSnfnUdOABGvsUwvnTemMdW9FKk4o/YKuC/3MCWNmSc6dsrkNAM7nOeDYIwaZ@nongnu.org
X-Gm-Message-State: AOJu0YzsJ7uSWrOktwsMwLw6ZSCY3o/wkfkuhVVfFnCnDZ3Q6FxoAFNF
 ZK0DFv4I2h+eoHmzkInfVyrCw3T2vRtxafebCXrCVVigPnmSyCPAkqlGFi/hQ5lH7WJax0GktUx
 1+00W9OuEwddmDyLy2zJa5DbSYDgZ9yATR1/chHlAXHYabHQRbIqOSBFM
X-Gm-Gg: AR+sD12R+r3lBl54p8E4VoPaZe4MlmO8F+Ukq5ii0HqOZ9VQjsRjrnjwpYguFoWZXFd
 sLKv5x5vPU97/w/W6UDy5wvqJtE6rDH+dt4Drnonb8vj7mJzrIciuUoY4JHjvEtVIbUdNhjSvIU
 icH1Sohmbh+YqI4sGnb8CSQ+J1zXLWfolqn9KJzcG1tc3Zo8CNsxEyntsxxeEC+bUONVOD4pVAF
 AbFuoGtYAHFAjejyBOH+qjAKkaT2TYx4c6w558FpYhtlOroP827durjT12rnA4SNfwazNuNC34j
 CXU1DCS6Sxghg5Mp/pC8XzoWF0rh2y6wBvBx70oMKwWLQsRpw1h/tLAcidqNinjGVNFNE9PMgvY
 ltAdIPhZpuy3GL1MeKXA39v5KuOaSqJ8xcLW+ehEl+l3u6Br3BKF5
X-Received: by 2002:a05:6a21:7a82:b0:3c3:7c0d:fc85 with SMTP id
 adf61e73a8af0-3c92a9a6ba0mr8926954637.76.1785739817021; 
 Sun, 02 Aug 2026 23:50:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a82:b0:3c3:7c0d:fc85 with SMTP id
 adf61e73a8af0-3c92a9a6ba0mr8926931637.76.1785739816593; 
 Sun, 02 Aug 2026 23:50:16 -0700 (PDT)
Received: from smtpclient.apple ([223.182.94.60])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e045022sm33382604eec.18.2026.08.02.23.50.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Aug 2026 23:50:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 4/9] hw/misc/vmlaunchupdate: add api header
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ad328c87-eef8-40ae-842c-cea5633cc2d9@csgraf.de>
Date: Mon, 3 Aug 2026 12:20:01 +0530
Cc: Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FE81A23-FF4E-4F76-91D7-41C19BD5F878@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
 <20260730071254.80695-5-anisinha@redhat.com>
 <ad328c87-eef8-40ae-842c-cea5633cc2d9@csgraf.de>
To: Alexander Graf <agraf@csgraf.de>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 31 Jul 2026, at 3:33=E2=80=AFPM, Alexander Graf <agraf@csgraf.de> =
wrote:
>=20
>=20
> On 30.07.26 09:12, Ani Sinha wrote:
>> Add a separate header file for guest usable api definitions.
>>=20
>> CC: Alex Graf <graf@amazon.com>
>> CC: Gerd Hoffman <kraxel@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  .../standard-headers/misc/vmlaunchupdate.h    | 102 =
++++++++++++++++++
>>  1 file changed, 102 insertions(+)
>>  create mode 100644 include/standard-headers/misc/vmlaunchupdate.h
>>=20
>> diff --git a/include/standard-headers/misc/vmlaunchupdate.h =
b/include/standard-headers/misc/vmlaunchupdate.h
>> new file mode 100644
>> index 0000000000..fc18f8faf7
>> --- /dev/null
>> +++ b/include/standard-headers/misc/vmlaunchupdate.h
>=20
>=20
> Didn't standard-headers usually get imported from somewhere, like =
Linux? Where does this one originate? If it's self written, why not put =
it into include/hw/misc?


See https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg06362.html


