Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A163D3B7ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 14:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyFL-00050A-K1; Tue, 09 Dec 2025 08:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSyFB-0004sg-Qg
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:59:11 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSyF7-00048u-K0
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:59:08 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-477a0ddd1d4so32918025e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765288744; x=1765893544; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Q0edg5WuId+SM77O/Nhjca9RBVykzndTU1RKeh3wiw=;
 b=4EuIiGnE/ejuWYRNcJ/EFkft6x3kyeOlgvtTNxYvbOIFWE8hC2upvCU/RGs2bWRL2t
 QwrXWaUrxj0m15pNQEskAyzogtUxgHIzTsTh1YRK3OVD3poUaKbRNmR5Ew6i9sXFKz2q
 vwGhyiMPGdE4dL/0VAYdniAM55gJHoUMCmvy4Ha2BGUKn2CDCaL5dG+SOR57D46iGJfm
 Sya1zSjNGs23mbtiqVmMhpEdBVL8Rhw1wZq8i/FkpIzqaVirDWU23Auzkyh+buhAe11g
 uj6Ke8tMe93V4ZV9Uu8yQEqjBnIinoHvX5Yc6uzOZJH1zj0i+k2kvT51QDdxxlvLKW9c
 LVug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765288744; x=1765893544; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Q0edg5WuId+SM77O/Nhjca9RBVykzndTU1RKeh3wiw=;
 b=X5iJODQxkwHEzZFYBeHdYAKLNovZc/M4DF+Wxllj7OU6eYnRQ5uzuS0przOJ9wY49u
 1LJmMMx90j4Y26bRNb1uXTpf9HHelKGHhYZEPQva9ukZGWAD23filBDqr3KXJO81W3yS
 QI3psxV8a4WwffQJsGYnQ4y9zWOPPjIu6qA/9i1CWxL9hUF2CNIzcvIawwzu/K/ZEQF8
 nlCeM5yubppLvTZMebnC0WkCPb7hvJx6IyTLrOKEzfJhYTpIt8g0AfHR3pvKpEwQkKZd
 PDtr0dnzVyu54zfrPHakXfva6+Uuh/Yq4I/ARsO4Jx9cUSPUGftvYSsWFRbaLKCfD2FV
 rxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765288744; x=1765893544;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Q0edg5WuId+SM77O/Nhjca9RBVykzndTU1RKeh3wiw=;
 b=UUevqSGnc2Ho8tGVLknES3uM+4VZB1JsdX/0WifKmqdIwsoU6G9YFoo7BkTVrP7EYL
 UwxlCm4TyEO4Isc8KSLgDkrjUODqWmbVn0qLflb/QmfrkBhIgxY+tVWXOA0ZgpP3r6vf
 njGrAYvlp+YvqWqH6LsL8ec68VS9z2Uou8NmN4hqMQFuM8M9vdJOREG0ac3oPPncINFJ
 ZPH4RFb7v6bU70N5XQW9Xu8E+zuD2tXAtSSOq6cmcZKqQP9P4Rlm3XhDZ0b48FrS3ise
 mnQNRjgtpEbR5T6k51UOTfGFXvR+kCuOzJ0hZVas1jmfRh1Ba81H5YdmBv0Pxeov1Jtg
 cjOg==
X-Gm-Message-State: AOJu0Yw2ZBKMWPrP59+E9kpvbKmrDYwMRQYag4hpWWSDsx3hkVD0oQxN
 9xsOfI+gNtHeEPrqlw/ihTroudUgprgYtk8/MeK0H0/CCQ5wqW2KMo8wC9HWDT9NP/yBEUY62Uu
 em9YiByXLFENXWe22N/COpBBqS5rz9I9f+CKsb+OOLiLiWEy9xK6alw==
X-Google-Smtp-Source: AGHT+IHiEE7LrGOtE/JMlgbt0hjlqGCocd/82F/1zDOZM7UeVg3hD3AetzEAm6XvO5FlcWWZ1/xu6NrcY3eUhBHxi+Cc
MIME-Version: 1.0
X-Received: by 2002:a05:600c:8b65:b0:477:af07:dd21 with SMTP id
 5b1f17b1804b1-47939e38315mr125234975e9.25.1765288743897; Tue, 09 Dec 2025
 05:59:03 -0800 (PST)
Message-ID: <calendar-b6bbbc81-6a1f-469e-a843-8ce011dbeffa@google.com>
Date: Tue, 09 Dec 2025 13:59:03 +0000
Subject: Updated invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 14:00 to 15:00 on Tuesday (GMT) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, armbru@redhat.com, bcain@quicinc.com, 
 berrange@redhat.com, cjia@nvidia.com, cw@f00f.org, eblake@redhat.com, 
 edgar.iglesias@gmail.com, eduardo@habkost.net, felipe@nutanix.com, 
 iggy@theiggy.com, imp@bsdimp.com, jgg@nvidia.com, jidong.xiao@gmail.com, 
 jim.shu@sifive.com, mburton@qti.qualcomm.com, mdean@redhat.com, 
 paul.walmsley@sifive.com, pbonzini@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 shentey@gmail.com, stefanha@gmail.com, wei.w.wang@intel.com, 
 zwu.kernel@gmail.com, =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 eblot@rivosinc.com, max.chou@sifive.com, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, thuth@redhat.com,
 rbc@meta.com, 
 demiobenour@gmail.com, hi@alyssa.is, dhedde@kalrayinc.com, afaria@redhat.com, 
 aesteve@redhat.com, marcandre.lureau@gmail.com, 
 Alistair Francis <alistair.francis@wdc.com>, konrad.wilk@oracle.com, 
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Anton Johansson <anjo@rev.ng>, Chao Peng <chao.p.peng@linux.intel.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 jan.kiszka@web.de, 
 Joao Martins <joao.m.martins@oracle.com>, Luc Michel <luc@lmichel.fr>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, nelson.ho@windriver.com
Content-Type: multipart/mixed; boundary="000000000000819ec60645855040"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x34a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Reply-To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000819ec60645855040
Content-Type: multipart/alternative; boundary="000000000000819ec5064585503e"

