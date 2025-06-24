Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D494CC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4lF-0003IS-DD; Tue, 24 Jun 2025 10:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU4l4-0003GV-Ve
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:36:23 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU4l0-0006cJ-He
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:36:22 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so2830833f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750775776; x=1751380576; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xbrNzexL/+yrgEnnjIAFRIC6GBXCrCH8AS8OSX2eDmY=;
 b=AgsmmVJShpRSZ3lrkBbeDoLHWNfUAsOesqrt/Nvu8xlXKFrJz4jBkjguTKd7UAX/ov
 xFhg4HHzQjmx1eCzuzBBBQuIS08peXB5EuJRGU+qLh8QVMD4ksB4V2edZ925/pwaMoZZ
 9fmJOcIGKi33I9a6VIUdYhNkKu8tmTN+DRsgQtbs1pf0blkf6UJTIAGDGz3F4vSLBOZA
 WRVsq7479tg9RDsjmhsoAzTYiq3d73Ya0Iyg7BVEnl6EezG2QM3kwWTLC+t9ZG4fS36q
 tZnzfInO2rDUSrldIcUTJGUbJwCpNlzUl2gLZ4J58n9qp9cPj2Ot6TdZI9EVkZOLxUm6
 xJEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750775776; x=1751380576; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xbrNzexL/+yrgEnnjIAFRIC6GBXCrCH8AS8OSX2eDmY=;
 b=z8NsorICu7Ipv7eL1ZVG5m5Jd7TPqglKc1ggPiQu3qpDWnBxECTUYKPHxr4WuuQO6q
 Ds//0icV7A+vsWTMldFu2fvvvLQR6QbC8oHL6/1T8oVxLIi35EElW4hJr0oSmqCUyUj1
 wdN/a7wVvw50IU64ACB4d5BjnmdDb1/L7SEwDg2Qijp7NhCZ4Bi5/QNqUfDSN9chBOtf
 Z8kd7NP2L6D8Bc7dsA/3CkkJD/KYo+az7L1OJ7r1vxxE8KV+sAoM5JlAcEaZLy0wSPwl
 5maTha832t7eiF62cUbZWD93mSoVKkGAMIg+rM+i2H5Y4g2APu5+KQrE1Rl2sD68BCfl
 00xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775776; x=1751380576;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xbrNzexL/+yrgEnnjIAFRIC6GBXCrCH8AS8OSX2eDmY=;
 b=EBKvZatEPpsVpShYo27ZR9BLaiwIqw/Sq6olZot2vsJgV8PXKAG+JeDc9HMVVfkWyp
 M1eveaGmFk5xf7hY8CngQJyZMfZitulpC6xn2nBQ0F54y1oXVA/6ECWqJa6ChEvGBvC0
 iHDMQ4XHKstLEmvyl25q0b7ukIpHuJBqhiGFfUXvm+BCTj9S1uhhZ4RAU9nxbNYEJepU
 gF6fmMq/a2mrrUWKZKDLT274cUGUyt3LvvcrAOpxg3HTA1/IKgPsXZ+E0JUYxLCwelad
 LcDTQ/bITUSV6oYv7TKZlxDkwRmCJpyjXu/pKhzlj4n+dn1jyOVMq79iImeO9Sc8wnHR
 IM7A==
X-Gm-Message-State: AOJu0YzH7PiH/C3Tw4AckmULVq9aE700ZwIOww3fiHw0NsvpfLdzu10r
 5/aMoAAOx4EkzmTkGsizHhiaWOuYVxH+ZHYBFUmH0K6Ns1ymwDHeFd6DmtqNF9XY6T9pqaO7Rgh
 6RSp74gkVRqpGX+LoYPm0OLm4xfuc3BRNOZDXvaTN+nNZuHNWGXJA1g==
X-Google-Smtp-Source: AGHT+IHlpM0umlaNDnue1RINouPZBML++ko7EVXfQxJ6+v+Uo+zazXZCuqKVJ3ZETkUMvfkTjfDuf3/e6vji9PHZ+ZHC
MIME-Version: 1.0
X-Received: by 2002:a05:6000:1acc:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3a6e720de4emr3162641f8f.24.1750775776176; Tue, 24 Jun 2025
 07:36:16 -0700 (PDT)
Message-ID: <calendar-547a39e9-935a-4427-aeb6-0aaf5abae021@google.com>
Date: Tue, 24 Jun 2025 14:36:16 +0000
Subject: Invitation: QEMU/KVM developers conference call @ Every 2 weeks from
 14:00 to 15:00 on Tuesday (BST) (qemu-devel@nongnu.org)
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
 Alistair Francis <alistair.francis@wdc.com>, konrad.wilk@oracle.com, 
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Anton Johansson <anjo@rev.ng>, Chao Peng <chao.p.peng@linux.intel.com>, 
 Damien Hedde <dhedde@kalrayinc.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com, 
 jan.kiszka@web.de, Joao Martins <joao.m.martins@oracle.com>,
 Luc Michel <luc@lmichel.fr>, mimu@linux.vnet.ibm.com, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, nelson.ho@windriver.com, 
 demiobenour@gmail.com, hi@alyssa.is
