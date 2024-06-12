Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ABDC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 09:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJz1-00049N-I7; Wed, 12 Jun 2024 05:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vWVpZgsKCmgGRKd.HKTTKKROTGXU.UXMWKSa-JKbKRTUTMTa.UXM@calendar-server.bounces.google.com>)
 id 1sHJyx-00048c-Ve
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:09:29 -0400
Received: from mail-lf1-x14a.google.com ([2a00:1450:4864:20::14a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vWVpZgsKCmgGRKd.HKTTKKROTGXU.UXMWKSa-JKbKRTUTMTa.UXM@calendar-server.bounces.google.com>)
 id 1sHJys-0007eY-Er
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:09:26 -0400
Received: by mail-lf1-x14a.google.com with SMTP id
 2adb3069b0e04-52c94ad861aso1352745e87.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718183358; x=1718788158; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cJ/gKwy4S5HRR+5/XcqsXqkANhECWMqUMZZZnchj2kU=;
 b=gm3+gu9A3X6DB3WGlc7ufQFPqLhFc+IxNXmT0efnCv4QG8eFd37fzbLaMIjqj7C0lO
 ndtwcQ5k2f7FKxAgmWj8g5XByi8kDWwkdRXyPTxPBCxdaLDsWPZYnrEzJYltednv1EnK
 BiQzewjTYoKweS1NCjUqMkeboJcZ2eSe+KnsxFwOTTdf9ScSyCBZCKBELVjgW4PjXxKr
 1EVtfkSjbP38fSuoLtlGSD9I1m2D5K5HC7cB7Pjv8Cr940b6kbPtogNI5PU4Ymx1DLfe
 ed6oDNC4fkqVxOZotmbOGFuDwADzWJ6jv+Id8Vc8XErxB1GvNT2Wf1a4Epl9y0Q6o7Ms
 vcRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718183358; x=1718788158; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cJ/gKwy4S5HRR+5/XcqsXqkANhECWMqUMZZZnchj2kU=;
 b=XAJngjoCRDSS3hSMjQagGqc2taKPNKsyl15KEiDDkGUBmkP0EV+ZUV3s7yfBlDNvc/
 sC21H1PKaH+TBZ1MFWM4F7wcn1NFOF05qRoEH1L8MIva9BvYw4QR3y8paOz3wnZpJQ3i
 /y/6GiqOZO5O/umuyn9yl1KRvm/pPB0RZoFCMaxjwBnnhuNVo55ebsayWbB/a6s7xqog
 LnISEbfPD2utrrNULTcrsHpXH1siX5kJ6sLWkhCEiyoK/nE/w6Voxx8R7kyLbfTathFB
 SMEH4BcAiH3oTyVddpGn29joeOr55G1gnd9GOXGd4EIvqoiRy8g0x79slMg3WIHLl62U
 +nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718183358; x=1718788158;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJ/gKwy4S5HRR+5/XcqsXqkANhECWMqUMZZZnchj2kU=;
 b=nJVBviR0EUFVBvjISyP+RI8xn1EblSHOgRNxjZxq2kf5clmhid0599s5JRF4Osx9bm
 h/uYirQI5U2CwI7xMMAvJq2syx8D7uL4A+l+vwo/ZnmP6DtsRoOdNUE58joRcnw9UJLF
 gMWGjL/AF1zwAFCSXhpvZdBDZm4+I6NndpZ1LbZmOuQG0LGgn21UC5xk03hIsgM9tuHF
 xfKCHM0IpN5Dn1I2olNw3f5F6qlRZrjlHL6jklXVv8Reqk7Xd0pUSwKzJnrqLp71euhK
 8faH3yQuVlAiYb1F4G8PM6KQbRjyPznTUl8SPHYt6B0NPCUXB3/rQEw4FlXv26ov3vqJ
 9fuQ==
X-Gm-Message-State: AOJu0YzgLTTGz6oJyLFzspNQWqVVsHNQrsVarVJUTJVg9AF2WNW6Z6MV
 21Yme52u143/2RPoddOg1zkKcy1WwEHZhI0LCwkktfsvpem5IE2pDNahaYRtZZ4aOZriue/8sYZ
 RuAbUg7U339jcEs6Fn2nATdGNMtveD+d+HliNmTPO/sAwLTNM9Q==
X-Google-Smtp-Source: AGHT+IFMVOAXehevSvC0osx51GARvB/FabZkM/9gyKCPJxDCdy8Dk7ZgTyR49cyGAEY5QebXLAuxwIH15FLS9cFlFQHU
MIME-Version: 1.0
X-Received: by 2002:a05:6512:3f03:b0:52c:8df9:2e6f with SMTP id
 2adb3069b0e04-52c9a3fd442mr1049687e87.42.1718183357847; Wed, 12 Jun 2024
 02:09:17 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-5132e92e-d6c1-4a62-818e-0013175875bc@google.com>
Date: Wed, 12 Jun 2024 09:09:17 +0000
Subject: Updated invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 14:00 to 15:00 on Tuesday (BST) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, afaerber@suse.de, 
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 armbru@redhat.com, 
 bbauman@redhat.com, bcain@quicinc.com, berrange@redhat.com, 
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org, 
 Damien Hedde <dhedde@kalrayinc.com>, eblake@redhat.com,
 edgar.iglesias@gmail.com, 
 eduardo@habkost.net, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 eric.auger@redhat.com, 
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, jan.kiszka@web.de, 
 jgg@nvidia.com, jidong.xiao@gmail.com, jim.shu@sifive.com, 
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>, 
 konrad.wilk@oracle.com, Luc Michel <luc@lmichel.fr>, mburton@qti.qualcomm.com, 
 mdean@redhat.com, mimu@linux.vnet.ibm.com, paul.walmsley@sifive.com, 
 pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, 
 stefanha@gmail.com, wei.w.wang@intel.com, z.huo@139.com, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, eblot@rivosinc.com, 
 max.chou@sifive.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000b43ea8061aadbc18"
Received-SPF: pass client-ip=2a00:1450:4864:20::14a;
 envelope-from=3vWVpZgsKCmgGRKd.HKTTKKROTGXU.UXMWKSa-JKbKRTUTMTa.UXM@calendar-server.bounces.google.com;
 helo=mail-lf1-x14a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000b43ea8061aadbc18
Content-Type: multipart/alternative; boundary="000000000000b43ea6061aadbc16"

--000000000000b43ea6061aadbc16
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQoNClFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVy
ZW5jZSBjYWxsDQpFdmVyeSAyIHdlZWtzIGZyb20gMTQ6MDAgdG8gMTU6MDAgb24gVHVlc2RheQ0K
VW5pdGVkIEtpbmdkb20gVGltZQ0KDQpMb2NhdGlvbg0KaHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1j
YWxsbWVldGluZwkNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vdXJsP3E9aHR0cHMlM0ElMkYlMkZt
ZWV0LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5nJnNhPUQmdXN0PTE3MTg2MTUzNDAwMDAwMDAmdXNn
PUFPdlZhdzNlRHlpbjBsYUhSX3pCRUs3SXFUVTUNCg0KDQoNCkF0dGFjaG1lbnRzDQpOb3RlcyDi
gJMgUUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwgIA0KaHR0cHM6Ly9kb2NzLmdv
b2dsZS5jb20vZG9jdW1lbnQvZC8xLUx0cTExTEx6eENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNK
QkdRWnJlay9lZGl0DQoNCklmIHlvdSBuZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3Qg
bWU6IGFsZXguYmVubmVlQGxpbmFyby5vcmcNCg0KR3Vlc3RzDQphZmFlcmJlckBzdXNlLmRlDQpB
bGVzc2FuZHJvIERpIEZlZGVyaWNvDQpBbGV4IEJlbm7DqWUNCkFsaXN0YWlyIEZyYW5jaXMNCkFu
dG9uIEpvaGFuc3Nvbg0KYXJtYnJ1QHJlZGhhdC5jb20NCmJiYXVtYW5AcmVkaGF0LmNvbQ0KYmNh
aW5AcXVpY2luYy5jb20NCmJlcnJhbmdlQHJlZGhhdC5jb20NCkNoYW8gUGVuZw0KY2ppYUBudmlk
aWEuY29tDQpDw6lkcmljIExlIEdvYXRlcg0KY3dAZjAwZi5vcmcNCkRhbWllbiBIZWRkZQ0KZWJs
YWtlQHJlZGhhdC5jb20NCmVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbQ0KZWR1YXJkb0BoYWJrb3N0
Lm5ldA0KRWxlbmEgVWZpbXRzZXZhDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmZlbGlwZUBudXRh
bml4LmNvbQ0KaWdneUB0aGVpZ2d5LmNvbQ0KaW1wQGJzZGltcC5jb20NCmphbi5raXN6a2FAd2Vi
LmRlDQpqZ2dAbnZpZGlhLmNvbQ0Kamlkb25nLnhpYW9AZ21haWwuY29tDQpqaW0uc2h1QHNpZml2
ZS5jb20NCmpqaGVybmVAbGludXgudm5ldC5pYm0uY29tDQpKb2FvIE1hcnRpbnMNCmtvbnJhZC53
aWxrQG9yYWNsZS5jb20NCkx1YyBNaWNoZWwNCm1idXJ0b25AcXRpLnF1YWxjb21tLmNvbQ0KbWRl
YW5AcmVkaGF0LmNvbQ0KbWltdUBsaW51eC52bmV0LmlibS5jb20NCnBhdWwud2FsbXNsZXlAc2lm
aXZlLmNvbQ0KcGJvbnppbmlAcmVkaGF0LmNvbQ0KUGV0ZXIgTWF5ZGVsbA0KUmljaGFyZCBIZW5k
ZXJzb24NClNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCnNoZW50ZXlAZ21haWwuY29tDQpzdGVm
YW5oYUBnbWFpbC5jb20NCndlaS53LndhbmdAaW50ZWwuY29tDQp6Lmh1b0AxMzkuY29tDQpMSVUg
Wmhpd2VpDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KUGhpbCBNYXRoaWV1LURhdWTDqQ0KZWJsb3RA
cml2b3NpbmMuY29tDQptYXguY2hvdUBzaWZpdmUuY29tDQpxZW11LWRldmVsQG5vbmdudS5vcmcN
Ck1hbm9zIFBpdHNpZGlhbmFraXMNClZpZXcgYWxsIGd1ZXN0IGluZm8gIA0KaHR0cHM6Ly9jYWxl
bmRhci5nb29nbGUuY29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVXJmVpZD1NV2QyZFdJNU5E
TTFiemRvY25KbGJUQmhNSEpoYkc1c05XbGZVakl3TWpRd05qRXhWREV6TURBd01DQnhaVzExTFdS
bGRtVnNRRzV2Ym1kdWRTNXZjbWMmdG9rPU5UUWpZMTlyTlhBeWJIQm5kbUp3ZEdScGNtdDFOWE5w
TURGaWJHMXVhMEJuY205MWNDNWpZV3hsYm1SaGNpNW5iMjluYkdVdVkyOXRZbU0wTjJZeE1qZ3lN
RGd5TTJJd1lXVmtNVFJrTjJNM01UWTNNelkwTnpBek9UTTJZV1V3TUEmY3R6PUV1cm9wZSUyRkxv
bmRvbiZobD1lbiZlcz0wDQoNClJlcGx5IGZvciBxZW11LWRldmVsQG5vbmdudS5vcmcgYW5kIHZp
ZXcgbW9yZSBkZXRhaWxzICANCmh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci9l
dmVudD9hY3Rpb249VklFVyZlaWQ9TVdkMmRXSTVORE0xYnpkb2NuSmxiVEJoTUhKaGJHNXNOV2xm
VWpJd01qUXdOakV4VkRFek1EQXdNQ0J4WlcxMUxXUmxkbVZzUUc1dmJtZHVkUzV2Y21jJnRvaz1O
VFFqWTE5ck5YQXliSEJuZG1Kd2RHUnBjbXQxTlhOcE1ERmliRzF1YTBCbmNtOTFjQzVqWVd4bGJt
UmhjaTVuYjI5bmJHVXVZMjl0WW1NME4yWXhNamd5TURneU0ySXdZV1ZrTVRSa04yTTNNVFkzTXpZ
ME56QXpPVE0yWVdVd01BJmN0ej1FdXJvcGUlMkZMb25kb24maGw9ZW4mZXM9MA0KWW91ciBhdHRl
bmRhbmNlIGlzIG9wdGlvbmFsLg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJvbSBHb29nbGUgQ2Fs
ZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8NCg0KWW91IGFyZSBy
ZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5kZWUgb24gdGhlIGV2
ZW50LiBUbyAgDQpzdG9wIHJlY2VpdmluZyBmdXR1cmUgdXBkYXRlcyBmb3IgdGhpcyBldmVudCwg
ZGVjbGluZSB0aGlzIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3VsZCBh
bGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5pemVy
LCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNzIG9m
ICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4NCg0K
TGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIvMzcx
MzUjZm9yd2FyZGluZw0K
--000000000000b43ea6061aadbc16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!doctype html><html xmlns=3D"http://www.w3.org/1999/xhtml" xmlns:v=3D"urn:=
schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-microsoft-com:office:offi=
ce"><head><title></title><!--[if !mso]><meta http-equiv=3D"X-UA-Compatible"=
 content=3D"IE=3Dedge"><![endif]--><meta http-equiv=3D"Content-Type" conten=
t=3D"text/html; charset=3DUTF-8"><meta name=3D"viewport" content=3D"width=
=3Ddevice-width,initial-scale=3D1"><meta name=3D"color-scheme" content=3D"l=
ight dark"><meta name=3D"supported-color-schemes" content=3D"light dark">
    <style>
      body, html {
        font-family: Roboto, Helvetica, Arial, sans-serif;
      }

      body {
        margin: 0;
        padding: 0;
        -webkit-font-smoothing: antialiased;
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
      }

      #outlook a {
        padding: 0;
      }

      .ReadMsgBody {
        width: 100%;
      }

      .ExternalClass {
        width: 100%;
      }

      .ExternalClass * {
        line-height: 100%;
      }

      table,
      td {
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
      }

      img {
        border: 0;
        height: auto;
        line-height: 100%;
        outline: none;
        text-decoration: none;
        -ms-interpolation-mode: bicubic;
      }

      p {
        display: block;
        margin: 13px 0;
      }
    </style>
    <!--[if !mso]><!-->
    <style>
      @media only screen and (max-width:580px) {
        @-ms-viewport {
          width: 320px;
        }

        @viewport {
          width: 320px;
        }
      }
    </style>
    <!--<![endif]-->
    <!--[if mso]>
          <xml>
          <o:OfficeDocumentSettings>
            <o:AllowPNG/>
            <o:PixelsPerInch>96</o:PixelsPerInch>
          </o:OfficeDocumentSettings>
          </xml>
          <![endif]-->
    <!--[if lte mso 11]>
          <style>
            .outlook-group-fix { width:100% !important; }
          </style>
    <![endif]-->

    <!--[if !mso]><!-- -->
  <style>body, html {font-family:Roboto,Helvetica,Arial,sans-serif;}@font-f=
