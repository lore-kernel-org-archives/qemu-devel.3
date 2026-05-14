Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3919BCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 07:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNQJl-0002P8-5f; Thu, 14 May 2026 03:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wNQJB-0001wj-GX
 for qemu-devel@nongnu.org; Thu, 14 May 2026 03:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wNQJ9-0003pC-Ma
 for qemu-devel@nongnu.org; Thu, 14 May 2026 03:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778742995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2n5PKXMMa6HQJPVXHT479++rs5e+4Rx88zJ/sKc9nb4=;
 b=aMPZo7E1tzEZ7Xli484nuDtW8KxyHsknp8NiENSSi41DvcXXffnuE6HU8U0JXRwgMFBS06
 r/bF1WlWyDepbeKMaMVCyyX6fCRMVKSROP0GRI1t3/X743eCTvC6mNnGrfb1sFcOciq5uX
 i4y5FeI+TUCFTrlrlv/uRlVVDCtMsOA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-2rDzFn5mPZyHwBsLFNTIzQ-1; Thu, 14 May 2026 03:16:33 -0400
X-MC-Unique: 2rDzFn5mPZyHwBsLFNTIzQ-1
X-Mimecast-MFC-AGG-ID: 2rDzFn5mPZyHwBsLFNTIzQ_1778742992
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-366122e01fcso8720633a91.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778742992; x=1779347792; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2n5PKXMMa6HQJPVXHT479++rs5e+4Rx88zJ/sKc9nb4=;
 b=jXtP/gXm3WZALGNb9ZPUtJeb7No73/Ox8SbuyMLnjtZUFFGFwYV5DCfjmVtxE+EX/O
 TLOA1br3wSvZHpiAV4dnRQ+1ATcky6sAUHsPPCSf4GQknWxMvEp9k5b9Lr+yzFLaXxBX
 6vH2HBrDFX7hXT3Q7IX4Hz0Ct/0iTrLChb1Ig3DPyOAcoLQS2Qf8DWpmFTdJCXU7PuEk
 /c99Tw/bmm61t1CMR18WE4KXtmpEbRFW4M1Hz0TJG9Vpb77BRiVwA33rFDqEC4SpkVxo
 uTHIrvXqI7RGBA6moNTZjgBY6pcrREjuilzVPnJDdZsyJvc+CYxyqZK/GYbrjghfbUty
 VIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778742992; x=1779347792;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2n5PKXMMa6HQJPVXHT479++rs5e+4Rx88zJ/sKc9nb4=;
 b=BHZyde6H9f6UTX6JLdyba0Z0+v7+BbdUC/d/f2FjVkQYiAJKve958Z0+Movl5JF3cd
 eyXlNH5dUWEj+Icyr84zYUpQMYdNC8zqXyD5bnR+VX8AB4VFiFojbujFKybKT+07RAWH
 R7JXdf9L5Tih88n6CLV9icpagI+aLxo/xCUm5Ngv409Hk7X6zDm8RlIpK4qLwxJ/4zpF
 aqJB0qZQcQC0FD58rEkc7hsWJYe0PA4USTTAijGRCOM8rjroRr2bX2xzDS4ou5z+zAMD
 G0mFHSXpC3jRuLNU1w8eyDmqN7SyBT+rC/NUctwzVR7oZ+NrWfVpwM952fILzmWyvF4W
 WrVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YZ9nxJn43DKPkFEyrIF+WH1RpDIcmyG8ki3b1tNMX8azKdcJU08HqVfDRjjXtGV9OKpSMmsLzM2+S@nongnu.org
X-Gm-Message-State: AOJu0Ywjkc3itvh3i5bPPPe7Z/TbRf4h3D90QJFH3TqMSIQg4AIBE+Do
 x6m9e0n1XKbKAeDZ3lE4ULiUWyBkIBo+OVJnwQKRzmQn4P8AKXReyclNKsjJdpyxcAMDmt0ls32
 ooX5banp0kvO1mGK/sFti+4eKws6A59U5vfCnlkgJscdhKYHxZtVVVpEK
X-Gm-Gg: Acq92OHmAUosCeos4i2Y8A3B7dzrcXNjr/DaqrB4VQFbKoiZ8Sui75kTVEsCn1jqwwI
 D9+N87PWVynnB2kUZuyjpWA63g1t/kNLqglBL7jv4fUjTTZ2Cc+PISCD1jZsDw8kJ7hZt9jMVxH
 PjBA3ECMCVzOJGuEi46vm5nhH9FyEHLxPHx7xyKNocAO/FypEKUxrV53t7+3xHzBkWxx55bd1ke
 XOy63whtRbURrnJWn4ouegy3P3YaR/BYuBgdclpv5Gea56DZ8Ku/uZlxBdl4b8EPbpDqfXLu8F2
 0PlXwVkdPyVJsz8lwZmqHZjVwdyu1V23m2iGMpRmOuY5cf5aa42a73EZ1+oMvsHkHhC66UPzsZL
 QCUahhZyIuvBgzQndHMSfgcAMRDn328l3NLQvf/iejDSEkegx1J0DQ1gd3kL+MfWpkMGtitDUNx
 0=
X-Received: by 2002:a05:6a20:3945:b0:398:b95c:51f7 with SMTP id
 adf61e73a8af0-3af82c8f5f2mr7700471637.37.1778742991726; 
 Thu, 14 May 2026 00:16:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:3945:b0:398:b95c:51f7 with SMTP id
 adf61e73a8af0-3af82c8f5f2mr7700402637.37.1778742991054; 
 Thu, 14 May 2026 00:16:31 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb116832sm1300137a12.24.2026.05.14.00.16.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2026 00:16:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 02/21] x86: q35: add 'wdat' property
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <agSRsqaRsGBBwewT@intel.com>
Date: Thu, 14 May 2026 12:46:14 +0530
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6743DA13-4C1D-47D2-ADE6-C87A2A073F28@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-3-imammedo@redhat.com> <agSRsqaRsGBBwewT@intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 13 May 2026, at 8:28=E2=80=AFPM, Zhao Liu <zhao1.liu@intel.com> =
wrote:
>=20
> On Tue, Mar 03, 2026 at 10:25:13AM +0100, Igor Mammedov wrote:
>> Date: Tue,  3 Mar 2026 10:25:13 +0100
>> From: Igor Mammedov <imammedo@redhat.com>
>> Subject: [PATCH v2 02/21] x86: q35: add 'wdat' property
>>=20
>> Used for enabling WDAT based watchdog for builtin iTCO watchdog.
>> Usage:
>>    -M q35,wdat=3D{on|off}
>> By default it is disabled.
>>=20
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> include/hw/i386/pc.h |  1 +
>> hw/i386/pc_q35.c     | 18 ++++++++++++++++++
>> 2 files changed, 19 insertions(+)
>=20
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>