Content-Type: multipart/mixed; boundary="00000000000038767b063852403d"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x44a.google.com
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

--00000000000038767b063852403d
Content-Type: multipart/alternative; boundary="0000000000003876790638524039"

--0000000000003876790638524039
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

UUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwNCkV2ZXJ5IDIgd2Vla3MgZnJvbSAx
NDowMCB0byAxNTowMCBvbiBUdWVzZGF5DQpVbml0ZWQgS2luZ2RvbSBUaW1lDQoNCkxvY2F0aW9u
DQpodHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29vZ2xl
LmNvbS91cmw/cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcmc2E9
RCZ1c3Q9MTc1MTIwNzc2MDAwMDAwMCZ1c2c9QU92VmF3Mzg0eTlnNnREdWtFR1l0MkZpWFlUTw0K
DQoNCg0KQXR0YWNobWVudHMNCk5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVu
Y2UgY2FsbCAgDQpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHp4
Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCg0KSWYgeW91IG5lZWQgY2Fs
bCBkZXRhaWxzLCBwbGVhc2UgY29udGFjdCBtZTogYWxleC5iZW5uZWVAbGluYXJvLm9yZw0KDQpH
dWVzdHMNCkFsZXggQmVubsOpZSAtIGNyZWF0b3INCmFybWJydUByZWRoYXQuY29tDQpiY2FpbkBx
dWljaW5jLmNvbQ0KYmVycmFuZ2VAcmVkaGF0LmNvbQ0KY2ppYUBudmlkaWEuY29tDQpjd0BmMDBm
Lm9yZw0KZWJsYWtlQHJlZGhhdC5jb20NCmVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbQ0KZWR1YXJk
b0BoYWJrb3N0Lm5ldA0KZmVsaXBlQG51dGFuaXguY29tDQppZ2d5QHRoZWlnZ3kuY29tDQppbXBA
YnNkaW1wLmNvbQ0KamdnQG52aWRpYS5jb20NCmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KamltLnNo
dUBzaWZpdmUuY29tDQptYnVydG9uQHF0aS5xdWFsY29tbS5jb20NCm1kZWFuQHJlZGhhdC5jb20N
CnBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbQ0KcGJvbnppbmlAcmVkaGF0LmNvbQ0KUGV0ZXIgTWF5
ZGVsbA0KUmljaGFyZCBIZW5kZXJzb24NCnNoZW50ZXlAZ21haWwuY29tDQpzdGVmYW5oYUBnbWFp
bC5jb20NCndlaS53LndhbmdAaW50ZWwuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KUGhpbCBN
YXRoaWV1LURhdWTDqQ0KZWJsb3RAcml2b3NpbmMuY29tDQptYXguY2hvdUBzaWZpdmUuY29tDQpN
YW5vcyBQaXRzaWRpYW5ha2lzDQp0aHV0aEByZWRoYXQuY29tDQpyYmNAbWV0YS5jb20NCkFsaXN0
YWlyIEZyYW5jaXMNCmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCkFsZXNzYW5kcm8gRGkgRmVkZXJp
Y28NCkPDqWRyaWMgTGUgR29hdGVyDQpBbnRvbiBKb2hhbnNzb24NCkNoYW8gUGVuZw0KRGFtaWVu
IEhlZGRlDQpFbGVuYSBVZmltdHNldmENCmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KamFuLmtpc3pr
YUB3ZWIuZGUNCkpvYW8gTWFydGlucw0KTHVjIE1pY2hlbA0KbWltdUBsaW51eC52bmV0LmlibS5j
b20NClNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCnouaHVvQDEzOS5jb20NCkxJVSBaaGl3ZWkN
CnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KbmVsc29uLmhvQHdpbmRyaXZlci5jb20NCmRlbWlvYmVu
b3VyQGdtYWlsLmNvbQ0KaGlAYWx5c3NhLmlzDQpWaWV3IGFsbCBndWVzdCBpbmZvICANCmh0dHBz
Oi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci9ldmVudD9hY3Rpb249VklFVyZlaWQ9Tlc4
NGEyNTBNV015Tm5KaWJYRTBOakl3TkhKeE9HMWpOVE1nY1dWdGRTMWtaWFpsYkVCdWIyNW5iblV1
YjNKbiZ0b2s9TlRRalkxOXJOWEF5YkhCbmRtSndkR1JwY210MU5YTnBNREZpYkcxdWEwQm5jbTkx
Y0M1allXeGxibVJoY2k1bmIyOW5iR1V1WTI5dFpHTm1NV1V4T1RBMk4yWTJNRGs1Wldaa01qWXdN
VGhtTW1WbU5UTTFNRGN3TlRVNU5UazFNUSZjdHo9RXVyb3BlJTJGTG9uZG9uJmhsPWVuJmVzPTAN
Cg0KUmVwbHkgZm9yIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyBhbmQgdmlldyBtb3JlIGRldGFpbHMg
IA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyL2V2ZW50P2FjdGlvbj1WSUVX
JmVpZD1OVzg0YTI1ME1XTXlObkppYlhFME5qSXdOSEp4T0cxak5UTWdjV1Z0ZFMxa1pYWmxiRUJ1
YjI1bmJuVXViM0puJnRvaz1OVFFqWTE5ck5YQXliSEJuZG1Kd2RHUnBjbXQxTlhOcE1ERmliRzF1
YTBCbmNtOTFjQzVqWVd4bGJtUmhjaTVuYjI5bmJHVXVZMjl0WkdObU1XVXhPVEEyTjJZMk1EazVa
V1prTWpZd01UaG1NbVZtTlRNMU1EY3dOVFU1TlRrMU1RJmN0ej1FdXJvcGUlMkZMb25kb24maGw9
ZW4mZXM9MA0KWW91ciBhdHRlbmRhbmNlIGlzIG9wdGlvbmFsLg0KDQp+fi8vfn4NCkludml0YXRp
b24gZnJvbSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxl
bmRhci8NCg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4g
YXR0ZW5kZWUgb24gdGhlIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3Vs
ZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5p
emVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNz
IG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4N
Cg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIv
MzcxMzUjZm9yd2FyZGluZw0K
--0000000000003876790638524039
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
  src: url(//fonts.gstatic.com/s/materialiconsextended/v152/kJEjBvgX7BgnkSr=
UwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v143/Gw6kwdfw6UnXLJCcm=
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
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v117/WWXFlimHYg6=
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
/InformAction"><span style=3D"display:none" itemprop=3D"about" itemscope it=
emtype=3D"http://schema.org/Person"><meta itemprop=3D"description" content=
=3D"Invitation from Alex Benn=C3=A9e"/></span><span itemprop=3D"object" ite=
mscope itemtype=3D"http://schema.org/Event"><meta itemprop=3D"eventStatus" =
content=3D"http://schema.org/EventScheduled"/><span itemprop=3D"publisher" =
itemscope itemtype=3D"http://schema.org/Organization"><meta itemprop=3D"nam=
e" content=3D"Google Calendar"/></span><meta itemprop=3D"eventId/googleCale=
ndar" content=3D"5o8knt1c26rbmq46204rq8mc53"/><span style=3D"display: none;=
 font-size: 1px; color: #fff; line-height: 1px; height: 0; max-height: 0; w=
idth: 0; max-width: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEM=
U/KVM developers conference call</span><meta itemprop=3D"url" content=3D"ht=
tps://calendar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNW84a250MW=
MyNnJibXE0NjIwNHJxOG1jNTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTQjY19rNX=
AybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxO=
TA2N2Y2MDk5ZWZkMjYwMThmMmVmNTM1MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp=
;hl=3Den&amp;es=3D0"/><span aria-hidden=3D"true"><time itemprop=3D"startDat=
e" datetime=3D"20250624T130000Z"></time><time itemprop=3D"endDate" datetime=
=3D"20250624T140000Z"></time></span><div style=3D"display: none; font-size:=
 1px; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; ma=
x-width: 0; opacity: 0; overflow: hidden;">If you need call details, please=
 contact me: alex.bennee@linaro.org</div><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width=
:100%;" class=3D"body-container"><tbody><tr><td style=3D"" class=3D"" align=
=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspaci=
ng=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"height:16px;"=
><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true"> &nbsp; </div=
><!--[if mso | IE]></td></tr></table><![endif]--><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D""><tbody><tr><td style=3D"border: solid 1px #dadc=
e0; border-radius: 8px; direction: rtl; font-size: 0; padding: 24px 32px; t=
ext-align: left; vertical-align: top;" class=3D"main-container-inner"><!--[=
if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation"><tr><![endif]--><!--[if mso | IE]><td class=3D"" style=3D=
"vertical-align:top;width:37%;" ><![endif]--><div class=3D"column-per-37 ou=
tlook-group-fix" style=3D"font-size: 13px; text-align: left; direction: ltr=
; display: inline-block; vertical-align: top; width: 100%;overflow: hidden;=
 word-wrap: break-word;"><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" width=3D"100%"><tbody><tr><td style=3D"vertica=
l-align:top;padding:0;"><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" width=3D"100%"><tr><td style=3D"font-size: 0; =
padding: 0; text-align: left; word-break: break-word;;padding-bottom:0px;">=
<div style=3D"font-family: Roboto, sans-serif;font-size: 14px; line-height:=
 20px; mso-line-height-rule: exactly; text-align: left;" class=3D"primary-t=
ext" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacin=
g=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 cl=
ass=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decorati=
on: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; pa=
dding: 0;">Attachments</h2></td></tr></table></div></td></tr><tr><td style=
=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;pad=
ding-bottom:24px;padding-left: 1px; padding-right: 1px;"><table border=3D"0=
" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" class=3D"attach=
ment-chip" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-=
collapse: separate; padding: 4px 0 4px 0;"><tr><td style=3D"padding: 3px 10=
px; height: 14px; width: 14px;"><img src=3D"https://drive-thirdparty.google=
usercontent.com/16/type/application/vnd.google-apps.document" width=3D"14" =
height=3D"14" alt=3D"" style=3D"display: inline-block; vertical-align: midd=
le;"></td><td align=3D"left" style=3D"padding: 0; padding-left: 0; padding-=
right: 10px; max-width: 160px; overflow: hidden; text-overflow: ellipsis; w=
hite-space: nowrap;"><div style=3D"overflow: hidden; height: 20px;"><a href=
=3D"https://docs.google.com/document/d/1-Ltq11LLzxCccfqfNNKcMG74HMUJf6DURmS=
JBGQZrek/edit" target=3D"_blank" style=3D"font-weight: 400;font-family: &#3=
9;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; lin=
e-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: =
none; text-transform: none;;font-family: Roboto, sans-serif;; display: inli=
ne-block; height: 20px; max-width: 160px; line-height: 20px; overflow: hidd=
en; text-overflow: ellipsis; vertical-align: middle; white-space: normal;" =
class=3D"grey-button-text" title=3D"Notes =E2=80=93 QEMU/KVM developers con=
ference call">Notes =E2=80=93 QEMU/KVM devel...</a></div></td></tr></table>=
</td></tr></table></td></tr></tbody></table></div><!--[if mso | IE]></td><!=
[endif]--><!--[if mso | IE]><td class=3D"" style=3D"vertical-align:top;widt=
h:63%;padding-right:32px;" ><![endif]--><div class=3D"column-per-63 outlook=
-group-fix" style=3D"font-size: 13px; text-align: left; direction: ltr; dis=
play: inline-block; vertical-align: top; width: 100%;overflow: hidden; word=
-wrap: break-word;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"=
 role=3D"presentation" width=3D"100%" class=3D"main-column-table-ltr" style=
=3D"padding-right: 32px; padding-left: 0;;table-layout: fixed;"><tbody><tr>=
<td class=3D"main-column-td" style=3D"padding:0; vertical-align:top;"><tabl=
e border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" wi=
dth=3D"100%" style=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0; =
padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"=
><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-wei=
ght: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: =
#3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentatio=
n"><span>If you need call details, please contact me: <a href=3D"mailto:qui=
ntela@redhat.com" target=3D"_blank">alex.bennee@linaro.org</a></span><meta =
itemprop=3D"description" content=3D"If you need call details, please contac=
t me: alex.bennee@linaro.org"/></div></td></tr><tr><td style=3D"font-size: =
0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24p=
x;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-=
weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;colo=
r: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presenta=
tion"><span aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"2=
0250624T130000Z"></time><time itemprop=3D"endDate" datetime=3D"20250624T140=
000Z"></time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"=
 role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"=
primary-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: non=
e;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: =
0;">When</h2></td></tr></table><span>Every 2 weeks from 14:00 to 15:00 on T=
uesday (United Kingdom Time)</span></div></td></tr><tr><td style=3D"font-si=
ze: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom=
:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; f=
ont-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;=
color: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"pres=
entation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"p=
resentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-te=
xt" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-wei=
ght: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Locati=
on</h2></td></tr></table><span itemprop=3D"location" itemscope itemtype=3D"=
http://schema.org/Place"><span itemprop=3D"name" class=3D"primary-text notr=
anslate" style=3D"font-family: Roboto, sans-serif;font-style: normal; font-=
weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;colo=
r: #3c4043; text-decoration: none;">https://meet.jit.si/kvmcallmeeting</spa=
n><br/><a href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%=
2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D1751207760000000&amp;usg=3DAOvVaw384y=
9g6tDukEGYt2FiXYTO" class=3D"accent-text underline-on-hover" style=3D"displ=
ay: inline-block;;color: #1a73e8; text-decoration: none;font-weight: 700;" =
target=3D"_blank" itemprop=3D"map">View map</a></span></div></td></tr><tr><=
td style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-w=
ord;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;fo=
nt-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; let=
ter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary=
-text" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 =
class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decora=
tion: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; =
padding: 0;">Guests</h2></td></tr></table><div style=3D"padding-bottom: 4px=
; text-align: left;;color: #3c4042;"><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:alex=
.bennee@linaro.org">Alex Benn=C3=A9e</a></span><meta itemprop=3D"email" con=
tent=3D"alex.bennee@linaro.org"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"> - creator</span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a></span><=
meta itemprop=3D"email" content=3D"armbru@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:bcain@quicinc.com">bcain@quicinc.c=
om</a></span><meta itemprop=3D"email" content=3D"bcain@quicinc.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:berrange@redhat.com">b=
errange@redhat.com</a></span><meta itemprop=3D"email" content=3D"berrange@r=
edhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia=
@nvidia.com">cjia@nvidia.com</a></span><meta itemprop=3D"email" content=3D"=
cjia@nvidia.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:cw@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw=
@f00f.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:ebla=
ke@redhat.com">eblake@redhat.com</a></span><meta itemprop=3D"email" content=
=3D"eblake@redhat.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta =
itemprop=3D"email" content=3D"edgar.iglesias@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:eduardo@habkost.net">eduardo@habko=
st.net</a></span><meta itemprop=3D"email" content=3D"eduardo@habkost.net"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix.c=
om">felipe@nutanix.com</a></span><meta itemprop=3D"email" content=3D"felipe=
@nutanix.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:i=
ggy@theiggy.com">iggy@theiggy.com</a></span><meta itemprop=3D"email" conten=
t=3D"iggy@theiggy.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:imp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" c=
ontent=3D"imp@bsdimp.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"email=
" content=3D"jgg@nvidia.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><met=
a itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:jim.shu@sifive.com">jim.shu@sifive=
.com</a></span><meta itemprop=3D"email" content=3D"jim.shu@sifive.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:mburton@qti.qualc=
omm.com">mburton@qti.qualcomm.com</a></span><meta itemprop=3D"email" conten=
t=3D"mburton@qti.qualcomm.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></span><meta itemprop=
=3D"email" content=3D"mdean@redhat.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:paul.walmsley@sifive.com">paul.walmsley@sifive.com=
</a></span><meta itemprop=3D"email" content=3D"paul.walmsley@sifive.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:pbonzini@redhat.c=
om">pbonzini@redhat.com</a></span><meta itemprop=3D"email" content=3D"pbonz=
ini@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:peter.maydell@linaro.org">Peter Maydell</a></span><meta itemprop=3D"email"=
 content=3D"peter.maydell@linaro.org"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:richard.henderson@linaro.org">Richard Henderson</a><=
/span><meta itemprop=3D"email" content=3D"richard.henderson@linaro.org"/></=
span><span class=3D"secondary-text" style=3D"color: #70757a; text-decoratio=
n: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
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
coration: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com<=
/a></span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:philmd@linaro.org">Phi=
l Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D"philmd@l=
inaro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblo=
t@rivosinc.com">eblot@rivosinc.com</a></span><meta itemprop=3D"email" conte=
nt=3D"eblot@rivosinc.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:max.chou@sifive.com">max.chou@sifive.com</a></span><meta itempro=
p=3D"email" content=3D"max.chou@sifive.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:manos.pitsidianakis@linaro.org">Manos Pitsidia=
nakis</a></span><meta itemprop=3D"email" content=3D"manos.pitsidianakis@lin=
aro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsco=
pe itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"n=
otranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: =
inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:thuth@=
redhat.com">thuth@redhat.com</a></span><meta itemprop=3D"email" content=3D"=
thuth@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:rbc@meta.com">rbc@meta.com</a></span><meta itemprop=3D"email" content=3D=
"rbc@meta.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
alistair.francis@wdc.com">Alistair Francis</a></span><meta itemprop=3D"emai=
l" content=3D"alistair.francis@wdc.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@oracle.com</a>=
</span><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:ale@rev.ng">Alessandro =
Di Federico</a></span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:clg@kaod.org">C=C3=
=A9dric Le Goater</a></span><meta itemprop=3D"email" content=3D"clg@kaod.or=
g"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:anjo@rev.ng"=
>Anton Johansson</a></span><meta itemprop=3D"email" content=3D"anjo@rev.ng"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:chao.p.peng@li=
nux.intel.com">Chao Peng</a></span><meta itemprop=3D"email" content=3D"chao=
.p.peng@linux.intel.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:dhedde@kalrayinc.com">Damien Hedde</a></span><meta itemprop=3D"e=
mail" content=3D"dhedde@kalrayinc.com"/></span><span class=3D"secondary-tex=
t" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span=
 itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><spa=
n itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underlin=
e-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration=
: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></sp=
an><meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@redhat.com">=
eric.auger@redhat.com</a></span><meta itemprop=3D"email" content=3D"eric.au=
ger@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" co=
ntent=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></span><meta item=
prop=3D"email" content=3D"joao.m.martins@oracle.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:luc@lmichel.fr">Luc Michel</a></span>=
<meta itemprop=3D"email" content=3D"luc@lmichel.fr"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vn=
et.ibm.com</a></span><meta itemprop=3D"email" content=3D"mimu@linux.vnet.ib=
m.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:shameera=
li.kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a></span><meta ite=
mprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@139.com">z.huo@139.=
com</a></span><meta itemprop=3D"email" content=3D"z.huo@139.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:zhiwei_liu@linux.alibaba.=
com">LIU Zhiwei</a></span><meta itemprop=3D"email" content=3D"zhiwei_liu@li=
nux.alibaba.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"=
email" content=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:nelson.ho@windriver.com">nelson.ho@windriver.com<=
/a></span><meta itemprop=3D"email" content=3D"nelson.ho@windriver.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:demiobenour@gmail=
.com">demiobenour@gmail.com</a></span><meta itemprop=3D"email" content=3D"d=
emiobenour@gmail.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:hi@alyssa.is">hi@alyssa.is</a></span><meta itemprop=3D"email" conten=
t=3D"hi@alyssa.is"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div></div><a href=3D"https://calen=
dar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNW84a250MWMyNnJibXE0N=
jIwNHJxOG1jNTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTQjY19rNXAybHBndmJwd=
GRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxOTA2N2Y2MDk5=
ZWZkMjYwMThmMmVmNTM1MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&am=
p;es=3D0" style=3D"display: inline-block;;color: #1a73e8; text-decoration: =
none;font-weight: 700;" target=3D"_blank" class=3D"accent-text underline-on=
-hover">View all guest info</a></div></td></tr><tr><td style=3D"font-size: =
0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:0px=
;"><div style=3D"color: #3c4043; text-decoration: none;;font-family: Roboto=
, sans-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exac=
tly; text-align: left;" class=3D"primary-text"><div><span style=3D"font-wei=
ght: 700;-webkit-font-smoothing: antialiased;">RSVP</span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"> for <a clas=
s=3D"secondary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #70757a; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">=
qemu-devel@nongnu.org</a> for all events in this series</span></div></div><=
/td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-=
break: break-word;;padding-bottom:16px;"><div style=3D"font-family: Roboto,=
 sans-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exact=
ly; text-align: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0" role=3D"presentation" style=3D"border-collapse: separate;"><tr><td styl=
e=3D"padding-top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP but=
tons --><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pre=
sentation" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-=
collapse: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;;=
display: inline-block;;margin-right: 12px; margin-left: 0;"><tr><td align=
=3D"center" vertical-align=3D"middle" role=3D"presentation"><span itemprop=
=3D"potentialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><m=
eta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/Yes=
"/><span itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpA=
ctionHandler"><link itemprop=3D"method" href=3D"http://schema.org/HttpReque=
stMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.=
google.com/calendar/event?action=3DRESPOND&amp;eid=3DNW84a250MWMyNnJibXE0Nj=
IwNHJxOG1jNTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D1&amp;tok=3DNTQjY19rNX=
AybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxO=
TA2N2Y2MDk5ZWZkMjYwMThmMmVmNTM1MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp=
;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;Google San=
s&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 12=
0%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; text-t=
ransform: none;" class=3D"grey-button-text" itemprop=3D"url" target=3D"_bla=
nk"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"present=
ation"><tr><td align=3D"center" role=3D"presentation" valign=3D"middle" sty=
le=3D"padding: 6px 0; padding-left: 16px; padding-right: 12px; white-space:=
 nowrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/even=
t?action=3DRESPOND&amp;eid=3DNW84a250MWMyNnJibXE0NjIwNHJxOG1jNTMgcWVtdS1kZX=
ZlbEBub25nbnUub3Jn&amp;rst=3D1&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMD=
FibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxOTA2N2Y2MDk5ZWZkMjYwMThmM=
mVmNTM1MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" cla=
ss=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><![endif]--><spa=
n class=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#39;Go=
ogle Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-he=
ight: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none=
; text-transform: none;">Yes</span><!--[if mso]></a><![endif]--></td></tr><=
/table></a></span></span></span></td><td align=3D"center" vertical-align=3D=
"middle" role=3D"presentation" style=3D"border-left: solid 1px #dadce0; bor=
der-right: solid 1px #dadce0;"><span itemprop=3D"potentialaction" itemscope=
 itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendance" co=
ntent=3D"http://schema.org/RsvpAttendance/No"/><span itemprop=3D"handler" i=
temscope itemtype=3D"http://schema.org/HttpActionHandler"><link itemprop=3D=
"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><span style=3D"c=
olor: #5f6367;"><a href=3D"https://calendar.google.com/calendar/event?actio=
n=3DRESPOND&amp;eid=3DNW84a250MWMyNnJibXE0NjIwNHJxOG1jNTMgcWVtdS1kZXZlbEBub=
25nbnUub3Jn&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua=
0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxOTA2N2Y2MDk5ZWZkMjYwMThmMmVmNTM1=
MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"f=
ont-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;colo=
r: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exact=
ly; margin: 0; text-decoration: none; text-transform: none;" class=3D"grey-=
button-text" itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td align=3D"center"=
 role=3D"presentation" valign=3D"middle" style=3D"padding: 6px 12px; white-=
space: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calenda=
r/event?action=3DRESPOND&amp;eid=3DNW84a250MWMyNnJibXE0NjIwNHJxOG1jNTMgcWVt=
dS1kZXZlbEBub25nbnUub3Jn&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1=
NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxOTA2N2Y2MDk5ZWZkMjY=
wMThmMmVmNTM1MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D=
0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><![endif]-=
-><span class=3D"grey-button-text" style=3D"font-weight: 400;font-family: &=
#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; l=
ine-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration=
: none; text-transform: none;">No</span><!--[if mso]></a><![endif]--></td><=
/tr></table></a></span></span></span></td><td align=3D"center" vertical-ali=
gn=3D"middle" role=3D"presentation"><span itemprop=3D"potentialaction" item=
scope itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"attendanc=
e" content=3D"http://schema.org/RsvpAttendance/Maybe"/><span itemprop=3D"ha=
ndler" itemscope itemtype=3D"http://schema.org/HttpActionHandler"><link ite=
mprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><span st=
yle=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/calendar/eve=
nt?action=3DRESPOND&amp;eid=3DNW84a250MWMyNnJibXE0NjIwNHJxOG1jNTMgcWVtdS1kZ=
XZlbEBub25nbnUub3Jn&amp;rst=3D3&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpM=
DFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxOTA2N2Y2MDk5ZWZkMjYwMThm=
MmVmNTM1MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" st=
yle=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-se=
rif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rul=
e: exactly; margin: 0; text-decoration: none; text-transform: none;" class=
=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><table border=3D"0=
" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td align=
=3D"center" role=3D"presentation" valign=3D"middle" style=3D"padding: 6px 0=
; padding-left: 12px; padding-right: 16px; white-space: nowrap;"><!--[if ms=
o]><a href=3D"https://calendar.google.com/calendar/event?action=3DRESPOND&a=
mp;eid=3DNW84a250MWMyNnJibXE0NjIwNHJxOG1jNTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&a=
mp;rst=3D3&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYW=
xlbmRhci5nb29nbGUuY29tZGNmMWUxOTA2N2Y2MDk5ZWZkMjYwMThmMmVmNTM1MDcwNTU5NTk1M=
Q&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-te=
xt" itemprop=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey-butt=
on-text" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Robo=
to, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line=
-height-rule: exactly; margin: 0; text-decoration: none; text-transform: no=
ne;">Maybe</span><!--[if mso]></a><![endif]--></td></tr></table></a></span>=
</span></span></td></tr></table><!-- More options --><a href=3D"https://cal=
endar.google.com/calendar/event?action=3DVIEW&amp;eid=3DNW84a250MWMyNnJibXE=
0NjIwNHJxOG1jNTMgcWVtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTQjY19rNXAybHBndmJ=
wdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxOTA2N2Y2MD=
k5ZWZkMjYwMThmMmVmNTM1MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&=
amp;es=3D0" style=3D"display: inline-block;;font-weight: 400;font-family: &=
#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; l=
ine-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration=
: none; text-transform: none;" class=3D"grey-button-text" target=3D"_blank"=
><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentati=
on" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-collaps=
e: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;"><tr><t=
d align=3D"center" vertical-align=3D"middle" role=3D"presentation" style=3D=
"padding: 6px 0; padding-left: 16px; padding-right: 12px; white-space: nowr=
ap;;color: #5f6367;"><!--[if mso]><a href=3D"https://calendar.google.com/ca=
lendar/event?action=3DVIEW&amp;eid=3DNW84a250MWMyNnJibXE0NjIwNHJxOG1jNTMgcW=
VtdS1kZXZlbEBub25nbnUub3Jn&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG=
1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZGNmMWUxOTA2N2Y2MDk5ZWZkMjYwMThmMmVmN=
TM1MDcwNTU5NTk1MQ&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" class=
=3D"grey-button-text" target=3D"_blank"><![endif]--><span class=3D"grey-but=
ton-text" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Rob=
oto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-lin=
e-height-rule: exactly; margin: 0; text-decoration: none; text-transform: n=
one;">More options</span><!--[if mso]></a><![endif]--></td></tr></table></a=
></td></tr></table></div></td></tr></table></td></tr></tbody></table></div>=
<!--[if mso | IE]></td><![endif]--><!--[if mso | IE]></tr></table><![endif]=
--></td></tr></tbody></table><table border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" clas=
s=3D""><tbody><tr><td style=3D"font-size: 0; padding: 0; text-align: left; =
word-break: break-word;;padding:4px 12px;" class=3D"" align=3D"left"><div c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;font=
-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-he=
ight-rule: exactly; text-align: left;"><p>Invitation from <a href=3D"https:=
//calendar.google.com/calendar/" class=3D"accent-text underline-on-hover" s=
tyle=3D"font-family: Roboto, sans-serif;font-size: 12px; line-height: 16px;=
 mso-line-height-rule: exactly;;color: #1a73e8; text-decoration: none;" tar=