ace {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOmCnqEu92Fr1Mu4mxP.ttf) forma=
t('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmEU9fBBc9.ttf) f=
ormat('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmWUlfBBc9.ttf) f=
ormat('truetype');
}
@font-face {
  font-family: 'Material Icons Extended';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/materialiconsextended/v151/kJEjBvgX7BgnkSr=
UwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v141/Gw6kwdfw6UnXLJCcm=
afZyFRXb3BL9rvi0QZG3g.otf) format('opentype');
}

.google-material-icons {
  font-family: 'Google Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}
@font-face {
  font-family: 'Google Material Icons Filled';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v116/WWXFlimHYg6=
HKI3TavMkbKdhBmDvgach8TVpeGsuueSZJH4.otf) format('opentype');
}

.google-material-icons-filled {
  font-family: 'Google Material Icons Filled';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UaGrENHsxJlGDuGo1OIlL3Owps=
.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLU94Yt=
zCwM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLV154t=
zCwM.ttf) format('truetype');
}
</style><!--<![endif]-->
      <style>
        .body-container {
          padding-left: 16px;
          padding-right: 16px;
        }
      </style>
 =20
      <style>
        u+.body .body-container,
        body[data-outlook-cycle] .body-container,
        #MessageViewBody .body-container {
          padding-left: 0;
          padding-right: 0;
        }
      </style>
 =20
    <style>
      @media only screen and (min-width:580px) {
        .column-per-37 {
          width: 37% !important;
          max-width: 37%;
        }

        .column-per-63 {
          width: 63% !important;
          max-width: 63%;
        }
      }
    </style>
 =20
    <style>
      .appointment-buttons th {
        display: block;
        clear: both;
        float: left;
        margin-top: 12px;
      }

      .appointment-buttons th a {
        float: left;
      }

      #MessageViewBody .appointment-buttons th {
       margin-top: 24px;
      }
    </style>
 =20
    <style>
      @media only screen and (max-width:580px) {
        table.full-width-mobile {
          width: 100% !important;
        }

        td.full-width-mobile {
          width: auto !important;
        }
      }
    </style>
    <style>
      .main-container-inner,
      .info-bar-inner {
        padding: 12px 16px !important;
      }

      .main-column-table-ltr {
        padding-right: 0 !important;
      }

      .main-column-table-rtl {
        padding-left: 0 !important;
      }

      @media only screen and (min-width:580px) {
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .main-column-table-ltr {
          padding-right: 32px !important;
        }

        .main-column-table-rtl {
          padding-left: 32px !important;
        }

        .appointment-buttons th {
          display: table-cell;
          clear: none;
        }
      }

      .primary-text {
        color: #3c4043 !important;
      }

      .secondary-text,
      .phone-number a {
        color: #70757a !important;
      }

      .accent-text {
        color: #1a73e8 !important;
      }

      .accent-text-dark {
        color: #185abc !important;
      }

      .grey-button-text,
      .attachment-chip a {
        color: #5f6368 !important;
      }

      .primary-button {
        background-color: #1a73e8 !important;
      }

      .primary-button-text {
        color: #fff !important;
      }

      .underline-on-hover:hover {
        text-decoration: underline !important;
      }

      .grey-infobar-text {
        color: #202124 !important;
      }

      @media (prefers-color-scheme: dark) {
        .primary-text:not([class^=3D"x_"]) {
          color: #e8eaed !important;
        }

        .secondary-text:not([class^=3D"x_"]),
        .phone-number:not([class^=3D"x_"]) a {
          color: #9aa0a6 !important;
        }

        .grey-button-text:not([class^=3D"x_"]),
        .attachment-chip:not([class^=3D"x_"]) a {
          color: #bdc1c6 !important;
        }

        .accent-text:not([class^=3D"x_"]),
        .hairline-button-text:not([class^=3D"x_"]) {
          color: #8ab4f8 !important;
        }

        .primary-button:not([class^=3D"x_"]) {
          background-color: #8ab4f8 !important;
        }

        .primary-button-text:not([class^=3D"x_"]) {
          color: #202124 !important;
        }
      }
    </style>
    <style>
      @media (prefers-color-scheme: dark) {
        .cse-banner:not([class^=3D"x_"]) {
          background-color: #3c4043 !important; /* Google Grey 800 */
        }

        .encryption-icon:not([class^=3D"x_"]) {
          /* WARNING: This causes the whole style tag to get stripped in Gm=
ail. */
          background-image: url('https://fonts.gstatic.com/s/i/googlemateri=
aliconsfilled/encrypted/v3/gm_grey200-24dp/2x/gm_filled_encrypted_gm_grey20=
0_24dp.png') !important;
        }
      }
    </style>
    <!--[if !mso]><!-->
    <style>
      .prevent-link a {
        color: inherit !important;
        text-decoration: none !important;
        font-size: inherit !important;
        font-family: inherit !important;
        font-weight: inherit !important;
        line-height: inherit !important;
      }
    </style>
    <!--<![endif]-->

    <!--[if mso | IE]>
      <style>
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .cse-banner .encryption-icon {
          /* We use the IE workaround instead. */
          background-image: none !important;
        }

        .cse-banner .encryption-icon .ms-fallback {
          display: block !important;
        }

        /* NB: Some MS clients ignore dark-scheme styling and apply their o=
wn, so there's nothing we can do to help there. */
        @media (prefers-color-scheme: dark) {
          .cse-banner:not([class^=3D"x_"]) .encryption-icon .ms-fallback {
            display: none !important;
          }

          .cse-banner:not([class^=3D"x_"]) .encryption-icon .ms-fallback-da=
rk {
            display: block !important;
          }
        }
      </style>
    <![endif]-->
  </head><body class=3D"body"><span itemscope itemtype=3D"http://schema.org=
/InformAction"><span itemprop=3D"object" itemscope itemtype=3D"http://schem=
a.org/Event"><meta itemprop=3D"eventStatus" content=3D"http://schema.org/Ev=
entRescheduled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://=
schema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar=
"/></span><meta itemprop=3D"eventId/googleCalendar" content=3D"1gvub9435o7h=
rrem0a0ralnl5i_R20240611T130000"/><span style=3D"display: none; font-size: =
1px; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max=
-width: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develo=
pers conference call</span><meta itemprop=3D"url" content=3D"https://calend=
ar.google.com/calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbT=
BhMHJhbG5sNWlfUjIwMjQwNjExVDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=
=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUu=
Y29tYmM0N2YxMjgyMDgyM2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurope=
%2FLondon&amp;hl=3Den&amp;es=3D0"/><span aria-hidden=3D"true"><time itempro=
p=3D"startDate" datetime=3D"20240611T130000Z"></time><time itemprop=3D"endD=
ate" datetime=3D"20240611T140000Z"></time></span><div style=3D"display: non=
e; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-height: 0;=
 width: 0; max-width: 0; opacity: 0; overflow: hidden;">If you need call de=
tails, please contact me: alex.bennee@linaro.org</div><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" s=
tyle=3D"width:100%;" class=3D"body-container"><tbody><tr><td style=3D"" cla=
ss=3D"" align=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"=
height:16px;"><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true">=
 &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"c=
enter" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"background-=
color: #e6f4ea;color: #0d5327;padding: 12px 32px; border-radius: 8px;font-f=
amily: Roboto, sans-serif;font-size: 14px; line-height: 20px;text-align: le=
ft;" class=3D"info-bar-inner"><span style=3D"font-weight: 700;">This event =
has been updated</span></td></tr></tbody></table><!--[if mso | IE]><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><=
td height=3D"12" style=3D"height:12px;"><![endif]--><div style=3D"height:12=
px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table=
><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbody>=
<tr><td style=3D"border: solid 1px #dadce0; border-radius: 8px; direction: =
rtl; font-size: 0; padding: 24px 32px; text-align: left; vertical-align: to=
p;" class=3D"main-container-inner"><!--[if mso | IE]><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><![endif]--><!-=
-[if mso | IE]><td class=3D"" style=3D"vertical-align:top;width:37%;" ><![e=
ndif]--><div class=3D"column-per-37 outlook-group-fix" style=3D"font-size: =
13px; text-align: left; direction: ltr; display: inline-block; vertical-ali=
gn: top; width: 100%;overflow: hidden; word-wrap: break-word;"><table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"=
100%"><tbody><tr><td style=3D"vertical-align:top;padding:0;"><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"1=
00%"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-brea=
k: break-word;;padding-bottom:0px;"><div style=3D"font-family: Roboto, sans=
-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; t=
ext-align: left;" class=3D"primary-text" role=3D"presentation"><table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"=
padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size=
: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-=
smoothing: antialiased;margin: 0; padding: 0;">Attachments</h2></td></tr></=
table></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align=
: left; word-break: break-word;;padding-bottom:24px;padding-left: 1px; padd=
ing-right: 1px;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" ro=
le=3D"presentation" class=3D"attachment-chip" style=3D"border: solid 1px #d=
adce0; border-radius: 16px; border-collapse: separate; padding: 4px 0 4px 0=
;"><tr><td style=3D"padding: 3px 10px; height: 14px; width: 14px;"><img src=
=3D"https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.=
google-apps.document" width=3D"14" height=3D"14" alt=3D"" style=3D"display:=
 inline-block; vertical-align: middle;"></td><td align=3D"left" style=3D"pa=
dding: 0; padding-left: 0; padding-right: 10px; max-width: 160px; overflow:=
 hidden; text-overflow: ellipsis; white-space: nowrap;"><div style=3D"overf=
low: hidden; height: 20px;"><a href=3D"https://docs.google.com/document/d/1=
-Ltq11LLzxCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit" target=3D"_blank" style=
=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif=
;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: =
exactly; margin: 0; text-decoration: none; text-transform: none;;font-famil=
y: Roboto, sans-serif;; display: inline-block; height: 20px; max-width: 160=
px; line-height: 20px; overflow: hidden; text-overflow: ellipsis; vertical-=
align: middle; white-space: normal;" class=3D"grey-button-text" title=3D"No=
tes =E2=80=93 QEMU/KVM developers conference call">Notes =E2=80=93 QEMU/KVM=
 devel...</a></div></td></tr></table></td></tr></table></td></tr></tbody></=
table></div><!--[if mso | IE]></td><![endif]--><!--[if mso | IE]><td class=
=3D"" style=3D"vertical-align:top;width:63%;padding-right:32px;" ><![endif]=
--><div class=3D"column-per-63 outlook-group-fix" style=3D"font-size: 13px;=
 text-align: left; direction: ltr; display: inline-block; vertical-align: t=
op; width: 100%;overflow: hidden; word-wrap: break-word;"><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"=
 class=3D"main-column-table-ltr" style=3D"padding-right: 32px; padding-left=
: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main-column-td" style=3D=
"padding:0; vertical-align:top;"><table border=3D"0" cellpadding=3D"0" cell=
spacing=3D"0" role=3D"presentation" width=3D"100%" style=3D"table-layout: f=
ixed;"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-br=
eak: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, s=
ans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heigh=
t: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" clas=
s=3D"primary-text" role=3D"presentation"><span>If you need call details, pl=
ease contact me: <a href=3D"mailto:quintela@redhat.com" target=3D"_blank">a=
lex.bennee@linaro.org</a></span><meta itemprop=3D"description" content=3D"I=
f you need call details, please contact me: alex.bennee@linaro.org"/></div>=
</td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word=
-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto=
, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-he=
ight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" c=
lass=3D"primary-text" role=3D"presentation"><span aria-hidden=3D"true"><tim=
e itemprop=3D"startDate" datetime=3D"20240611T130000Z"></time><time itempro=
p=3D"endDate" datetime=3D"20240611T140000Z"></time></span><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"paddi=
ng-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14p=
x;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoot=
hing: antialiased;margin: 0; padding: 0;">When</h2></td></tr></table><span>=
Every 2 weeks from 14:00 to 15:00 on Tuesday (United Kingdom Time)</span></=
div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; =
word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Ro=
boto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; lin=
e-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none=
;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom:=
 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #=
3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: anti=
aliased;margin: 0; padding: 0;">Location</h2></td></tr></table><span itempr=
op=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span itempr=
op=3D"name" class=3D"primary-text notranslate" style=3D"font-family: Roboto=
, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-he=
ight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">h=
ttps://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.=
com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=
=3D1718615340000000&amp;usg=3DAOvVaw3eDyin0laHR_zBEK7IqTU5" class=3D"accent=
-text underline-on-hover" style=3D"display: inline-block;;color: #1a73e8; t=
ext-decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"map">=
View map</a></span></div></td></tr><tr><td style=3D"font-size: 0; padding: =
0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div sty=
le=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400;=
 font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; =
text-decoration: none;" class=3D"primary-text" role=3D"presentation"><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" sty=
le=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"fon=
t-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit=
-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td></tr><=
/table><div style=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;=
"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.de</a><=
/span><meta itemprop=3D"email" content=3D"afaerber@suse.de"/></span><span c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></=
span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sc=
hema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"=
primary-text underline-on-hover" style=3D"display: inline-block;;color: #3c=
4043; text-decoration: none;" href=3D"mailto:ale@rev.ng">Alessandro Di Fede=
rico</a></span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:alex.bennee@linaro.org">Al=
ex Benn=C3=A9e</a></span><meta itemprop=3D"email" content=3D"alex.bennee@li=
naro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:alist=
air.francis@wdc.com">Alistair Francis</a></span><meta itemprop=3D"email" co=
ntent=3D"alistair.francis@wdc.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:anjo@rev.ng">Anton Johansson</a></span><meta itemprop=
=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a></span><meta it=
emprop=3D"email" content=3D"armbru@redhat.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:bbauman@redhat.com">bbauman@redhat.com</a><=
/span><meta itemprop=3D"email" content=3D"bbauman@redhat.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:bcain@quicinc.com">bcain@q=
uicinc.com</a></span><meta itemprop=3D"email" content=3D"bcain@quicinc.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:berrange@redha=
t.com">berrange@redhat.com</a></span><meta itemprop=3D"email" content=3D"be=
rrange@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:chao.p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"emai=
l" content=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a></span><met=
a itemprop=3D"email" content=3D"cjia@nvidia.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:clg@kaod.org">C=C3=A9dric Le Goater</a></=
span><meta itemprop=3D"email" content=3D"clg@kaod.org"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span=
><meta itemprop=3D"email" content=3D"cw@f00f.org"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:dhedde@kalrayinc.com">Damien Hedde</a></=
span><meta itemprop=3D"email" content=3D"dhedde@kalrayinc.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.com">eblake@=
redhat.com</a></span><meta itemprop=3D"email" content=3D"eblake@redhat.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.iglesias=
@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email" con=
tent=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</a></span><meta=
 itemprop=3D"email" content=3D"eduardo@habkost.net"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufim=
tseva</a></span><meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger=
@redhat.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" conte=
nt=3D"eric.auger@redhat.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:felipe@nutanix.com">felipe@nutanix.com</a></span><meta item=
prop=3D"email" content=3D"felipe@nutanix.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></span=
><meta itemprop=3D"email" content=3D"iggy@theiggy.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>=
</span><meta itemprop=3D"email" content=3D"imp@bsdimp.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@w=
eb.de</a></span><meta itemprop=3D"email" content=3D"jan.kiszka@web.de"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:jgg@nvidia.com">j=
gg@nvidia.com</a></span><meta itemprop=3D"email" content=3D"jgg@nvidia.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:jidong.xiao@gm=
ail.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"email" content=
=3D"jidong.xiao@gmail.com"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:jim.shu@sifive.com">jim.shu@sifive.com</a></span><meta itempr=
op=3D"email" content=3D"jim.shu@sifive.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet=
.ibm.com</a></span><meta itemprop=3D"email" content=3D"jjherne@linux.vnet.i=
bm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.=
martins@oracle.com">Joao Martins</a></span><meta itemprop=3D"email" content=
=3D"joao.m.martins@oracle.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@oracle.com</a></span><m=
eta itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:luc@lmichel.fr">Luc Michel</a></=
span><meta itemprop=3D"email" content=3D"luc@lmichel.fr"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton=
@qti.qualcomm.com</a></span><meta itemprop=3D"email" content=3D"mburton@qti=
.qualcomm.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
mdean@redhat.com">mdean@redhat.com</a></span><meta itemprop=3D"email" conte=
nt=3D"mdean@redhat.com"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta=
 itemprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:paul.walmsley@sifive.com">paul.wal=
msley@sifive.com</a></span><meta itemprop=3D"email" content=3D"paul.walmsle=
y@sifive.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:p=
bonzini@redhat.com">pbonzini@redhat.com</a></span><meta itemprop=3D"email" =
content=3D"pbonzini@redhat.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></span><meta it=
emprop=3D"email" content=3D"peter.maydell@linaro.org"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:richard.henderson@linaro.org">Rich=
ard Henderson</a></span><meta itemprop=3D"email" content=3D"richard.henders=
on@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
shameerali.kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a></span><=
meta itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:shentey@gmail.com=
">shentey@gmail.com</a></span><meta itemprop=3D"email" content=3D"shentey@g=
mail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:stefa=
nha@gmail.com">stefanha@gmail.com</a></span><meta itemprop=3D"email" conten=
t=3D"stefanha@gmail.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span><meta itemp=
rop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><met=
a itemprop=3D"email" content=3D"z.huo@139.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhiwei</a=
></span><meta itemprop=3D"email" content=3D"zhiwei_liu@linux.alibaba.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail=
.com">zwu.kernel@gmail.com</a></span><meta itemprop=3D"email" content=3D"zw=
u.kernel@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:philmd@linaro.org">Phil Mathieu-Daud=C3=A9</a></span><meta itemprop=
=3D"email" content=3D"philmd@linaro.org"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:eblot@rivosinc.com">eblot@rivosinc.com</a></span>=
<meta itemprop=3D"email" content=3D"eblot@rivosinc.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:max.chou@sifive.com">max.chou@sifi=
ve.com</a></span><meta itemprop=3D"email" content=3D"max.chou@sifive.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel@nongn=
u.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" content=3D"=
qemu-devel@nongnu.org"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:manos.pitsidianakis@linaro.org">Manos Pitsidianakis</a></span><meta=
 itemprop=3D"email" content=3D"manos.pitsidianakis@linaro.org"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div></div><a href=3D"https://calendar.google.com/calendar/event?a=
ction=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNjExVDEz=
MDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1N=
XNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYmM0N2YxMjgyMDgyM2IwYWVkMTRk=
N2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0=
" style=3D"display: inline-block;;color: #1a73e8; text-decoration: none;fon=
t-weight: 700;" target=3D"_blank" class=3D"accent-text underline-on-hover">=
View all guest info</a></div></td></tr><tr><td style=3D"font-size: 0; paddi=
ng: 0; text-align: left; word-break: break-word;;padding-bottom:0px;"><div =
style=3D"color: #3c4043; text-decoration: none;;font-family: Roboto, sans-s=
erif;font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; tex=
t-align: left;" class=3D"primary-text"><div><span style=3D"font-weight: 700=
;-webkit-font-smoothing: antialiased;">RSVP</span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"> for <a class=3D"sec=
ondary-text underline-on-hover" style=3D"display: inline-block;;color: #707=
57a; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-dev=
el@nongnu.org</a> for all events in this series</span></div></div></td></tr=
><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: b=
reak-word;;padding-bottom:16px;"><div style=3D"font-family: Roboto, sans-se=
rif;font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text=
-align: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" style=3D"border-collapse: separate;"><tr><td style=3D"pad=
ding-top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP buttons -->=
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentatio=
n" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-collapse=
: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;;display:=
 inline-block;;margin-right: 12px; margin-left: 0;"><tr><td align=3D"center=
" vertical-align=3D"middle" role=3D"presentation"><span itemprop=3D"potenti=
alaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itempro=
p=3D"attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><span it=
emprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHandle=
r"><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/GE=
T"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/=
calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sN=
WlfUjIwMjQwNjExVDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=
=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUu=
Y29tYmM0N2YxMjgyMDgyM2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurope=
%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#=
39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; li=
ne-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration:=
 none; text-transform: none;" class=3D"grey-button-text" itemprop=3D"url" t=
arget=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" ro=
le=3D"presentation"><tr><td align=3D"center" role=3D"presentation" valign=
=3D"middle" style=3D"padding: 6px 0; padding-left: 16px; padding-right: 12p=
x; white-space: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.co=
m/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5=
sNWlfUjIwMjQwNjExVDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;to=
k=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGU=
uY29tYmM0N2YxMjgyMDgyM2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurop=
e%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"u=
rl" target=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D=
"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;co=
lor: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exa=
ctly; margin: 0; text-decoration: none; text-transform: none;">Yes</span><!=
--[if mso]></a><![endif]--></td></tr></table></a></span></span></span></td>=
<td align=3D"center" vertical-align=3D"middle" role=3D"presentation" style=
=3D"border-left: solid 1px #dadce0; border-right: solid 1px #dadce0;"><span=
 itemprop=3D"potentialaction" itemscope itemtype=3D"http://schema.org/RsvpA=
ction"><meta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAtten=
dance/No"/><span itemprop=3D"handler" itemscope itemtype=3D"http://schema.o=
rg/HttpActionHandler"><link itemprop=3D"method" href=3D"http://schema.org/H=
ttpRequestMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://c=
alendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bz=
docnJlbTBhMHJhbG5sNWlfUjIwMjQwNjExVDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&a=
mp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYW=
xlbmRhci5nb29nbGUuY29tYmM0N2YxMjgyMDgyM2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwM=
A&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 4=
00;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; f=
ont-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0=
; text-decoration: none; text-transform: none;" class=3D"grey-button-text" =
itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" ce=
llspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"pres=
entation" valign=3D"middle" style=3D"padding: 6px 12px; white-space: nowrap=
;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?actio=
n=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwNjExVDEzM=
DAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndm=
JwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYmM0N2YxMjgyMDgyM=
2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den=
&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank">=
<![endif]--><span class=3D"grey-button-text" style=3D"font-weight: 400;font=
-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-siz=
e: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-=
decoration: none; text-transform: none;">No</span><!--[if mso]></a><![endif=
]--></td></tr></table></a></span></span></span></td><td align=3D"center" ve=
rtical-align=3D"middle" role=3D"presentation"><span itemprop=3D"potentialac=
tion" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D=
"attendance" content=3D"http://schema.org/RsvpAttendance/Maybe"/><span item=
prop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHandler"=
><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"=
/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/ca=
lendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWl=
fUjIwMjQwNjExVDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;tok=3D=
NTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29=
tYmM0N2YxMjgyMDgyM2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurope%2F=
London&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;=
Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-=
height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: no=
ne; text-transform: none;" class=3D"grey-button-text" itemprop=3D"url" targ=
et=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation"><tr><td align=3D"center" role=3D"presentation" valign=3D"=
middle" style=3D"padding: 6px 0; padding-left: 12px; padding-right: 16px; w=
hite-space: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.com/ca=
lendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWl=
fUjIwMjQwNjExVDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;tok=3D=
NTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29=
tYmM0N2YxMjgyMDgyM2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurope%2F=
London&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" =
target=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D"fon=
t-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color:=
 #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly=
