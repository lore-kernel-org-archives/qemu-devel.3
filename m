Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91CFCDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclHC-0000dy-Q0; Thu, 25 Jun 2026 10:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wclH1-0000co-Aw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wclGy-000605-TD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782398502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xgzLypL17nyDwziDB2pDKNxgb5aVl0Z6UBUD2Yzm9E=;
 b=T/8Bqyp0ZLcnaSPIYfzuw2SFDWQI/ahyYkxkvwaDJSzO76BA7+28L71TGP1oAXjoKhnH33
 xijbeHL6LCsHVCtvTXTyIdHVzo7rwUtDld7RpvZQC7Ub/kJCPI7fdRiUEWKIpB+wJX4ZXI
 hk0JnxAN1BOtTyhvtJ8LOzlMPi9V1ao=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-qNxsm3Q8PCCIvKmgsEDf0w-1; Thu, 25 Jun 2026 10:41:40 -0400
X-MC-Unique: qNxsm3Q8PCCIvKmgsEDf0w-1
X-Mimecast-MFC-AGG-ID: qNxsm3Q8PCCIvKmgsEDf0w_1782398499
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30b877ee493so1088882eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782398499; x=1783003299; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xgzLypL17nyDwziDB2pDKNxgb5aVl0Z6UBUD2Yzm9E=;
 b=dI97KGBVgdCFzWjAf4OUIjypTEgpAgiCdH4hQSr3WASJRDZYPr/OHvPK5iWh+xyJd9
 bo9lghPGpL2O0roXb7EixsJCLt7DMwJEtMUWhzZOLyvB7UjYFlm9HQ3UbjnH+cQuIXFn
 J4QbsOkjgEFCZbL+Q+siDCVr9f19s3XATc4aeuF5mNh8VDCcHOurF/v85ttznG68h19T
 I6h5dXcMudoAeld3Z/3i0jleE4CvR0dqcenz1AiCsx6fGi+3vZ8RbfwzYvYSMHffXm/p
 o8GviIhGI1jg1O+PX2t2RLFPfSSh6Qay8VOsHX5mbPOELEgG4DwyTrvHeMbzkdgYk67F
 ZV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398499; x=1783003299;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/xgzLypL17nyDwziDB2pDKNxgb5aVl0Z6UBUD2Yzm9E=;
 b=lqOMTgnTUdBBj+pDSd2sEPBUbxqsvfv247aFp5FCNKnTvnJWXfifOK8QKa7irpBlhv
 urRghJsoGk2rhxi/mmTQUPQGd4STLROF2PnwO8rQb7ThSuF5pgCB5sxN+F2fEj9MyoKW
 aFt80YQj0MYqaNMmPCYcCpveB5x9vq3z1sGv16WFI5tkEOiZbGBo1rtv2sfBaxFUcBUv
 olxuha45yS1GpkHsu4bOs7cm0jh25f7Ja5Qm0PUcgxE3DrKQhY3Esonqe510FokcY2PM
 uAPtSmrt3I06rFgGXHlwsa9Tyi/edDpqgV/U1QZPYzZ1uoQ9K9fRwrdRsnLW/cqKTDIY
 BlSw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3I0KAmPccdwV7d+ulTKgYJA+OdDjcy4niTcIpnSH3fYCKzX5eiRuXUhAE6YwbIrrEJV8qVHQ4bGV4@nongnu.org
X-Gm-Message-State: AOJu0Yy9J6VtrN94kODwZzc/pom8AqRPDJDh4Av8V/QZAmGzogjWYc5f
 ueKaGvZYsnyfWhLFb8d3E4V6jRrITNhwrPhnngw1xk3Gc0dJdaLd8KYShLp60Svmpf2OGnwPEhq
 0lRYmwL9zL2CafJECPWBGhgCNjK219RSoWo0DtWMOkE+84X36uN8hEYjH
X-Gm-Gg: AfdE7cl16aqzEVuUv2ZsW8wFfacbThHagu7XSbolgBp6IN8d3+vgaBn3jHdM6oz+1AA
 WSK5AYPlSMuECLPealK5QEoNhERG4jjf81l/3f/K5LXiMYkrkWS5sZz6AU5zG3CfXATdyiddnzs
 zpm0V/XVyYEginrKCcHwyu2KCa18b0RavXBYOUZgFdI3R54+4e72tIAq8vkDbAMX7wuFLjY9YqF
 Mv0AT/7Y95OhsvrAQp1fkGpIwA+F0wgyzg4QsgWDnxHKwWpgriyTVK0SOyVGCENEtzu08+GQSMr
 WIp316dpfvOcHOb0ItSTTLYZ7hr0nLBPKGm7BELRo7wGdqaEJ6WqTGpD7VDY++yPelnA9p8fVsZ
 YyOgX43XmQc6tQwmOxV0f6Cy0xnQ0nXAjznIOJ1fOhEl8X9iuqPINnAK/kV6QUpTF
X-Received: by 2002:a05:7300:80cc:b0:30c:1fb5:94b1 with SMTP id
 5a478bee46e88-30c5553657amr12559178eec.6.1782398499285; 
 Thu, 25 Jun 2026 07:41:39 -0700 (PDT)
X-Received: by 2002:a05:7300:80cc:b0:30c:1fb5:94b1 with SMTP id
 5a478bee46e88-30c5553657amr12559147eec.6.1782398498725; 
 Thu, 25 Jun 2026 07:41:38 -0700 (PDT)
Received: from smtpclient.apple ([110.227.100.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52eed6sm9043736eec.9.2026.06.25.07.41.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2026 07:41:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <fac41663-74bb-4c42-b084-b75ef08c26e7@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 20:11:22 +0530
Cc: Gerd Hoffman <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Alex Graf <graf@amazon.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <459F2DCD-DBA7-4AAC-A581-C30727A3AF1C@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-5-anisinha@redhat.com>
 <fac41663-74bb-4c42-b084-b75ef08c26e7@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 24 Jun 2026, at 8:57=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> On 24/6/26 07:53, Ani Sinha wrote:
>>=20
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(VMLaunchUpdateState, VMLAUNCHUPDATE);
>> +
>> +/* returns NULL unless there is exactly one device */
>> +static inline VMLaunchUpdateState *vm_launchupdate_find(void)
>> +{
>> +    Object *o =3D object_resolve_path_type("", TYPE_VMLAUNCHUPDATE, =
NULL);
>> +
>> +    return o ? VMLAUNCHUPDATE(o) : NULL;
>> +}
>=20
> Is this inline really justified?

Will fix in next spin up.=