get=3D"_blank">Google Calendar</a></p><p>You are receiving this email becau=
se you are an attendee on the event.</p><p>Forwarding this invitation could=
 allow any recipient to send a response to the organizer, be added to the g=
uest list, invite others regardless of their own invitation status, or modi=
fy your RSVP. <a class=3D"accent-text underline-on-hover" style=3D"font-fam=
ily: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-height=
-rule: exactly;;color: #1a73e8; text-decoration: none;" href=3D"https://sup=
port.google.com/calendar/answer/37135#forwarding">Learn more</a></p></div><=
/td></tr></tbody></table></td></tr></tbody></table></span></span></body></h=
tml>
--0000000000003876790638524039
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VEVENT
DTSTART:20250624T130000Z
DTEND:20250624T140000Z
RRULE:FREQ=3DWEEKLY;WKST=3DMO;INTERVAL=3D2;BYDAY=3DTU
DTSTAMP:20250624T143616Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:5o8knt1c26rbmq46204rq8mc53@google.com
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
 TRUE;CN=3DDamien Hedde;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.com
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
 TRUE;CN=3Dmimu@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:mimu@linux.vnet.=
ibm.c
 om
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Ddemiobenour@gmail.com;X-NUM-GUESTS=3D0:mailto:demiobenour@gmail.=
com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dhi@alyssa.is;X-NUM-GUESTS=3D0:mailto:hi@alyssa.is
X-MICROSOFT-CDO-OWNERAPPTID:-1619406376
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20250624T143608Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:1
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