; margin: 0; text-decoration: none; text-transform: none;">Maybe</span><!--=
[if mso]></a><![endif]--></td></tr></table></a></span></span></span></td></=
tr></table><!-- More options --><a href=3D"https://calendar.google.com/cale=
ndar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIw=
MjQwNjExVDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBnd=
mJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYmM0N2YxMjgyMDgy=
M2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurope%2FLondon&amp;hl=3De=
n&amp;es=3D0" style=3D"display: inline-block;;font-weight: 400;font-family:=
 &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px;=
 line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decorati=
on: none; text-transform: none;" class=3D"grey-button-text" target=3D"_blan=
k"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presenta=
tion" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-colla=
pse: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;"><tr>=
<td align=3D"center" vertical-align=3D"middle" role=3D"presentation" style=
=3D"padding: 6px 0; padding-left: 16px; padding-right: 12px; white-space: n=
owrap;;color: #5f6367;"><!--[if mso]><a href=3D"https://calendar.google.com=
/calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWl=
fUjIwMjQwNjExVDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAy=
bHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYmM0N2YxMjg=
yMDgyM2IwYWVkMTRkN2M3MTY3MzY0NzAzOTM2YWUwMA&amp;ctz=3DEurope%2FLondon&amp;h=
l=3Den&amp;es=3D0" class=3D"grey-button-text" target=3D"_blank"><![endif]--=
><span class=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#=
39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; li=
ne-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration:=
 none; text-transform: none;">More options</span><!--[if mso]></a><![endif]=
