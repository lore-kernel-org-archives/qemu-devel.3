Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAD6C36018
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqWu9-0000v7-5o; Tue, 17 Sep 2024 08:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mm_pZgsKCl05G9S.69II99GDI5MJ.JMBL9HP-89Q9GIJIBIP.JMB@calendar-server.bounces.google.com>)
 id 1sqWtl-0000AC-3c
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:01:37 -0400
Received: from mail-lf1-x149.google.com ([2a00:1450:4864:20::149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mm_pZgsKCl05G9S.69II99GDI5MJ.JMBL9HP-89Q9GIJIBIP.JMB@calendar-server.bounces.google.com>)
 id 1sqWti-0004XC-7h
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:01:36 -0400
Received: by mail-lf1-x149.google.com with SMTP id
 2adb3069b0e04-5365a82e3dfso1277583e87.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726574490; x=1727179290; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDE1Is+V0e/Cetyo3/pExkC9A80+qBjIRgLYqKfDU28=;
 b=kWrffU70O1Qja1scJpyiga/627WithzX5QYbCkM0Z3xhHIy6dqey/zGvxNzMwdQatr
 i8HCMAHrQGkw8mY4sUUUkYeKGoWJjdAoAkSG140yqWTriEf0UNKEfhD7NDZFSuR1pEKd
 eeUDAaVaaPx02krmKh3PS2Lc0RK3y6qzM4D0CC3faWPmVGak3vQQruZzI3/uTWZvLjtD
 u8IxeZT1YPMvVt3e2dOhUYCO4JeALb8YgED6NZ+EAq611uFzCjMqIaI1nO/boxGojVkO
 vDTMTDmOA9C2kPlVQ6VeWHiR1ZFU3RF5qvy6A3IsVmp0C/GqA/yZg8GRAXtv7nje0CEM
 uxFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726574490; x=1727179290; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDE1Is+V0e/Cetyo3/pExkC9A80+qBjIRgLYqKfDU28=;
 b=p4QHzmiqaPPj/ZUeD6wu7de1gfSF6LfNQXNUojFzCRzMT5DaATUXAgtShDmMMIdUX5
 qEL8YXN+BRVzEl0NUah7MQoHl7JnG2nqOjX2j1OksXEya6Z8UZ663O3kAMXbADU5c9GH
 F0MAzbEs120pz2aDgBK2XGLr2QAOuZZEBKRWMuatTBNGIXjXCK/YodhpBAk3JR9MOsY4
 nZYgracn7jpZ50B29en0DOgYpXFxg48zMDIoGKLc7nJrJWXsvmTVatrN/iXj9BKtAl4M
 7Z3St9uwGFdVuMmTFcwRhnLnyeGhMVe1fAepjRgGQRYVgV4M98/Hw2zJOOiQg8YJiskj
 kJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726574490; x=1727179290;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZDE1Is+V0e/Cetyo3/pExkC9A80+qBjIRgLYqKfDU28=;
 b=ii2G4F+6MirnGF4F6g82wBrS3kAzHMvXiYFq7YCjaptQwGNR8ws5TgtxPGl1BZS3ax
 3+/3medBkdOH+HE19EvRUBNaydC1yxxHLrTrtjUyK0O7v5dDDqkLilMkq1xoja/xyuEM
 3085Bx7Xrq3ayVWTajBKGlHjLpcBiNLQJB+gvZaBhnM90Rix3WY2N6iIqPA4F/9hk+OU
 RYfDz97WB+6g7Chggz3YWhcilPMhByzd49d5Yoswn0/4onCwzCZylyXeQcE4PUeEq4Qo
 YfDSkvks54NKNNvMSynaFrQnURm1283O7CGteNaUVpLiuykE1YpkbiCmpkMVA2MzQ7nP
 X0lQ==
X-Gm-Message-State: AOJu0Yz6mVB8BTIJPr7THvIap1abr5hqDK3fEjcA3OVbuokrzDzLGatz
 5IXU0SJfBuW3oFSAAUav5xchHat5yuOiHd3PJFP6q+wRSOY6zAu1n8ZNyP7PZllQsTvYx6tSZiV
 SHal6l5jK2gN7MeoPrpT5SePdln+KQ1lBtxk6BzqHLnlerSnIUg==
X-Google-Smtp-Source: AGHT+IFPS9mC8OTMqM4ErYwIHtTdQ09ehiN4GiYh1Zi3I8ur7+Uiz9Io/3Cp6YyZM+OdKlz19+LyWjZY+joGlNBPxSo6
MIME-Version: 1.0
X-Received: by 2002:a05:6512:10ce:b0:536:536f:c663 with SMTP id
 2adb3069b0e04-53678fc23cfmr11043832e87.22.1726574490322; Tue, 17 Sep 2024
 05:01:30 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-19098832-2a63-4c7d-bdae-40671bc1667c@google.com>
Date: Tue, 17 Sep 2024 12:01:30 +0000
Subject: Canceled event with note: QEMU/KVM developers conference call @ Tue
 17 Sept 2024 14:00 - 15:00 (BST) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="0000000000002caa8806224f73fc"
Received-SPF: pass client-ip=2a00:1450:4864:20::149;
 envelope-from=3mm_pZgsKCl05G9S.69II99GDI5MJ.JMBL9HP-89Q9GIJIBIP.JMB@calendar-server.bounces.google.com;
 helo=mail-lf1-x149.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002caa8806224f73fc
Content-Type: multipart/alternative; boundary="0000000000002caa8806224f73fa"

--0000000000002caa8806224f73fa
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiBjYW5jZWxlZCB3aXRoIGEgbm90ZToNCiJObyBzeW5jIHRoaXMg
d2Vlaywgc2VlIHlvdSBhbGwgYXQgS1ZNIEZvcnVtIg0KDQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNv
bmZlcmVuY2UgY2FsbA0KVHVlc2RheSAxNyBTZXB0IDIwMjQg4ouFIDE0OjAwIOKAkyAxNTowMA0K
VW5pdGVkIEtpbmdkb20gVGltZQ0KDQpMb2NhdGlvbg0KaHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1j
YWxsbWVldGluZwkNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vdXJsP3E9aHR0cHMlM0ElMkYlMkZt
ZWV0LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5nJnNhPUQmdXN0PTE3MjcwMDY0NjAwMDAwMDAmdXNn
PUFPdlZhdzNBZHNCalowWGxHdDBLTU96LUEyREwNCg0KDQoNCkF0dGFjaG1lbnRzDQpOb3RlcyDi
gJMgUUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwgIA0KaHR0cHM6Ly9kb2NzLmdv
b2dsZS5jb20vZG9jdW1lbnQvZC8xLUx0cTExTEx6eENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNK
QkdRWnJlay9lZGl0DQoNCklmIHlvdSBuZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3Qg
bWU6IGFsZXguYmVubmVlQGxpbmFyby5vcmcNCg0KR3Vlc3RzDQpBbGVzc2FuZHJvIERpIEZlZGVy
aWNvDQpBbGV4IEJlbm7DqWUNCkFsaXN0YWlyIEZyYW5jaXMNCmFybWJydUByZWRoYXQuY29tDQpi
Y2FpbkBxdWljaW5jLmNvbQ0KYmVycmFuZ2VAcmVkaGF0LmNvbQ0KY2ppYUBudmlkaWEuY29tDQpD
w6lkcmljIExlIEdvYXRlcg0KY3dAZjAwZi5vcmcNCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5p
Z2xlc2lhc0BnbWFpbC5jb20NCmVkdWFyZG9AaGFia29zdC5uZXQNCmZlbGlwZUBudXRhbml4LmNv
bQ0KaWdneUB0aGVpZ2d5LmNvbQ0KaW1wQGJzZGltcC5jb20NCmpnZ0BudmlkaWEuY29tDQpqaWRv
bmcueGlhb0BnbWFpbC5jb20NCmppbS5zaHVAc2lmaXZlLmNvbQ0Ka29ucmFkLndpbGtAb3JhY2xl
LmNvbQ0KbWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tDQptZGVhbkByZWRoYXQuY29tDQpwYXVsLndh
bG1zbGV5QHNpZml2ZS5jb20NCnBib256aW5pQHJlZGhhdC5jb20NClBldGVyIE1heWRlbGwNClJp
Y2hhcmQgSGVuZGVyc29uDQpzaGVudGV5QGdtYWlsLmNvbQ0Kc3RlZmFuaGFAZ21haWwuY29tDQp3
ZWkudy53YW5nQGludGVsLmNvbQ0Kend1Lmtlcm5lbEBnbWFpbC5jb20NClBoaWwgTWF0aGlldS1E
YXVkw6kNCmVibG90QHJpdm9zaW5jLmNvbQ0KbWF4LmNob3VAc2lmaXZlLmNvbQ0KTWFub3MgUGl0
c2lkaWFuYWtpcw0KdGh1dGhAcmVkaGF0LmNvbQ0KQW50b24gSm9oYW5zc29uDQpDaGFvIFBlbmcN
CkRhbWllbiBIZWRkZQ0KRWxlbmEgVWZpbXRzZXZhDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmph
bi5raXN6a2FAd2ViLmRlDQpKb2FvIE1hcnRpbnMNCkx1YyBNaWNoZWwNCm1pbXVAbGludXgudm5l
dC5pYm0uY29tDQpTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQp6Lmh1b0AxMzkuY29tDQpMSVUg
Wmhpd2VpDQpxZW11LWRldmVsQG5vbmdudS5vcmcNCg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJv
bSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8N
Cg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5k
ZWUgb24gdGhlIGV2ZW50LiBUbyAgDQpzdG9wIHJlY2VpdmluZyBmdXR1cmUgdXBkYXRlcyBmb3Ig
dGhpcyBldmVudCwgZGVjbGluZSB0aGlzIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRh
dGlvbiBjb3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0
aGUgb3JnYW5pemVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyBy
ZWdhcmRsZXNzIG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlv
dXIgUlNWUC4NCg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRh
ci9hbnN3ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--0000000000002caa8806224f73fa
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
entCancelled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://sc=
hema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar"/=
></span><meta itemprop=3D"eventId/googleCalendar" content=3D"1gvub9435o7hrr=
em0a0ralnl5i_20240917T130000Z"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develope=
rs conference call</span><span aria-hidden=3D"true"><time itemprop=3D"start=
Date" datetime=3D"20240917T130000Z"></time><time itemprop=3D"endDate" datet=
ime=3D"20240917T140000Z"></time></span><table border=3D"0" cellpadding=3D"0=
" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:1=
00%;" class=3D"body-container"><tbody><tr><td style=3D"" class=3D"" align=
=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspaci=
ng=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"height:16px;"=
><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true"> &nbsp; </div=
><!--[if mso | IE]></td></tr></table><![endif]--><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D""><tbody><tr><td style=3D"background-color: #fce8=
e6;color: #2d0c0c;padding: 12px 32px; border-radius: 8px;font-family: Robot=
o, sans-serif;font-size: 14px; line-height: 20px;text-align: left;" class=
=3D"info-bar-inner"><span style=3D"font-weight: 700;">This event has been c=
anceled with a note:</span><br/>"No sync this week, see you all at KVM Foru=
m"</td></tr></tbody></table><!--[if mso | IE]><table border=3D"0" cellpaddi=
ng=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"12" styl=
e=3D"height:12px;"><![endif]--><div style=3D"height:12px;" aria-hidden=3D"t=
rue"> &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=
=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"border=
: solid 1px #dadce0; border-radius: 8px; direction: rtl; font-size: 0; padd=
ing: 24px 32px; text-align: left; vertical-align: top;" class=3D"main-conta=
iner-inner"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspa=
cing=3D"0" role=3D"presentation"><tr><![endif]--><!--[if mso | IE]><td clas=
s=3D"" style=3D"vertical-align:top;width:37%;" ><![endif]--><div class=3D"c=
olumn-per-37 outlook-group-fix" style=3D"font-size: 13px; text-align: left;=
 direction: ltr; display: inline-block; vertical-align: top; width: 100%;ov=
erflow: hidden; word-wrap: break-word;"><table border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"><tbody><tr><td st=
yle=3D"vertical-align:top;padding:0;"><table border=3D"0" cellpadding=3D"0"=
 cellspacing=3D"0" role=3D"presentation" width=3D"100%"><tr><td style=3D"fo=
nt-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-b=
ottom:0px;"><div style=3D"font-family: Roboto, sans-serif;font-size: 14px; =
line-height: 20px; mso-line-height-rule: exactly; text-align: left;" class=
=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><=
tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; =
text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;=
margin: 0; padding: 0;">Attachments</h2></td></tr></table></div></td></tr><=
tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: bre=
ak-word;;padding-bottom:24px;padding-left: 1px; padding-right: 1px;"><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" cla=
ss=3D"attachment-chip" style=3D"border: solid 1px #dadce0; border-radius: 1=
6px; border-collapse: separate; padding: 4px 0 4px 0;"><tr><td style=3D"pad=
ding: 3px 10px; height: 14px; width: 14px;"><img src=3D"https://drive-third=
party.googleusercontent.com/16/type/application/vnd.google-apps.document" w=
idth=3D"14" height=3D"14" alt=3D"" style=3D"display: inline-block; vertical=
-align: middle;"></td><td align=3D"left" style=3D"padding: 0; padding-left:=
 0; padding-right: 10px; max-width: 160px; overflow: hidden; text-overflow:=
 ellipsis; white-space: nowrap;"><div style=3D"overflow: hidden; height: 20=
px;"><a href=3D"https://docs.google.com/document/d/1-Ltq11LLzxCccfqfNNKcMG7=
4HMUJf6DURmSJBGQZrek/edit" target=3D"_blank" style=3D"font-weight: 400;font=
-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-siz=
e: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-=
decoration: none; text-transform: none;;font-family: Roboto, sans-serif;; d=
isplay: inline-block; height: 20px; max-width: 160px; line-height: 20px; ov=
erflow: hidden; text-overflow: ellipsis; vertical-align: middle; white-spac=
e: normal;" class=3D"grey-button-text" title=3D"Notes =E2=80=93 QEMU/KVM de=
velopers conference call">Notes =E2=80=93 QEMU/KVM devel...</a></div></td><=
/tr></table></td></tr></table></td></tr></tbody></table></div><!--[if mso |=
 IE]></td><![endif]--><!--[if mso | IE]><td class=3D"" style=3D"vertical-al=
ign:top;width:63%;padding-right:32px;" ><![endif]--><div class=3D"column-pe=
r-63 outlook-group-fix" style=3D"font-size: 13px; text-align: left; directi=
on: ltr; display: inline-block; vertical-align: top; width: 100%;overflow: =
hidden; word-wrap: break-word;"><table border=3D"0" cellpadding=3D"0" cells=
pacing=3D"0" role=3D"presentation" width=3D"100%" class=3D"main-column-tabl=
e-ltr" style=3D"padding-right: 32px; padding-left: 0;;table-layout: fixed;"=
><tbody><tr><td class=3D"main-column-td" style=3D"padding:0; vertical-align=
:top;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation" width=3D"100%" style=3D"table-layout: fixed;"><tr><td style=3D"fo=
nt-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-b=
ottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: norm=
al; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0=
.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D=
"presentation"><span>If you need call details, please contact me: <a href=
=3D"mailto:quintela@redhat.com" target=3D"_blank">alex.bennee@linaro.org</a=
></span><meta itemprop=3D"description" content=3D"If you need call details,=
 please contact me: alex.bennee@linaro.org"/></div></td></tr><tr><td style=
=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;pad=
ding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style=
: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spac=
ing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text" r=
ole=3D"presentation"><span aria-hidden=3D"true"><time itemprop=3D"startDate=
" datetime=3D"20240917T130000Z"></time><time itemprop=3D"endDate" datetime=
=3D"20240917T140000Z"></time></span><table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><=
td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text=
-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;marg=
in: 0; padding: 0;">When</h2></td></tr></table><span>Tuesday 17 Sept 2024 =
=E2=8B=85 14:00 =E2=80=93 15:00 (United Kingdom Time)</span></div></td></tr=
><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: b=
reak-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-se=
rif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20p=
x; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"p=
rimary-text" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" ce=
llspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><t=
d><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-=
decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;margi=
n: 0; padding: 0;">Location</h2></td></tr></table><span itemprop=3D"locatio=
n" itemscope itemtype=3D"http://schema.org/Place"><span itemprop=3D"name" c=
lass=3D"primary-text notranslate" style=3D"font-family: Roboto, sans-serif;=
font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; l=
etter-spacing: 0.2px;color: #3c4043; text-decoration: none;">https://meet.j=
it.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.com/url?q=3Dh=
ttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D172700646000=
0000&amp;usg=3DAOvVaw3AdsBjZ0XlGt0KMOz-A2DL" class=3D"accent-text underline=
-on-hover" style=3D"display: inline-block;;color: #1a73e8; text-decoration:=
 none;font-weight: 700;" target=3D"_blank" itemprop=3D"map">View map</a></s=
pan></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: =
left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-fami=
ly: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14p=
x; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration=
: none;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-b=
ottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;co=
lor: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing=
: antialiased;margin: 0; padding: 0;">Guests</h2></td></tr></table><div sty=
le=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;"><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:ale@rev.ng">Alessandro Di Federico</a></span><meta ite=
mprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"secondary-tex=
t" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span=
 itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><spa=
n itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underlin=
e-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration=
: none;" href=3D"mailto:alex.bennee@linaro.org">Alex Benn=C3=A9e</a></span>=
<meta itemprop=3D"email" content=3D"alex.bennee@linaro.org"/></span><span c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></=
span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sc=
hema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"=
primary-text underline-on-hover" style=3D"display: inline-block;;color: #3c=
4043; text-decoration: none;" href=3D"mailto:alistair.francis@wdc.com">Alis=
tair Francis</a></span><meta itemprop=3D"email" content=3D"alistair.francis=
@wdc.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:armbr=
u@redhat.com">armbru@redhat.com</a></span><meta itemprop=3D"email" content=
=3D"armbru@redhat.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:bcain@quicinc.com">bcain@quicinc.com</a></span><meta itemprop=3D"em=
ail" content=3D"bcain@quicinc.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a></span><met=
a itemprop=3D"email" content=3D"berrange@redhat.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a><=
/span><meta itemprop=3D"email" content=3D"cjia@nvidia.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:clg@kaod.org">C=C3=A9dric Le Go=
ater</a></span><meta itemprop=3D"email" content=3D"clg@kaod.org"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org<=
/a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:eblake@redhat.com">eblake@redha=
t.com</a></span><meta itemprop=3D"email" content=3D"eblake@redhat.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.iglesias@gm=
ail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email" conten=
t=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</a></span><meta it=
emprop=3D"email" content=3D"eduardo@habkost.net"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:felipe@nutanix.com">felipe@nutanix.com</a=
></span><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:iggy@theiggy.com">iggy@the=
iggy.com</a></span><meta itemprop=3D"email" content=3D"iggy@theiggy.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:imp@bsdimp.com">i=
mp@bsdimp.com</a></span><meta itemprop=3D"email" content=3D"imp@bsdimp.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:jgg@nvidia.com=
">jgg@nvidia.com</a></span><meta itemprop=3D"email" content=3D"jgg@nvidia.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jidong.xiao=
@gmail.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"email" conten=
t=3D"jidong.xiao@gmail.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:jim.shu@sifive.com">jim.shu@sifive.com</a></span><meta itemp=
rop=3D"email" content=3D"jim.shu@sifive.com"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@oracle.co=
m</a></span><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.com"/></=
span><span class=3D"secondary-text" style=3D"color: #70757a; text-decoratio=
n: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
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
to:anjo@rev.ng">Anton Johansson</a></span><meta itemprop=3D"email" content=
=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:chao.p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"email"=
 content=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:dhedde@kalrayinc.com">Damien Hedde</a></span><met=
a itemprop=3D"email" content=3D"dhedde@kalrayinc.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena =
Ufimtseva</a></span><meta itemprop=3D"email" content=3D"elena.ufimtseva@ora=
cle.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsco=
pe itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"n=
otranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: =
inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.a=
uger@redhat.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" c=
ontent=3D"eric.auger@redhat.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta item=
prop=3D"email" content=3D"jan.kiszka@web.de"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></=
span><meta itemprop=3D"email" content=3D"joao.m.martins@oracle.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:luc@lmichel.fr">Luc Mi=
chel</a></span><meta itemprop=3D"email" content=3D"luc@lmichel.fr"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:mimu@linux.vnet.ibm.com=
">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"mim=
u@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:shameerali.kolothum.thodi@huawei.com">Shameerali Kolothum Thodi</a><=
/span><meta itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@139.=
com">z.huo@139.com</a></span><meta itemprop=3D"email" content=3D"z.huo@139.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:zhiwei_liu=
@linux.alibaba.com">LIU Zhiwei</a></span><meta itemprop=3D"email" content=
=3D"zhiwei_liu@linux.alibaba.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></span><=
meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div></div></div></td></tr></table></td></tr></tbody></table></div><!--=
[if mso | IE]></td><![endif]--><!--[if mso | IE]></tr></table><![endif]--><=
/td></tr></tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" class=
=3D""><tbody><tr><td style=3D"font-size: 0; padding: 0; text-align: left; w=
ord-break: break-word;;padding:4px 12px;" class=3D"" align=3D"left"><div cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;font-=
family: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-hei=
ght-rule: exactly; text-align: left;"><p>Invitation from <a href=3D"https:/=
/calendar.google.com/calendar/" class=3D"accent-text underline-on-hover" st=
yle=3D"font-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; =
mso-line-height-rule: exactly;;color: #1a73e8; text-decoration: none;" targ=
et=3D"_blank">Google Calendar</a></p><p>You are receiving this email becaus=
e you are an attendee on the event. To stop receiving future updates for th=
is event, decline this event.</p><p>Forwarding this invitation could allow =
any recipient to send a response to the organizer, be added to the guest li=
st, invite others regardless of their own invitation status, or modify your=
 RSVP. <a class=3D"accent-text underline-on-hover" style=3D"font-family: Ro=
boto, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: =
exactly;;color: #1a73e8; text-decoration: none;" href=3D"https://support.go=
ogle.com/calendar/answer/37135#forwarding">Learn more</a></p></div></td></t=
r></tbody></table></td></tr></tbody></table></span></span></body></html>
--0000000000002caa8806224f73fa
Content-Type: text/calendar; charset="UTF-8"; method=CANCEL
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:CANCEL
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
DTSTART;TZID=3DAmerica/New_York:20240917T090000
DTEND;TZID=3DAmerica/New_York:20240917T100000
DTSTAMP:20240917T120130Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20240820T130000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DAl
 essandro Di Federico;X-NUM-GUESTS=3D0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;X-NUM
 -GUESTS=3D0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DAl
 istair Francis;X-NUM-GUESTS=3D0:mailto:alistair.francis@wdc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dar
 mbru@redhat.com;X-NUM-GUESTS=3D0:mailto:armbru@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dbc
 ain@quicinc.com;X-NUM-GUESTS=3D0:mailto:bcain@quicinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dbe
 rrange@redhat.com;X-NUM-GUESTS=3D0:mailto:berrange@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dcj
 ia@nvidia.com;X-NUM-GUESTS=3D0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;X-NUM
 -GUESTS=3D0:mailto:clg@kaod.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dcw
 @f00f.org;X-NUM-GUESTS=3D0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Deb
 lake@redhat.com;X-NUM-GUESTS=3D0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Ded
 gar.iglesias@gmail.com;X-NUM-GUESTS=3D0:mailto:edgar.iglesias@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Deduar
 do@habkost.net;X-NUM-GUESTS=3D0:mailto:eduardo@habkost.net
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dfe
 lipe@nutanix.com;X-NUM-GUESTS=3D0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dig
 gy@theiggy.com;X-NUM-GUESTS=3D0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dim
 p@bsdimp.com;X-NUM-GUESTS=3D0:mailto:imp@bsdimp.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Djg
 g@nvidia.com;X-NUM-GUESTS=3D0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dji
 dong.xiao@gmail.com;X-NUM-GUESTS=3D0:mailto:jidong.xiao@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dji
 m.shu@sifive.com;X-NUM-GUESTS=3D0:mailto:jim.shu@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dko
 nrad.wilk@oracle.com;X-NUM-GUESTS=3D0:mailto:konrad.wilk@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dmb
 urton@qti.qualcomm.com;X-NUM-GUESTS=3D0:mailto:mburton@qti.qualcomm.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;CN=
=3Dmdean@
 redhat.com;X-NUM-GUESTS=3D0;X-RESPONSE-COMMENT=3D"Declined because I am ou=
t of=20
 office":mailto:mdean@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Dpaul.
 walmsley@sifive.com;X-NUM-GUESTS=3D0:mailto:paul.walmsley@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dpb
 onzini@redhat.com;X-NUM-GUESTS=3D0:mailto:pbonzini@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DPe
 ter Maydell;X-NUM-GUESTS=3D0:mailto:peter.maydell@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;CN=
=3DRichar
 d Henderson;X-NUM-GUESTS=3D0:mailto:richard.henderson@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Dshent
 ey@gmail.com;X-NUM-GUESTS=3D0:mailto:shentey@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Dstefa
 nha@gmail.com;X-NUM-GUESTS=3D0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dwe
 i.w.wang@intel.com;X-NUM-GUESTS=3D0:mailto:wei.w.wang@intel.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dzw
 u.kernel@gmail.com;X-NUM-GUESTS=3D0:mailto:zwu.kernel@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;X-NUM
 -GUESTS=3D0:mailto:philmd@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Deblot
 @rivosinc.com;X-NUM-GUESTS=3D0:mailto:eblot@rivosinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dma
 x.chou@sifive.com;X-NUM-GUESTS=3D0:mailto:max.chou@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;CN=
=3DManos=20
 Pitsidianakis;X-NUM-GUESTS=3D0:mailto:manos.pitsidianakis@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dth
 uth@redhat.com;X-NUM-GUESTS=3D0:mailto:thuth@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DAn
 ton Johansson;X-NUM-GUESTS=3D0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DCh
 ao Peng;X-NUM-GUESTS=3D0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;CN=
=3DDamien
  Hedde;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DEl
 ena Ufimtseva;X-NUM-GUESTS=3D0:mailto:elena.ufimtseva@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Der
 ic.auger@redhat.com;X-NUM-GUESTS=3D0:mailto:eric.auger@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dja
 n.kiszka@web.de;X-NUM-GUESTS=3D0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DJo
 ao Martins;X-NUM-GUESTS=3D0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DLu
 c Michel;X-NUM-GUESTS=3D0:mailto:luc@lmichel.fr
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dmi
 mu@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:mimu@linux.vnet.ibm.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DSh
 ameerali Kolothum Thodi;X-NUM-GUESTS=3D0:mailto:shameerali.kolothum.thodi@=
hua
 wei.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dz.
 huo@139.com;X-NUM-GUESTS=3D0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DLI
 U Zhiwei;X-NUM-GUESTS=3D0:mailto:zhiwei_liu@linux.alibaba.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;CN=
=3Dqemu-d
 evel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.org
RECURRENCE-ID;TZID=3DAmerica/New_York:20240917T090000
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20240917T120127Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:1
STATUS:CANCELLED
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

--0000000000002caa8806224f73fa--

--0000000000002caa8806224f73fc
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6Q0FOQ0VM
DQpCRUdJTjpWVElNRVpPTkUNClRaSUQ6QW1lcmljYS9OZXdfWW9yaw0KWC1MSUMtTE9DQVRJT046
QW1lcmljYS9OZXdfWW9yaw0KQkVHSU46REFZTElHSFQNClRaT0ZGU0VURlJPTTotMDUwMA0KVFpP
RkZTRVRUTzotMDQwMA0KVFpOQU1FOkVEVA0KRFRTVEFSVDoxOTcwMDMwOFQwMjAwMDANClJSVUxF
OkZSRVE9WUVBUkxZO0JZTU9OVEg9MztCWURBWT0yU1UNCkVORDpEQVlMSUdIVA0KQkVHSU46U1RB
TkRBUkQNClRaT0ZGU0VURlJPTTotMDQwMA0KVFpPRkZTRVRUTzotMDUwMA0KVFpOQU1FOkVTVA0K
RFRTVEFSVDoxOTcwMTEwMVQwMjAwMDANClJSVUxFOkZSRVE9WUVBUkxZO0JZTU9OVEg9MTE7QllE
QVk9MVNVDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNDA5MTdUMDkwMDAwDQpEVEVORDtUWklEPUFtZXJp
Y2EvTmV3X1lvcms6MjAyNDA5MTdUMTAwMDAwDQpEVFNUQU1QOjIwMjQwOTE3VDEyMDEzMFoNCk9S
R0FOSVpFUjtDTj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJr
dTVzaTAxYmxtbmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjFndnViOTQzNW83
aHJyZW0wYTByYWxubDVpX1IyMDI0MDgyMFQxMzAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O0NOPUFsDQogZXNzYW5kcm8gRGkgRmVkZXJpY287WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsZUBy
ZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtYLU5VTQ0KIC1HVUVTVFM9MDptYWlsdG86YWxleC5iZW5uZWVA
bGluYXJvLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPUFsDQogaXN0YWlyIEZyYW5jaXM7WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWFy
DQogbWJydUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphcm1icnVAcmVkaGF0LmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO0NOPWJjDQogYWluQHF1aWNpbmMuY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpiY2FpbkBxdWljaW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWJlDQogcnJhbmdlQHJlZGhh
dC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtDTj1jag0KIGlhQG52aWRpYS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNqaWFAbnZp
ZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1gtTlVNDQogLUdVRVNUUz0wOm1haWx0bzpjbGdAa2FvZC5v
cmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtDTj1jdw0KIEBmMDBmLm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86
Y3dAZjAwZi5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1lYg0KIGxha2VAcmVkaGF0LmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86ZWJsYWtlQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1lZA0KIGdh
ci5pZ2xlc2lhc0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVkZ2FyLmlnbGVzaWFz
QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO0NOPWVkdWFyDQogZG9AaGFia29zdC5uZXQ7WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmVkdWFyZG9AaGFia29zdC5uZXQNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1mZQ0KIGxp
cGVAbnV0YW5peC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmZlbGlwZUBudXRhbml4LmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO0NOPWlnDQogZ3lAdGhlaWdneS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OmlnZ3lAdGhlaWdneS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1pbQ0KIHBAYnNkaW1wLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86aW1wQGJzZGltcC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1qZw0KIGdA
bnZpZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amdnQG52aWRpYS5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtDTj1qaQ0KIGRvbmcueGlhb0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpp
ZG9uZy54aWFvQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWppDQogbS5zaHVAc2lmaXZlLmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amltLnNodUBzaWZpdmUuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
Q049a28NCiBucmFkLndpbGtAb3JhY2xlLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86a29ucmFk
LndpbGtAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPW1iDQogdXJ0b25AcXRpLnF1YWxjb21t
LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUNM
SU5FRDtDTj1tZGVhbkANCiByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wO1gtUkVTUE9OU0UtQ09N
TUVOVD0iRGVjbGluZWQgYmVjYXVzZSBJIGFtIG91dCBvZiANCiBvZmZpY2UiOm1haWx0bzptZGVh
bkByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1URU5UQVRJVkU7Q049cGF1bC4NCiB3YWxtc2xleUBzaWZpdmUuY29tO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtDTj1wYg0KIG9uemluaUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYm9uemlu
aUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049UGUNCiB0ZXIgTWF5ZGVsbDtYLU5VTS1HVUVT
VFM9MDptYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUNMSU5FRDtDTj1SaWNoYXIN
CiBkIEhlbmRlcnNvbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86cmljaGFyZC5oZW5kZXJzb25AbGlu
YXJvLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9VEVOVEFUSVZFO0NOPXNoZW50DQogZXlAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpzaGVudGV5QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO0NOPXN0ZWZhDQogbmhhQGdtYWls
LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c3RlZmFuaGFAZ21haWwuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047Q049d2UNCiBpLncud2FuZ0BpbnRlbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOndlaS53
LndhbmdAaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049encNCiB1Lmtlcm5lbEBnbWFpbC5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
WC1OVU0NCiAtR1VFU1RTPTA6bWFpbHRvOnBoaWxtZEBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJVkU7Q049
ZWJsb3QNCiBAcml2b3NpbmMuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxvdEByaXZvc2lu
Yy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtDTj1tYQ0KIHguY2hvdUBzaWZpdmUuY29tO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzptYXguY2hvdUBzaWZpdmUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUNMSU5FRDtDTj1NYW5vcyANCiBQaXRz
aWRpYW5ha2lzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYW5vcy5waXRzaWRpYW5ha2lzQGxpbmFy
by5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtDTj10aA0KIHV0aEByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzp0aHV0aEByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049QW4NCiB0b24gSm9oYW5z
c29uO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbmpvQHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPUNo
DQogYW8gUGVuZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50ZWwu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1BQ0NFUFRFRDtDTj1EYW1pZW4NCiAgSGVkZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmRo
ZWRkZUBrYWxyYXlpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049RWwNCiBlbmEgVWZpbXRzZXZhO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO0NOPWVyDQogaWMuYXVnZXJAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZXJp
Yy5hdWdlckByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049amENCiBuLmtpc3prYUB3ZWIuZGU7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmphbi5raXN6a2FAd2ViLmRlDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049
Sm8NCiBhbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqb2FvLm0ubWFydGluc0BvcmFj
bGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047Q049THUNCiBjIE1pY2hlbDtYLU5VTS1HVUVTVFM9MDptYWls
dG86bHVjQGxtaWNoZWwuZnINCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1taQ0KIG11QGxpbnV4LnZuZXQuaWJt
LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWltdUBsaW51eC52bmV0LmlibS5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtDTj1TaA0KIGFtZWVyYWxpIEtvbG90aHVtIFRob2RpO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YQ0KIHdlaS5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtDTj16Lg0KIGh1b0AxMzkuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6Lmh1b0AxMzkuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047Q049TEkNCiBVIFpoaXdlaTtYLU5VTS1HVUVTVFM9MDptYWlsdG86emhp
d2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7Q049cWVtdS1kDQogZXZlbEBub25n
bnUub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNClJFQ1VS
UkVOQ0UtSUQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjQwOTE3VDA5MDAwMA0KQ1JFQVRFRDoy
MDIzMDIyMVQxNTM5NTBaDQpERVNDUklQVElPTjpJZiB5b3UgbmVlZCBjYWxsIGRldGFpbHNcLCBw
bGVhc2UgY29udGFjdCBtZTogPGEgaHJlZj0ibWFpbHRvOnENCiB1aW50ZWxhQHJlZGhhdC5jb20i
PmFsZXguYmVubmVlQGxpbmFyby5vcmc8L2E+DQpMQVNULU1PRElGSUVEOjIwMjQwOTE3VDEyMDEy
N1oNCkxPQ0FUSU9OOmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcNClNFUVVFTkNF
OjENClNUQVRVUzpDQU5DRUxMRUQNClNVTU1BUlk6UUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJl
bmNlIGNhbGwNClRSQU5TUDpPUEFRVUUNCkFUVEFDSDtGSUxFTkFNRT1Ob3RlcyDigJMgUUVNVS9L
Vk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGw7Rk1UVFlQRT1hcHBsaWNhDQogdGlvbi92bmQu
Z29vZ2xlLWFwcHMuZG9jdW1lbnQ6aHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQvZC8x
LUx0cTExTEx6DQogeENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNKQkdRWnJlay9lZGl0DQpCRUdJ
TjpWQUxBUk0NCkFDVElPTjpFTUFJTA0KREVTQ1JJUFRJT046VGhpcyBpcyBhbiBldmVudCByZW1p
bmRlcg0KU1VNTUFSWTpBbGFybSBub3RpZmljYXRpb24NCkFUVEVOREVFOm1haWx0bzpxZW11LWRl
dmVsQG5vbmdudS5vcmcNClRSSUdHRVI6LVAyRA0KRU5EOlZBTEFSTQ0KRU5EOlZFVkVOVA0KRU5E
OlZDQUxFTkRBUg0K
--0000000000002caa8806224f73fc--