--0000000000003876790638524039--

--00000000000038767b063852403d
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjUwNjI0VDEzMDAwMFoNCkRURU5EOjIwMjUwNjI0
VDE0MDAwMFoNClJSVUxFOkZSRVE9V0VFS0xZO1dLU1Q9TU87SU5URVJWQUw9MjtCWURBWT1UVQ0K
RFRTVEFNUDoyMDI1MDYyNFQxNDM2MTZaDQpPUkdBTklaRVI7Q049UUVNVSBQcm9qZWN0IENhbGVu
ZGFyOm1haWx0bzpjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGdyb3UNCiBwLmNhbGVuZGFy
Lmdvb2dsZS5jb20NClVJRDo1bzhrbnQxYzI2cmJtcTQ2MjA0cnE4bWM1M0Bnb29nbGUuY29tDQpB
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
PQ0KIFRSVUU7Q049QWxpc3RhaXIgRnJhbmNpcztYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWtvbnJhZC53
aWxrQG9yYWNsZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtvbnJhZC53aWxrQG9yYWNsZS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049QWxlc3NhbmRybyBEaSBGZWRlcmljbztY
LU5VTS1HVUVTVFM9MDptYWlsdG86YWxlQHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2xnQGthb2Qub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPUFudG9uIEpvaGFuc3NvbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86YW5qb0ByZXYu
bmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Q2hhbyBQZW5nO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpjaGFvLnAucGVuZ0BsaW51eC5pbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049RGFtaWVuIEhlZGRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpkaGVkZGVAa2FscmF5
aW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1FbGVuYSBVZmltdHNldmE7WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPWVyaWMuYXVnZXJAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PWphbi5raXN6a2FAd2ViLmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqYW4ua2lzemthQHdlYi5k
ZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1Kb2FvIE1hcnRpbnM7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049THVjIE1pY2hlbDtYLU5VTS1HVUVTVFM9MDptYWlsdG86bHVjQGxtaWNoZWwuZnIN
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWltdUBsaW51eC52bmV0LmlibS5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOm1pbXVAbGludXgudm5ldC5pYm0uYw0KIG9tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPVNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGk7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnNoYW1lZXJhbGkua29sb3RodW0NCiAudGhvZGlAaHVhd2VpLmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj16Lmh1b0AxMzkuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzp6Lmh1b0AxMzkuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUxJVSBaaGl3ZWk7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cWVtdS1kZXZlbEBub25nbnUub3JnO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049bmVsc29uLmhvQHdpbmRyaXZlci5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm5lbHNv
bi5ob0B3aW5kcml2ZXIuYw0KIG9tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWRlbWlv
YmVub3VyQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZGVtaW9iZW5vdXJAZ21haWwu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWhpQGFseXNzYS5pcztYLU5VTS1HVUVT
VFM9MDptYWlsdG86aGlAYWx5c3NhLmlzDQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6LTE2
MTk0MDYzNzYNCkNSRUFURUQ6MjAyMzAyMjFUMTUzOTUwWg0KREVTQ1JJUFRJT046SWYgeW91IG5l
ZWQgY2FsbCBkZXRhaWxzXCwgcGxlYXNlIGNvbnRhY3QgbWU6IDxhIGhyZWY9Im1haWx0bzpxDQog
dWludGVsYUByZWRoYXQuY29tIj5hbGV4LmJlbm5lZUBsaW5hcm8ub3JnPC9hPg0KTEFTVC1NT0RJ
RklFRDoyMDI1MDYyNFQxNDM2MDhaDQpMT0NBVElPTjpodHRwczovL21lZXQuaml0LnNpL2t2bWNh
bGxtZWV0aW5nDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOlFFTVUvS1ZN
IGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsDQpUUkFOU1A6T1BBUVVFDQpBVFRBQ0g7RklMRU5B
TUU9Tm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsO0ZNVFRZUEU9
YXBwbGljYQ0KIHRpb24vdm5kLmdvb2dsZS1hcHBzLmRvY3VtZW50Omh0dHBzOi8vZG9jcy5nb29n
bGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxMeg0KIHhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1T
SkJHUVpyZWsvZWRpdA0KQkVHSU46VkFMQVJNDQpBQ1RJT046RU1BSUwNCkRFU0NSSVBUSU9OOlRo
aXMgaXMgYW4gZXZlbnQgcmVtaW5kZXINClNVTU1BUlk6QWxhcm0gbm90aWZpY2F0aW9uDQpBVFRF
TkRFRTptYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpUUklHR0VSOi1QMkQNCkVORDpWQUxB
Uk0NCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--00000000000038767b063852403d--