--></td></tr></table></a></td></tr></table></div></td></tr></table></td></t=
r></tbody></table></div><!--[if mso | IE]></td><![endif]--><!--[if mso | IE=
]></tr></table><![endif]--></td></tr></tbody></table><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" st=
yle=3D"width:100%;" class=3D""><tbody><tr><td style=3D"font-size: 0; paddin=
g: 0; text-align: left; word-break: break-word;;padding:4px 12px;" class=3D=
"" align=3D"left"><div class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;font-family: Roboto, sans-serif;font-size: 12px; line-h=
eight: 16px; mso-line-height-rule: exactly; text-align: left;"><p>Invitatio=
n from <a href=3D"https://calendar.google.com/calendar/" class=3D"accent-te=
xt underline-on-hover" style=3D"font-family: Roboto, sans-serif;font-size: =
12px; line-height: 16px; mso-line-height-rule: exactly;;color: #1a73e8; tex=
t-decoration: none;" target=3D"_blank">Google Calendar</a></p><p>You are re=
ceiving this email because you are an attendee on the event. To stop receiv=
ing future updates for this event, decline this event.</p><p>Forwarding thi=
s invitation could allow any recipient to send a response to the organizer,=
 be added to the guest list, invite others regardless of their own invitati=
on status, or modify your RSVP. <a class=3D"accent-text underline-on-hover"=
 style=3D"font-family: Roboto, sans-serif;font-size: 12px; line-height: 16p=