--000000000000819ec5064585503e
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQpDaGFuZ2VkOiB0aW1lDQoNCg0KUUVNVS9LVk0g
ZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwNCkV2ZXJ5IDIgd2Vla3MgZnJvbSAxNDowMCB0byAx
NTowMCBvbiBUdWVzZGF5DQpVbml0ZWQgS2luZ2RvbSBUaW1lDQoNCkxvY2F0aW9uDQpodHRwczov
L21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS91cmw/
cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcmc2E9RCZzb3VyY2U9
Y2FsZW5kYXImdXN0PTE3NjU3MjA3NDAwMDAwMDAmdXNnPUFPdlZhdzFKaklmeEdmd21IaHg1V3Nn
OTloNnMNCg0KDQoNCkF0dGFjaG1lbnRzDQpOb3RlcyDigJMgUUVNVS9LVk0gZGV2ZWxvcGVycyBj
b25mZXJlbmNlIGNhbGwgIA0KaHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xLUx0
cTExTEx6eENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNKQkdRWnJlay9lZGl0DQoNCklmIHlvdSBu
ZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3QgbWU6IGFsZXguYmVubmVlQGxpbmFyby5v
cmcNCg0KR3Vlc3RzDQpBbGV4IEJlbm7DqWUgLSBjcmVhdG9yDQphcm1icnVAcmVkaGF0LmNvbQ0K
YmNhaW5AcXVpY2luYy5jb20NCmJlcnJhbmdlQHJlZGhhdC5jb20NCmNqaWFAbnZpZGlhLmNvbQ0K
Y3dAZjAwZi5vcmcNCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20N
CmVkdWFyZG9AaGFia29zdC5uZXQNCmZlbGlwZUBudXRhbml4LmNvbQ0KaWdneUB0aGVpZ2d5LmNv
bQ0KaW1wQGJzZGltcC5jb20NCmpnZ0BudmlkaWEuY29tDQpqaWRvbmcueGlhb0BnbWFpbC5jb20N
CmppbS5zaHVAc2lmaXZlLmNvbQ0KbWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tDQptZGVhbkByZWRo
YXQuY29tDQpwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20NCnBib256aW5pQHJlZGhhdC5jb20NClBl
dGVyIE1heWRlbGwNClJpY2hhcmQgSGVuZGVyc29uDQpzaGVudGV5QGdtYWlsLmNvbQ0Kc3RlZmFu
aGFAZ21haWwuY29tDQp3ZWkudy53YW5nQGludGVsLmNvbQ0Kend1Lmtlcm5lbEBnbWFpbC5jb20N
ClBoaWwgTWF0aGlldS1EYXVkw6kNCmVibG90QHJpdm9zaW5jLmNvbQ0KbWF4LmNob3VAc2lmaXZl
LmNvbQ0KTWFub3MgUGl0c2lkaWFuYWtpcw0KdGh1dGhAcmVkaGF0LmNvbQ0KcmJjQG1ldGEuY29t
DQpkZW1pb2Jlbm91ckBnbWFpbC5jb20NCmhpQGFseXNzYS5pcw0KZGhlZGRlQGthbHJheWluYy5j
b20NCmFmYXJpYUByZWRoYXQuY29tDQphZXN0ZXZlQHJlZGhhdC5jb20NCm1hcmNhbmRyZS5sdXJl
YXVAZ21haWwuY29tDQpBbGlzdGFpciBGcmFuY2lzDQprb25yYWQud2lsa0BvcmFjbGUuY29tDQpB
bGVzc2FuZHJvIERpIEZlZGVyaWNvDQpDw6lkcmljIExlIEdvYXRlcg0KQW50b24gSm9oYW5zc29u
DQpDaGFvIFBlbmcNCkVsZW5hIFVmaW10c2V2YQ0KZXJpYy5hdWdlckByZWRoYXQuY29tDQpqYW4u
a2lzemthQHdlYi5kZQ0KSm9hbyBNYXJ0aW5zDQpMdWMgTWljaGVsDQpTaGFtZWVyYWxpIEtvbG90
aHVtIFRob2RpDQp6Lmh1b0AxMzkuY29tDQpMSVUgWmhpd2VpDQpxZW11LWRldmVsQG5vbmdudS5v
cmcNCm5lbHNvbi5ob0B3aW5kcml2ZXIuY29tDQpWaWV3IGFsbCBndWVzdCBpbmZvICANCmh0dHBz
Oi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249VklFVyZlaWQ9TTNS
dGJqVXhkak5oY0RGd2EySmxjV28wWkdsMmRXZzBObU1nY1dWdGRTMWtaWFpsYkVCdWIyNW5iblV1
YjNKbiZ0b2s9TlRRalkxOXJOWEF5YkhCbmRtSndkR1JwY210MU5YTnBNREZpYkcxdWEwQm5jbTkx
Y0M1allXeGxibVJoY2k1bmIyOW5iR1V1WTI5dE1HTTVZamMyT1RrM09XUTRZMkpqTVRRM1pqVTFP
VGs0WXpObE1UY3laamhoWW1VeU5XVTVZUSZjdHo9RXVyb3BlJTJGTG9uZG9uJmhsPWVuJmVzPTAN
Cg0KUmVwbHkgZm9yIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyBhbmQgdmlldyBtb3JlIGRldGFpbHMg
IA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVX
JmVpZD1NM1J0YmpVeGRqTmhjREZ3YTJKbGNXbzBaR2wyZFdnME5tTWdjV1Z0ZFMxa1pYWmxiRUJ1
YjI1bmJuVXViM0puJnRvaz1OVFFqWTE5ck5YQXliSEJuZG1Kd2RHUnBjbXQxTlhOcE1ERmliRzF1
YTBCbmNtOTFjQzVqWVd4bGJtUmhjaTVuYjI5bmJHVXVZMjl0TUdNNVlqYzJPVGszT1dRNFkySmpN
VFEzWmpVMU9UazRZek5sTVRjeVpqaGhZbVV5TldVNVlRJmN0ej1FdXJvcGUlMkZMb25kb24maGw9
ZW4mZXM9MA0KWW91ciBhdHRlbmRhbmNlIGlzIG9wdGlvbmFsLg0KDQp+fi8vfn4NCkludml0YXRp
b24gZnJvbSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxl
bmRhci8NCg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4g
YXR0ZW5kZWUgb24gdGhlIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3Vs
ZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5p
emVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNz
IG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4N
Cg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIv
MzcxMzUjZm9yd2FyZGluZw0K
--000000000000819ec5064585503e
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
  font-stretch: normal;
  src: url(//fonts.gstatic.com/s/roboto/v48/KFOMCnqEu92Fr1ME7kSn66aGLdTylUA=
MQXC89YmC2DPNWubEbVmUiA8.ttf) format('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  font-stretch: normal;
  src: url(//fonts.gstatic.com/s/roboto/v48/KFOMCnqEu92Fr1ME7kSn66aGLdTylUA=
MQXC89YmC2DPNWub2bVmUiA8.ttf) format('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-stretch: normal;
  src: url(//fonts.gstatic.com/s/roboto/v48/KFOMCnqEu92Fr1ME7kSn66aGLdTylUA=
MQXC89YmC2DPNWuYjalmUiA8.ttf) format('truetype');
}
@font-face {
  font-family: 'Material Icons Extended';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/materialiconsextended/v154/kJEjBvgX7BgnkSr=
UwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v144/Gw6kwdfw6UnXLJCcm=
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
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v118/WWXFlimHYg6=
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
"/></span><meta itemprop=3D"eventId/googleCalendar" content=3D"3tmn51v3ap1p=
kbeqj4divuh46c"/><span style=3D"display: none; font-size: 1px; color: #fff;=
 line-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacit=
y: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM developers conference c=
all</span><meta itemprop=3D"url" content=3D"https://calendar.google.com/cal=
endar/event?action=3DVIEW&amp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0NmMgcWV=
tdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1=
ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4YzNlMT=
cyZjhhYmUyNWU5YQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0"/><span a=
ria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20260106T14000=
0Z"></time><time itemprop=3D"endDate" datetime=3D"20260106T150000Z"></time>=
</span><div style=3D"display: none; font-size: 1px; color: #fff; line-heigh=
t: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; overf=
low: hidden;">If you need call details, please contact me: alex.bennee@lina=
ro.org</div><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D=
"presentation" align=3D"center" style=3D"width:100%;" class=3D"body-contain=
er"><tbody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if mso | IE]><=
table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation=
"><tr><td height=3D"16" style=3D"height:16px;"><![endif]--><div style=3D"he=
ight:16px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr>=
</table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"=
 role=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><t=
body><tr><td style=3D"background-color: #e6f4ea;color: #0d5327;padding: 12p=
x 32px; border-radius: 8px;font-family: Roboto, sans-serif;font-size: 14px;=
 line-height: 20px;text-align: left;" class=3D"info-bar-inner"><span style=
=3D"font-weight: 700;">This event has been updated</span><br/><span style=
=3D"display:none" itemprop=3D"about" itemscope itemtype=3D"http://schema.or=
g/Thing/Clock"><meta itemprop=3D"description" content=3D"Time updated"/></s=
pan><div style=3D""><span style=3D"font-weight: 700;">Changed:</span> time<=
/div></td></tr></tbody></table><!--[if mso | IE]><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"12" s=
tyle=3D"height:12px;"><![endif]--><div style=3D"height:12px;" aria-hidden=
=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"b=
order: solid 1px #dadce0; border-radius: 8px; direction: rtl; font-size: 0;=
 padding: 24px 32px; text-align: left; vertical-align: top;" class=3D"main-=
container-inner"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" ce=
llspacing=3D"0" role=3D"presentation"><tr><![endif]--><!--[if mso | IE]><td=
 class=3D"" style=3D"vertical-align:top;width:37%;" ><![endif]--><div class=
=3D"column-per-37 outlook-group-fix" style=3D"font-size: 13px; text-align: =
left; direction: ltr; display: inline-block; vertical-align: top; width: 10=
0%;overflow: hidden; word-wrap: break-word;"><table border=3D"0" cellpaddin=
g=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"><tbody><tr><=
td style=3D"vertical-align:top;padding:0;"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"><tr><td style=
=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;pad=
ding-bottom:0px;"><div style=3D"font-family: Roboto, sans-serif;font-size: =
14px; line-height: 20px; mso-line-height-rule: exactly; text-align: left;" =
class=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpaddin=
g=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4p=
x;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4=
043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antiali=
ased;margin: 0; padding: 0;">Attachments</h2></td></tr></table></div></td><=
/tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break=
: break-word;;padding-bottom:24px;padding-left: 1px; padding-right: 1px;"><=
table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation=
" class=3D"attachment-chip" style=3D"border: solid 1px #dadce0; border-radi=
us: 16px; border-collapse: separate; padding: 4px 0 4px 0;"><tr><td style=
=3D"padding: 3px 10px; height: 14px; width: 14px;"><img src=3D"https://driv=
e-thirdparty.googleusercontent.com/16/type/application/vnd.google-apps.docu=
ment" width=3D"14" height=3D"14" alt=3D"" style=3D"display: inline-block; v=
ertical-align: middle;"></td><td align=3D"left" style=3D"padding: 0; paddin=
g-left: 0; padding-right: 10px; max-width: 160px; overflow: hidden; text-ov=
erflow: ellipsis; white-space: nowrap;"><div style=3D"overflow: hidden; hei=
ght: 20px;"><a href=3D"https://docs.google.com/document/d/1-Ltq11LLzxCccfqf=
NNKcMG74HMUJf6DURmSJBGQZrek/edit" target=3D"_blank" style=3D"font-weight: 4=
00;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; f=
ont-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0=
; text-decoration: none; text-transform: none;;font-family: Roboto, sans-se=
rif;; display: inline-block; height: 20px; max-width: 160px; line-height: 2=
0px; overflow: hidden; text-overflow: ellipsis; vertical-align: middle; whi=
te-space: normal;" class=3D"grey-button-text" title=3D"Notes =E2=80=93 QEMU=
/KVM developers conference call">Notes =E2=80=93 QEMU/KVM devel...</a></div=
></td></tr></table></td></tr></table></td></tr></tbody></table></div><!--[i=
f mso | IE]></td><![endif]--><!--[if mso | IE]><td class=3D"" style=3D"vert=
ical-align:top;width:63%;padding-right:32px;" ><![endif]--><div class=3D"co=
lumn-per-63 outlook-group-fix" style=3D"font-size: 13px; text-align: left; =
direction: ltr; display: inline-block; vertical-align: top; width: 100%;ove=
rflow: hidden; word-wrap: break-word;"><table border=3D"0" cellpadding=3D"0=
" cellspacing=3D"0" role=3D"presentation" width=3D"100%" class=3D"main-colu=
mn-table-ltr" style=3D"padding-right: 32px; padding-left: 0;;table-layout: =
fixed;"><tbody><tr><td class=3D"main-column-td" style=3D"padding:0; vertica=
l-align:top;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" width=3D"100%" style=3D"table-layout: fixed;"><tr><td sty=
le=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;p=
adding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-sty=
le: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-sp=
acing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text"=
 role=3D"presentation"><span>If you need call details, please contact me: <=
a href=3D"mailto:quintela@redhat.com" target=3D"_blank">alex.bennee@linaro.=
org</a></span><meta itemprop=3D"description" content=3D"If you need call de=
tails, please contact me: alex.bennee@linaro.org"/></div></td></tr><tr><td =
style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word=
;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-=
style: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter=
-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-te=
xt" role=3D"presentation"><span aria-hidden=3D"true"><time itemprop=3D"star=
tDate" datetime=3D"20260106T140000Z"></time><time itemprop=3D"endDate" date=
time=3D"20260106T150000Z"></time></span><table border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><=
tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; =
text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;=
margin: 0; padding: 0;">When</h2></td><td style=3D"width: 8px;"></td><td st=
yle=3D"padding-top: 2px; padding-bottom: 3px;"><div style=3D"background-col=
or: #1e8e3e; border-radius: 10px; padding: 1px 5px; line-height: 13px;"><sp=
an style=3D"color: white; font-size: 11px; font-weight: 700; letter-spacing=
: 0.8px; text-transform: uppercase; vertical-align: top;">CHANGED</span></d=
iv></td></tr></table><span>Every 2 weeks from 14:00 to 15:00 on Tuesday (Un=
ited Kingdom Time)</span></div></td></tr><tr><td style=3D"font-size: 0; pad=
ding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><d=
iv style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight=
: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c=
4043; text-decoration: none;" class=3D"primary-text" role=3D"presentation">=
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentatio=
n" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=
=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;=
-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Location</h2></=
td></tr></table><span itemprop=3D"location" itemscope itemtype=3D"http://sc=
hema.org/Place"><span itemprop=3D"name" class=3D"primary-text notranslate" =
style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 4=
00; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c404=
3; text-decoration: none;">https://meet.jit.si/kvmcallmeeting</span><br/><a=
 href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcall=
meeting&amp;sa=3DD&amp;source=3Dcalendar&amp;ust=3D1765720740000000&amp;usg=
=3DAOvVaw1JjIfxGfwmHhx5Wsg99h6s" class=3D"accent-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #1a73e8; text-decoration: none;font-w=
eight: 700;" target=3D"_blank" itemprop=3D"map">View map</a></span></div></=
td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-b=
reak: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, =
sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heig=
ht: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" cla=
ss=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px=
;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c40=
43; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialia=
sed;margin: 0; padding: 0;">Guests</h2></td></tr></table><div style=3D"padd=
ing-bottom: 4px; text-align: left;;color: #3c4042;"><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:alex.bennee@linaro.org">Alex Benn=C3=A9e</a></span><meta itempro=
p=3D"email" content=3D"alex.bennee@linaro.org"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"> - creator</spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a></span><meta itemprop=3D"email" content=3D"armbru@redhat.com"/></spa=
n><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"=
http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;c=
olor: #3c4043; text-decoration: none;" href=3D"mailto:bcain@quicinc.com">bc=
ain@quicinc.com</a></span><meta itemprop=3D"email" content=3D"bcain@quicinc=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:berrange@=
redhat.com">berrange@redhat.com</a></span><meta itemprop=3D"email" content=
=3D"berrange@redhat.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a></span><meta itemprop=3D"ema=
il" content=3D"cjia@nvidia.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"email=
" content=3D"cw@f00f.org"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:eblake@redhat.com">eblake@redhat.com</a></span><meta itemprop=3D=
"email" content=3D"eblake@redhat.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</=
a></span><meta itemprop=3D"email" content=3D"edgar.iglesias@gmail.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:eduardo@habkost.n=
et">eduardo@habkost.net</a></span><meta itemprop=3D"email" content=3D"eduar=
do@habkost.net"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:felipe@nutanix.com">felipe@nutanix.com</a></span><meta itemprop=3D"email" =
content=3D"felipe@nutanix.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></span><meta itemprop=
=3D"email" content=3D"iggy@theiggy.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a></span><meta ite=
mprop=3D"email" content=3D"imp@bsdimp.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta =
itemprop=3D"email" content=3D"jgg@nvidia.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com=
</a></span><meta itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:jim.shu@sifive.com">=
jim.shu@sifive.com</a></span><meta itemprop=3D"email" content=3D"jim.shu@si=
five.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mburt=
on@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span><meta itemprop=3D"e=
mail" content=3D"mburton@qti.qualcomm.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></span><m=
eta itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:paul.walmsley@sifive.com">paul.walmsle=
y@sifive.com</a></span><meta itemprop=3D"email" content=3D"paul.walmsley@si=
five.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:pbonz=
ini@redhat.com">pbonzini@redhat.com</a></span><meta itemprop=3D"email" cont=
ent=3D"pbonzini@redhat.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></span><meta item=
prop=3D"email" content=3D"peter.maydell@linaro.org"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:richard.henderson@linaro.org">Richard =
Henderson</a></span><meta itemprop=3D"email" content=3D"richard.henderson@l=
inaro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:shen=
tey@gmail.com">shentey@gmail.com</a></span><meta itemprop=3D"email" content=
=3D"shentey@gmail.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:stefanha@gmail.com">stefanha@gmail.com</a></span><meta itemprop=3D"=
email" content=3D"stefanha@gmail.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span=
><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kerne=
l@gmail.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:philmd@lin=
aro.org">Phil Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=
=3D"philmd@linaro.org"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:eblot@rivosinc.com">eblot@rivosinc.com</a></span><meta itemprop=3D"=
email" content=3D"eblot@rivosinc.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:max.chou@sifive.com">max.chou@sifive.com</a></span><=
meta itemprop=3D"email" content=3D"max.chou@sifive.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:manos.pitsidianakis@linaro.org">Ma=
nos Pitsidianakis</a></span><meta itemprop=3D"email" content=3D"manos.pitsi=
dianakis@linaro.org"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:thuth@redhat.com">thuth@redhat.com</a></span><meta itemprop=3D"email=
" content=3D"thuth@redhat.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:rbc@meta.com">rbc@meta.com</a></span><meta itemprop=3D"emai=
l" content=3D"rbc@meta.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:demiobenour@gmail.com">demiobenour@gmail.com</a></span><meta=
 itemprop=3D"email" content=3D"demiobenour@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a></sp=
an><meta itemprop=3D"email" content=3D"hi@alyssa.is"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:dhedde@kalrayinc.com">dhedde@kalrayin=
c.com</a></span><meta itemprop=3D"email" content=3D"dhedde@kalrayinc.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:afaria@redhat.co=
m">afaria@redhat.com</a></span><meta itemprop=3D"email" content=3D"afaria@r=
edhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:aest=
eve@redhat.com">aesteve@redhat.com</a></span><meta itemprop=3D"email" conte=
nt=3D"aesteve@redhat.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</a></span=
><meta itemprop=3D"email" content=3D"marcandre.lureau@gmail.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:alistair.francis@wdc.com"=
>Alistair Francis</a></span><meta itemprop=3D"email" content=3D"alistair.fr=
ancis@wdc.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
konrad.wilk@oracle.com">konrad.wilk@oracle.com</a></span><meta itemprop=3D"=
email" content=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:ale@rev.ng">Alessandro Di Federico</a></span><me=
ta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:clg@kaod.org">C=C3=A9dric Le Goater</a></span=
><meta itemprop=3D"email" content=3D"clg@kaod.org"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:anjo@rev.ng">Anton Johansson</a></span>=
<meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</a=
></span><meta itemprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:elena.ufimtseva@o=
racle.com">Elena Ufimtseva</a></span><meta itemprop=3D"email" content=3D"el=
ena.ufimtseva@oracle.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a></span><meta ite=
mprop=3D"email" content=3D"eric.auger@redhat.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a>=
</span><meta itemprop=3D"email" content=3D"jan.kiszka@web.de"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:joao.m.martins@oracle.com"=
>Joao Martins</a></span><meta itemprop=3D"email" content=3D"joao.m.martins@=
oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:l=
uc@lmichel.fr">Luc Michel</a></span><meta itemprop=3D"email" content=3D"luc=
@lmichel.fr"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:s=
hameerali.kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a></span><m=
eta itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei.com"/></=
span><span class=3D"secondary-text" style=3D"color: #70757a; text-decoratio=
n: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@139.com">z.=
huo@139.com</a></span><meta itemprop=3D"email" content=3D"z.huo@139.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:zhiwei_liu@linux.=
alibaba.com">LIU Zhiwei</a></span><meta itemprop=3D"email" content=3D"zhiwe=
i_liu@linux.alibaba.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><meta ite=
mprop=3D"email" content=3D"qemu-devel@nongnu.org"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:nelson.ho@windriver.com">nelson.ho@windr=
iver.com</a></span><meta itemprop=3D"email" content=3D"nelson.ho@windriver.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div></div><a href=3D"https://calendar.google.com=
/calendar/event?action=3DVIEW&amp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0NmM=
gcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDF=
ibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4Yz=
NlMTcyZjhhYmUyNWU5YQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" styl=
e=3D"display: inline-block;;color: #1a73e8; text-decoration: none;font-weig=
ht: 700;" target=3D"_blank" class=3D"accent-text underline-on-hover">View a=
ll guest info</a></div></td></tr><tr><td style=3D"font-size: 0; padding: 0;=
 text-align: left; word-break: break-word;;padding-bottom:0px;"><div style=
=3D"color: #3c4043; text-decoration: none;;font-family: Roboto, sans-serif;=
font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text-ali=
gn: left;" class=3D"primary-text"><div><span style=3D"font-weight: 700;-web=
kit-font-smoothing: antialiased;">RSVP</span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"> for <a class=3D"secondar=
y-text underline-on-hover" style=3D"display: inline-block;;color: #70757a; =
text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@no=
ngnu.org</a> for all events in this series</span></div></div></td></tr><tr>=
<td style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-=
word;;padding-bottom:16px;"><div style=3D"font-family: Roboto, sans-serif;f=
ont-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text-alig=
n: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"p=
resentation" style=3D"border-collapse: separate;"><tr><td style=3D"padding-=
top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP buttons --><tabl=
e border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" st=
yle=3D"border: solid 1px #dadce0; border-radius: 16px; border-collapse: sep=
arate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;;display: inli=
ne-block;;margin-right: 12px; margin-left: 0;"><tr><td align=3D"center" ver=
tical-align=3D"middle" role=3D"presentation"><span itemprop=3D"potentialact=
ion" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"=
attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><span itempro=
p=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHandler"><l=
ink itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><=
span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/calen=
dar/event?action=3DRESPOND&amp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0NmMgcW=
VtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D1&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcm=
t1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3Z=
jU1OTk4YzNlMTcyZjhhYmUyNWU5YQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=
=3D0" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto,=
 sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-he=
ight-rule: exactly; margin: 0; text-decoration: none; text-transform: none;=
" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><table bord=
er=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td =
align=3D"center" role=3D"presentation" valign=3D"middle" style=3D"padding: =
6px 0; padding-left: 16px; padding-right: 12px; white-space: nowrap;"><!--[=
if mso]><a href=3D"https://calendar.google.com/calendar/event?action=3DRESP=
OND&amp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0NmMgcWVtdS1kZXZlbEBub25nbnUub=
3Jn&amp;rst=3D1&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91c=
C5jYWxlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4YzNlMTcyZjhhYmUy=
NWU5YQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-butt=
on-text" itemprop=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey=
-button-text" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;,=
 Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso=
-line-height-rule: exactly; margin: 0; text-decoration: none; text-transfor=
m: none;">Yes</span><!--[if mso]></a><![endif]--></td></tr></table></a></sp=
an></span></span></td><td align=3D"center" vertical-align=3D"middle" role=
=3D"presentation" style=3D"border-left: solid 1px #dadce0; border-right: so=
lid 1px #dadce0;"><span itemprop=3D"potentialaction" itemscope itemtype=3D"=
http://schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D"http=
://schema.org/RsvpAttendance/No"/><span itemprop=3D"handler" itemscope item=
type=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"method" href=
=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"color: #5f6367=
;"><a href=3D"https://calendar.google.com/calendar/event?action=3DRESPOND&a=
mp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0NmMgcWVtdS1kZXZlbEBub25nbnUub3Jn&a=
mp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYW=
xlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4YzNlMTcyZjhhYmUyNWU5Y=
Q&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 4=
00;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; f=
ont-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0=
; text-decoration: none; text-transform: none;" class=3D"grey-button-text" =
itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" ce=
llspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"pres=
entation" valign=3D"middle" style=3D"padding: 6px 12px; white-space: nowrap=
;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?actio=
n=3DRESPOND&amp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0NmMgcWVtdS1kZXZlbEBub=
25nbnUub3Jn&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua=
0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4YzNlMTcy=
ZjhhYmUyNWU5YQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"g=
rey-button-text" itemprop=3D"url" target=3D"_blank"><![endif]--><span class=
=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#39;Google Sa=
ns&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 1=
20%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; text-=
transform: none;">No</span><!--[if mso]></a><![endif]--></td></tr></table><=
/a></span></span></span></td><td align=3D"center" vertical-align=3D"middle"=
 role=3D"presentation"><span itemprop=3D"potentialaction" itemscope itemtyp=
e=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" content=3D=
"http://schema.org/RsvpAttendance/Maybe"/><span itemprop=3D"handler" itemsc=
ope itemtype=3D"http://schema.org/HttpActionHandler"><link itemprop=3D"meth=
od" href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"color:=
 #5f6367;"><a href=3D"https://calendar.google.com/calendar/event?action=3DR=
ESPOND&amp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0NmMgcWVtdS1kZXZlbEBub25nbn=
Uub3Jn&amp;rst=3D3&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm=
91cC5jYWxlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4YzNlMTcyZjhhY=
mUyNWU5YQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-w=
eight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5=
f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; m=
argin: 0; text-decoration: none; text-transform: none;" class=3D"grey-butto=
n-text" itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" rol=
e=3D"presentation" valign=3D"middle" style=3D"padding: 6px 0; padding-left:=
 12px; padding-right: 16px; white-space: nowrap;"><!--[if mso]><a href=3D"h=
ttps://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DM3Rtbj=
UxdjNhcDFwa2JlcWo0ZGl2dWg0NmMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D3&amp;=
tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nb=
GUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4YzNlMTcyZjhhYmUyNWU5YQ&amp;ctz=3DEur=
ope%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D=
"url" target=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=
=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif=
;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: =
exactly; margin: 0; text-decoration: none; text-transform: none;">Maybe</sp=
an><!--[if mso]></a><![endif]--></td></tr></table></a></span></span></span>=
</td></tr></table><!-- More options --><a href=3D"https://calendar.google.c=
om/calendar/event?action=3DVIEW&amp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0N=
mMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpM=
DFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4=
YzNlMTcyZjhhYmUyNWU5YQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" st=
yle=3D"display: inline-block;;font-weight: 400;font-family: &#39;Google San=
s&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 12=
0%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; text-t=
ransform: none;" class=3D"grey-button-text" target=3D"_blank"><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"b=
order: solid 1px #dadce0; border-radius: 16px; border-collapse: separate;fo=
nt-family: &#39;Google Sans&#39;, Roboto, sans-serif;"><tr><td align=3D"cen=
ter" vertical-align=3D"middle" role=3D"presentation" style=3D"padding: 6px =
0; padding-left: 16px; padding-right: 12px; white-space: nowrap;;color: #5f=
6367;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?a=
ction=3DVIEW&amp;eid=3DM3RtbjUxdjNhcDFwa2JlcWo0ZGl2dWg0NmMgcWVtdS1kZXZlbEBu=
b25nbnUub3Jn&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5j=
YWxlbmRhci5nb29nbGUuY29tMGM5Yjc2OTk3OWQ4Y2JjMTQ3ZjU1OTk4YzNlMTcyZjhhYmUyNWU=
5YQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-=
text" target=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=
=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif=
;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: =
exactly; margin: 0; text-decoration: none; text-transform: none;">More opti=
ons</span><!--[if mso]></a><![endif]--></td></tr></table></a></td></tr></ta=
ble></div></td></tr></table></td></tr></tbody></table></div><!--[if mso | I=
E]></td><![endif]--><!--[if mso | IE]></tr></table><![endif]--></td></tr></=
tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbody>=
<tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: br=
eak-word;;padding:4px 12px;" class=3D"" align=3D"left"><div class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;font-family: Robot=
o, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: exa=
ctly; text-align: left;"><p>Invitation from <a href=3D"https://calendar.goo=
gle.com/calendar/" class=3D"accent-text underline-on-hover" style=3D"font-f=
amily: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-heig=
ht-rule: exactly;;color: #1a73e8; text-decoration: none;" target=3D"_blank"=
>Google Calendar</a></p><p>You are receiving this email because you are an =
attendee on the event.</p><p>Forwarding this invitation could allow any rec=
ipient to send a response to the organizer, be added to the guest list, inv=
ite others regardless of their own invitation status, or modify your RSVP. =
<a class=3D"accent-text underline-on-hover" style=3D"font-family: Roboto, s=
ans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: exactly=
;;color: #1a73e8; text-decoration: none;" href=3D"https://support.google.co=
m/calendar/answer/37135#forwarding">Learn more</a></p></div></td></tr></tbo=
dy></table></td></tr></tbody></table></span></span></body></html>
--000000000000819ec5064585503e
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VEVENT
DTSTART:20260106T140000Z
DTEND:20260106T150000Z
RRULE:FREQ=3DWEEKLY;WKST=3DMO;INTERVAL=3D2;BYDAY=3DTU
DTSTAMP:20251209T135903Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:3tmn51v3ap1pkbeqj4divuh46c@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Darmbru@redhat.com;X-NUM-GUESTS=3D0:mailto:armbru@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbcain@quicinc.com;X-NUM-GUESTS=3D0:mailto:bcain@quicinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dberrange@redhat.com;X-NUM-GUESTS=3D0:mailto:berrange@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcjia@nvidia.com;X-NUM-GUESTS=3D0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcw@f00f.org;X-NUM-GUESTS=3D0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deblake@redhat.com;X-NUM-GUESTS=3D0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dedgar.iglesias@gmail.com;X-NUM-GUESTS=3D0:mailto:edgar.iglesias@=
gmail
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deduardo@habkost.net;X-NUM-GUESTS=3D0:mailto:eduardo@habkost.net
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
 TRUE;CN=3Dmburton@qti.qualcomm.com;X-NUM-GUESTS=3D0:mailto:mburton@qti.qua=
lcomm
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmdean@redhat.com;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dpaul.walmsley@sifive.com;X-NUM-GUESTS=3D0:mailto:paul.walmsley@s=
ifive
 .com
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
 TRUE;CN=3Dshentey@gmail.com;X-NUM-GUESTS=3D0:mailto:shentey@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dstefanha@gmail.com;X-NUM-GUESTS=3D0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dwei.w.wang@intel.com;X-NUM-GUESTS=3D0:mailto:wei.w.wang@intel.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dzwu.kernel@gmail.com;X-NUM-GUESTS=3D0:mailto:zwu.kernel@gmail.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:philmd@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deblot@rivosinc.com;X-NUM-GUESTS=3D0:mailto:eblot@rivosinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmax.chou@sifive.com;X-NUM-GUESTS=3D0:mailto:max.chou@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DManos Pitsidianakis;X-NUM-GUESTS=3D0:mailto:manos.pitsidianakis@=
linar
 o.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dthuth@redhat.com;X-NUM-GUESTS=3D0:mailto:thuth@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Drbc@meta.com;X-NUM-GUESTS=3D0:mailto:rbc@meta.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Ddemiobenour@gmail.com;X-NUM-GUESTS=3D0:mailto:demiobenour@gmail.=
com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dhi@alyssa.is;X-NUM-GUESTS=3D0:mailto:hi@alyssa.is
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Ddhedde@kalrayinc.com;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dafaria@redhat.com;X-NUM-GUESTS=3D0:mailto:afaria@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Daesteve@redhat.com;X-NUM-GUESTS=3D0:mailto:aesteve@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmarcandre.lureau@gmail.com;X-NUM-GUESTS=3D0:mailto:marcandre.lur=
eau@g
 mail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlistair Francis;X-NUM-GUESTS=3D0:mailto:alistair.francis@wdc.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dkonrad.wilk@oracle.com;X-NUM-GUESTS=3D0:mailto:konrad.wilk@oracl=
e.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlessandro Di Federico;X-NUM-GUESTS=3D0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:clg@kaod.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAnton Johansson;X-NUM-GUESTS=3D0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DChao Peng;X-NUM-GUESTS=3D0:mailto:chao.p.peng@linux.intel.com
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
 TRUE;CN=3Djan.kiszka@web.de;X-NUM-GUESTS=3D0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DJoao Martins;X-NUM-GUESTS=3D0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DLuc Michel;X-NUM-GUESTS=3D0:mailto:luc@lmichel.fr
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DShameerali Kolothum Thodi;X-NUM-GUESTS=3D0:mailto:shameerali.kol=
othum
 .thodi@huawei.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dz.huo@139.com;X-NUM-GUESTS=3D0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DLIU Zhiwei;X-NUM-GUESTS=3D0:mailto:zhiwei_liu@linux.alibaba.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dqemu-devel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.=
org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dnelson.ho@windriver.com;X-NUM-GUESTS=3D0:mailto:nelson.ho@windri=
ver.c
 om
X-MICROSOFT-CDO-OWNERAPPTID:-1878555320
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20251209T135854Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:2
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

--000000000000819ec5064585503e--

--000000000000819ec60645855040
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjYwMTA2VDE0MDAwMFoNCkRURU5EOjIwMjYwMTA2
VDE1MDAwMFoNClJSVUxFOkZSRVE9V0VFS0xZO1dLU1Q9TU87SU5URVJWQUw9MjtCWURBWT1UVQ0K
RFRTVEFNUDoyMDI1MTIwOVQxMzU5MDNaDQpPUkdBTklaRVI7Q049UUVNVSBQcm9qZWN0IENhbGVu
ZGFyOm1haWx0bzpjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGdyb3UNCiBwLmNhbGVuZGFy
Lmdvb2dsZS5jb20NClVJRDozdG1uNTF2M2FwMXBrYmVxajRkaXZ1aDQ2Y0Bnb29nbGUuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWFybWJydUByZWRoYXQu
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphcm1icnVAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O1JTVlA9DQogVFJVRTtDTj1iY2FpbkBxdWljaW5jLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
YmNhaW5AcXVpY2luYy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YmVycmFuZ2VA
cmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YmVycmFuZ2VAcmVkaGF0LmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jamlhQG52aWRpYS5jb207WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOmNqaWFAbnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jd0Bm
MDBmLm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y3dAZjAwZi5vcmcNCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049ZWJsYWtlQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVi
bGFrZUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVkZ2FyLmlnbGVz
aWFzQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWRnYXIuaWdsZXNpYXNAZ21haWwN
CiAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVkdWFyZG9AaGFia29zdC5uZXQ7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVkdWFyZG9AaGFia29zdC5uZXQNCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049ZmVsaXBlQG51dGFuaXguY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpm
ZWxpcGVAbnV0YW5peC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aWdneUB0aGVp
Z2d5LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86aWdneUB0aGVpZ2d5LmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1pbXBAYnNkaW1wLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
aW1wQGJzZGltcC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amdnQG52aWRpYS5j
b207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpnZ0BudmlkaWEuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPWppZG9uZy54aWFvQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
amlkb25nLnhpYW9AZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWppbS5z
aHVAc2lmaXZlLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amltLnNodUBzaWZpdmUuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1idXJ0b25AcXRpLnF1YWxjb21tLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86bWJ1cnRvbkBxdGkucXVhbGNvbW0NCiAuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPW1kZWFuQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
Om1kZWFuQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGF1bC53YWxt
c2xleUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYXVsLndhbG1zbGV5QHNpZml2
ZQ0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGJvbnppbmlAcmVkaGF0LmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O1JTVlA9DQogVFJVRTtDTj1QZXRlciBNYXlkZWxsO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049UmljaGFy
ZCBIZW5kZXJzb247WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcg0KIGcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049c2hlbnRleUBnbWFpbC5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnNoZW50ZXlAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPXN0ZWZhbmhhQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c3Rl
ZmFuaGFAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXdlaS53LndhbmdA
aW50ZWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp3ZWkudy53YW5nQGludGVsLmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj16d3Uua2VybmVsQGdtYWlsLmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86end1Lmtlcm5lbEBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBoaWxtZEBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPWVibG90QHJpdm9zaW5jLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
ZWJsb3RAcml2b3NpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1heC5jaG91
QHNpZml2ZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1heC5jaG91QHNpZml2ZS5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049TWFub3MgUGl0c2lkaWFuYWtpcztYLU5VTS1HVUVT
VFM9MDptYWlsdG86bWFub3MucGl0c2lkaWFuYWtpc0BsaW5hcg0KIG8ub3JnDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPXRodXRoQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OnRodXRoQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cmJjQG1ldGEu
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpyYmNAbWV0YS5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049ZGVtaW9iZW5vdXJAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpk
ZW1pb2Jlbm91ckBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aGlAYWx5
c3NhLmlzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpoaUBhbHlzc2EuaXMNCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049ZGhlZGRlQGthbHJheWluYy5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OmRoZWRkZUBrYWxyYXlpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWFmYXJp
YUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphZmFyaWFAcmVkaGF0LmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hZXN0ZXZlQHJlZGhhdC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmFlc3RldmVAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1tYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFyY2Fu
ZHJlLmx1cmVhdUBnDQogbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049QWxp
c3RhaXIgRnJhbmNpcztYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWtvbnJhZC53aWxrQG9yYWNsZS5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049QWxlc3NhbmRybyBEaSBGZWRlcmljbztYLU5VTS1HVUVTVFM9MDpt
YWlsdG86YWxlQHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86Y2xnQGthb2Qub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUFudG9u
IEpvaGFuc3NvbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcNCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049Q2hhbyBQZW5nO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjaGFvLnAu
cGVuZ0BsaW51eC5pbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049RWxlbmEg
VWZpbXRzZXZhO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lcmljLmF1Z2VyQHJlZGhhdC5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1qYW4ua2lzemthQHdlYi5kZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amFu
Lmtpc3prYUB3ZWIuZGUNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0aW5z
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPUx1YyBNaWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmx1
Y0BsbWljaGVsLmZyDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPVNoYW1lZXJhbGkgS29s
b3RodW0gVGhvZGk7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnNoYW1lZXJhbGkua29sb3RodW0NCiAu
dGhvZGlAaHVhd2VpLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj16Lmh1b0AxMzku
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6Lmh1b0AxMzkuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPUxJVSBaaGl3ZWk7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnpoaXdlaV9saXVA
bGludXguYWxpYmFiYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cWVtdS1kZXZl
bEBub25nbnUub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcN
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bmVsc29uLmhvQHdpbmRyaXZlci5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOm5lbHNvbi5ob0B3aW5kcml2ZXIuYw0KIG9tDQpYLU1JQ1JPU09G
VC1DRE8tT1dORVJBUFBUSUQ6LTE4Nzg1NTUzMjANCkNSRUFURUQ6MjAyMzAyMjFUMTUzOTUwWg0K
REVTQ1JJUFRJT046SWYgeW91IG5lZWQgY2FsbCBkZXRhaWxzXCwgcGxlYXNlIGNvbnRhY3QgbWU6
IDxhIGhyZWY9Im1haWx0bzpxDQogdWludGVsYUByZWRoYXQuY29tIj5hbGV4LmJlbm5lZUBsaW5h
cm8ub3JnPC9hPg0KTEFTVC1NT0RJRklFRDoyMDI1MTIwOVQxMzU4NTRaDQpMT0NBVElPTjpodHRw
czovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nDQpTRVFVRU5DRToyDQpTVEFUVVM6Q09ORklS
TUVEDQpTVU1NQVJZOlFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsDQpUUkFOU1A6
T1BBUVVFDQpBVFRBQ0g7RklMRU5BTUU9Tm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29u
ZmVyZW5jZSBjYWxsO0ZNVFRZUEU9YXBwbGljYQ0KIHRpb24vdm5kLmdvb2dsZS1hcHBzLmRvY3Vt
ZW50Omh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxMeg0KIHhDY2Nm
cWZOTktjTUc3NEhNVUpmNkRVUm1TSkJHUVpyZWsvZWRpdA0KQkVHSU46VkFMQVJNDQpBQ1RJT046
RU1BSUwNCkRFU0NSSVBUSU9OOlRoaXMgaXMgYW4gZXZlbnQgcmVtaW5kZXINClNVTU1BUlk6QWxh
cm0gbm90aWZpY2F0aW9uDQpBVFRFTkRFRTptYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpU
UklHR0VSOi1QMkQNCkVORDpWQUxBUk0NCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--000000000000819ec60645855040--