x; mso-line-height-rule: exactly;;color: #1a73e8; text-decoration: none;" h=
ref=3D"https://support.google.com/calendar/answer/37135#forwarding">Learn m=
ore</a></p></div></td></tr></tbody></table></td></tr></tbody></table></span=
></span></body></html>
--000000000000b43ea6061aadbc16
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VTIMEZONE
TZID:America/New_York
X-LIC-LOCATION:America/New_York
BEGIN:DAYLIGHT
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
TZNAME:EDT
DTSTART:19700308T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D3;BYDAY=3D2SU
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
TZNAME:EST
DTSTART:19701101T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D11;BYDAY=3D1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTART;TZID=3DAmerica/New_York:20240611T090000
DTEND;TZID=3DAmerica/New_York:20240611T100000
RRULE:FREQ=3DWEEKLY;WKST=3DMO;INTERVAL=3D2;BYDAY=3DTU
DTSTAMP:20240612T090917Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20240611T130000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dafaerber@suse.de;X-NUM-GUESTS=3D0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlessandro Di Federico;X-NUM-GUESTS=3D0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlistair Francis;X-NUM-GUESTS=3D0:mailto:alistair.francis@wdc.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAnton Johansson;X-NUM-GUESTS=3D0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Darmbru@redhat.com;X-NUM-GUESTS=3D0:mailto:armbru@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbbauman@redhat.com;X-NUM-GUESTS=3D0:mailto:bbauman@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbcain@quicinc.com;X-NUM-GUESTS=3D0:mailto:bcain@quicinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dberrange@redhat.com;X-NUM-GUESTS=3D0:mailto:berrange@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DChao Peng;X-NUM-GUESTS=3D0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcjia@nvidia.com;X-NUM-GUESTS=3D0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:clg@kaod.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcw@f00f.org;X-NUM-GUESTS=3D0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3DDamien Hedde;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deblake@redhat.com;X-NUM-GUESTS=3D0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dedgar.iglesias@gmail.com;X-NUM-GUESTS=3D0:mailto:edgar.iglesias@=
gmail
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Deduardo@habkost.net;X-NUM-GUESTS=3D0:mailto:eduardo@habkost.net
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DElena Ufimtseva;X-NUM-GUESTS=3D0:mailto:elena.ufimtseva@oracle.c=
om
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deric.auger@redhat.com;X-NUM-GUESTS=3D0:mailto:eric.auger@redhat.=
com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dfelipe@nutanix.com;X-NUM-GUESTS=3D0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Diggy@theiggy.com;X-NUM-GUESTS=3D0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dimp@bsdimp.com;X-NUM-GUESTS=3D0:mailto:imp@bsdimp.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djan.kiszka@web.de;X-NUM-GUESTS=3D0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djgg@nvidia.com;X-NUM-GUESTS=3D0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djidong.xiao@gmail.com;X-NUM-GUESTS=3D0:mailto:jidong.xiao@gmail.=
com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djim.shu@sifive.com;X-NUM-GUESTS=3D0:mailto:jim.shu@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Djjherne@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:jjherne@linux=
.vnet
 .ibm.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DJoao Martins;X-NUM-GUESTS=3D0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dkonrad.wilk@oracle.com;X-NUM-GUESTS=3D0:mailto:konrad.wilk@oracl=
e.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DLuc Michel;X-NUM-GUESTS=3D0:mailto:luc@lmichel.fr
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmburton@qti.qualcomm.com;X-NUM-GUESTS=3D0:mailto:mburton@qti.qua=
lcomm
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dmdean@redhat.com;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmimu@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:mimu@linux.vnet.=
ibm.c
 om
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dpaul.walmsley@sifive.com;X-NUM-GUESTS=3D0:mailto:paul.walmsley@sifi=
ve.co
 m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dpbonzini@redhat.com;X-NUM-GUESTS=3D0:mailto:pbonzini@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DPeter Maydell;X-NUM-GUESTS=3D0:mailto:peter.maydell@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DRichard Henderson;X-NUM-GUESTS=3D0:mailto:richard.henderson@lina=
ro.or
 g
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DShameerali Kolothum Thodi;X-NUM-GUESTS=3D0:mailto:shameerali.kol=
othum
 .thodi@huawei.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dshentey@gmail.com;X-NUM-GUESTS=3D0:mailto:shentey@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dstefanha@gmail.com;X-NUM-GUESTS=3D0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dwei.w.wang@intel.com;X-NUM-GUESTS=3D0:mailto:wei.w.wang@intel.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dz.huo@139.com;X-NUM-GUESTS=3D0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DLIU Zhiwei;X-NUM-GUESTS=3D0:mailto:zhiwei_liu@linux.alibaba.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dzwu.kernel@gmail.com;X-NUM-GUESTS=3D0:mailto:zwu.kernel@gmail.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:philmd@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Deblot@rivosinc.com;X-NUM-GUESTS=3D0:mailto:eblot@rivosinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmax.chou@sifive.com;X-NUM-GUESTS=3D0:mailto:max.chou@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dqemu-devel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.=
org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DManos Pitsidianakis;X-NUM-GUESTS=3D0:mailto:manos.pitsidianakis@=
linar
 o.org
X-MICROSOFT-CDO-OWNERAPPTID:-1287337024
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20240612T090905Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:QEMU/KVM developers conference call
TRANSP:OPAQUE
ATTACH;FILENAME=3DNotes =E2=80=93 QEMU/KVM developers conference call;FMTTY=
PE=3Dapplica
 tion/vnd.google-apps.document:https://docs.google.com/document/d/1-Ltq11LL=
z
 xCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit
BEGIN:VALARM
ACTION:EMAIL
DESCRIPTION:This is an event reminder
SUMMARY:Alarm notification
ATTENDEE:mailto:qemu-devel@nongnu.org
TRIGGER:-P2D
END:VALARM
END:VEVENT
END:VCALENDAR

--000000000000b43ea6061aadbc16--

--000000000000b43ea8061aadbc18
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VlRJTUVaT05FDQpUWklEOkFtZXJpY2EvTmV3X1lvcmsNClgtTElDLUxPQ0FUSU9O
OkFtZXJpY2EvTmV3X1lvcmsNCkJFR0lOOkRBWUxJR0hUDQpUWk9GRlNFVEZST006LTA1MDANClRa
T0ZGU0VUVE86LTA0MDANClRaTkFNRTpFRFQNCkRUU1RBUlQ6MTk3MDAzMDhUMDIwMDAwDQpSUlVM
RTpGUkVRPVlFQVJMWTtCWU1PTlRIPTM7QllEQVk9MlNVDQpFTkQ6REFZTElHSFQNCkJFR0lOOlNU
QU5EQVJEDQpUWk9GRlNFVEZST006LTA0MDANClRaT0ZGU0VUVE86LTA1MDANClRaTkFNRTpFU1QN
CkRUU1RBUlQ6MTk3MDExMDFUMDIwMDAwDQpSUlVMRTpGUkVRPVlFQVJMWTtCWU1PTlRIPTExO0JZ
REFZPTFTVQ0KRU5EOlNUQU5EQVJEDQpFTkQ6VlRJTUVaT05FDQpCRUdJTjpWRVZFTlQNCkRUU1RB
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjQwNjExVDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjQwNjExVDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztJ
TlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjQwNjEyVDA5MDkxN1oNCk9SR0FOSVpFUjtD
Tj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJrdTVzaTAxYmxt
bmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjFndnViOTQzNW83aHJyZW0wYTBy
YWxubDVpX1IyMDI0MDYxMVQxMzAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1hZmFlcmJlckBzdXNlLmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphZmFlcmJlckBz
dXNlLmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUFsZXNzYW5kcm8gRGkgRmVkZXJp
Y287WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsZUByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsZXguYmVubmVlQGxpbmFyby5vcmcNCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049QWxpc3RhaXIgRnJhbmNpcztYLU5VTS1HVUVTVFM9MDpt
YWlsdG86YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPUFudG9uIEpvaGFuc3NvbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcNCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YXJtYnJ1QHJlZGhhdC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmFybWJydUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PWJiYXVtYW5AcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YmJhdW1hbkByZWRoYXQu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWJjYWluQHF1aWNpbmMuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzpiY2FpbkBxdWljaW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1iZXJyYW5nZUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpiZXJyYW5n
ZUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUNoYW8gUGVuZztYLU5V
TS1HVUVTVFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50ZWwuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPWNqaWFAbnZpZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
Y2ppYUBudmlkaWEuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpjbGdAa2FvZC5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Y3dAZjAw
Zi5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmN3QGYwMGYub3JnDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRS
VUUNCiA7Q049RGFtaWVuIEhlZGRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpkaGVkZGVAa2FscmF5
aW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lYmxha2VAcmVkaGF0LmNvbTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86ZWJsYWtlQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzplZGdhci5pZ2xlc2lhc0BnbWFpbA0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049
ZWR1YXJkb0BoYWJrb3N0Lm5ldDtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWR1YXJkb0BoYWJrb3N0
Lm5ldA0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1FbGVuYSBVZmltdHNldmE7WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPWVyaWMuYXVnZXJAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWls
dG86ZXJpYy5hdWdlckByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWZl
bGlwZUBudXRhbml4LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZmVsaXBlQG51dGFuaXguY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWlnZ3lAdGhlaWdneS5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmlnZ3lAdGhlaWdneS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049aW1wQGJzZGltcC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWphbi5raXN6a2FAd2ViLmRlO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpqYW4ua2lzemthQHdlYi5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1qZ2dAbnZpZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amdnQG52aWRpYS5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amlkb25nLnhpYW9AZ21haWwuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzpqaWRvbmcueGlhb0BnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049amltLnNodUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqaW0uc2h1
QHNpZml2ZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ampoZXJuZUBsaW51eC52
bmV0LmlibS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpqaGVybmVAbGludXgudm5ldA0KIC5p
Ym0uY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUpvYW8gTWFydGlucztYLU5VTS1H
VUVTVFM9MDptYWlsdG86am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1rb25yYWQud2lsa0BvcmFjbGUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzprb25yYWQud2lsa0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUx1
YyBNaWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmx1Y0BsbWljaGVsLmZyDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPW1idXJ0b25AcXRpLnF1YWxjb21tLmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86bWJ1cnRvbkBxdGkucXVhbGNvbW0NCiAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUN
CiA7Q049bWRlYW5AcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWRlYW5AcmVkaGF0
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1taW11QGxpbnV4LnZuZXQuaWJtLmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWltdUBsaW51eC52bmV0LmlibS5jDQogb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRB
VElWRTtSU1ZQPVRSVQ0KIEU7Q049cGF1bC53YWxtc2xleUBzaWZpdmUuY29tO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpwYXVsLndhbG1zbGV5QHNpZml2ZS5jbw0KIG0NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049cGJvbnppbmlAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGJv
bnppbmlAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1QZXRlciBNYXlk
ZWxsO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049UmljaGFyZCBIZW5kZXJzb247WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcg0KIGcNCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049U2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaTtYLU5VTS1HVUVTVFM9MDptYWls
dG86c2hhbWVlcmFsaS5rb2xvdGh1bQ0KIC50aG9kaUBodWF3ZWkuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJVkU7UlNW
UD1UUlUNCiBFO0NOPXNoZW50ZXlAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzaGVu
dGV5QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO1JTVlA9VFJVDQogRTtDTj1zdGVmYW5oYUBnbWFpbC5j
b207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnN0ZWZhbmhhQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O1JTVlA9DQogVFJVRTtDTj13ZWkudy53YW5nQGludGVsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWls
dG86d2VpLncud2FuZ0BpbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ei5o
dW9AMTM5LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ei5odW9AMTM5LmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1MSVUgWmhpd2VpO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6aGl3
ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXp3
dS5rZXJuZWxAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6d3Uua2VybmVsQGdtYWls
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGhp
bG1kQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049ZWJsb3RAcml2b3NpbmMu
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxvdEByaXZvc2luYy5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049bWF4LmNob3VAc2lmaXZlLmNvbTtYLU5VTS1HVUVTVFM9MDptYWls
dG86bWF4LmNob3VAc2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1xZW11
LWRldmVsQG5vbmdudS5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnFlbXUtZGV2ZWxAbm9uZ251
Lm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1NYW5vcyBQaXRzaWRpYW5ha2lzO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzptYW5vcy5waXRzaWRpYW5ha2lzQGxpbmFyDQogby5vcmcNClgt
TUlDUk9TT0ZULUNETy1PV05FUkFQUFRJRDotMTI4NzMzNzAyNA0KQ1JFQVRFRDoyMDIzMDIyMVQx
NTM5NTBaDQpERVNDUklQVElPTjpJZiB5b3UgbmVlZCBjYWxsIGRldGFpbHNcLCBwbGVhc2UgY29u
dGFjdCBtZTogPGEgaHJlZj0ibWFpbHRvOnENCiB1aW50ZWxhQHJlZGhhdC5jb20iPmFsZXguYmVu
bmVlQGxpbmFyby5vcmc8L2E+DQpMQVNULU1PRElGSUVEOjIwMjQwNjEyVDA5MDkwNVoNCkxPQ0FU
SU9OOmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcNClNFUVVFTkNFOjANClNUQVRV
UzpDT05GSVJNRUQNClNVTU1BUlk6UUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwN
ClRSQU5TUDpPUEFRVUUNCkFUVEFDSDtGSUxFTkFNRT1Ob3RlcyDigJMgUUVNVS9LVk0gZGV2ZWxv
cGVycyBjb25mZXJlbmNlIGNhbGw7Rk1UVFlQRT1hcHBsaWNhDQogdGlvbi92bmQuZ29vZ2xlLWFw
cHMuZG9jdW1lbnQ6aHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xLUx0cTExTEx6
DQogeENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNKQkdRWnJlay9lZGl0DQpCRUdJTjpWQUxBUk0N
CkFDVElPTjpFTUFJTA0KREVTQ1JJUFRJT046VGhpcyBpcyBhbiBldmVudCByZW1pbmRlcg0KU1VN
TUFSWTpBbGFybSBub3RpZmljYXRpb24NCkFUVEVOREVFOm1haWx0bzpxZW11LWRldmVsQG5vbmdu
dS5vcmcNClRSSUdHRVI6LVAyRA0KRU5EOlZBTEFSTQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxFTkRB
Ug0K
--000000000000b43ea8061aadbc18--

