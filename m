Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C399CC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4lF-0003IT-Df; Tue, 24 Jun 2025 10:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU4l5-0003Gg-2H
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:36:23 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU4l0-0006cb-IO
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:36:22 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-3a4eec544c6so294904f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750775777; x=1751380577; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tdEY33KHavXoiMa5uw3DRfrfMndnbymqszFZlqgWmfc=;
 b=4NZ9jyxidTXoBYfILTTPg+lMtNO7cRGjyuPd1gOjydVv3OKF9yLlMu3pRmYx3khlnR
 0NoRdXHwh0TohYs0+AnXzeHCIgAIjrf647bcXXWFAKcht24hJPLeRyHRSF5ARoX4k8ng
 1ILCwvjAXIh9kg9hYzFt5Ai401A5snj6/BYeGmD5RhpNLypWw0WipapwwfTaBFzOI9EB
 nbdz7m5puDnkuD4/oucMfI8jPAU2Htn0b1CCj7I4PtDClekTZCD5IaBLgVo7BEQeO8Yu
 zYd5wpD1oFfNViBWbJw6ePqIXdY8U7XSTuLx7YKHKfJomXXwzbD4YIs1s6IosRARec02
 bfrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750775777; x=1751380577; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tdEY33KHavXoiMa5uw3DRfrfMndnbymqszFZlqgWmfc=;
 b=pFPY2dCxJbemB+SnV2XW5q4HUc28+r4jmX8H7+LZVGZKXm8QY6Va+pCZ0lrXPh3E+B
 I2T50PRvCJIbwp5i+RjP+nZJozSJXTAUL134SAnpIe+uBTT0CIQGwrlyTQOK8pu9GKIe
 HjRBBd+SmBEtKYgT2+giL18q6YRGZWmsJtLRst9OAfP+DyvzxO8a/fmqCmV2+Idd6fG/
 MMzbpQJ/A24UBp5iTer0jsblXsfVnHKl0+QLiwRTHsSK1PGmRu051xBGBI3NQXQ3VA67
 D5WvmCsdn858PCTw7S723iPAiPhgiwH8Xu2FC0HtprSmFnBRtfbLkE+99Z3BTpaWGPxe
 HqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775777; x=1751380577;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tdEY33KHavXoiMa5uw3DRfrfMndnbymqszFZlqgWmfc=;
 b=Tyl2t/q1SlJ3Xwr6mHrXdJ1fj0cRKG7Ae9nF7CEwEEL4FEkgIDElvFC6VGT1o3HVSG
 8Gt0NC4guaR3UE0QIfNfAb6sm4V/2Z3TA91uf+6PbZDmgq8KOI2KzcsUgXt6cRrYwGxG
 +mw5WAOtCpxvq/Yw0xzaj1wiEColp58U6RUBVuimLJnc6sOkiPUFcyK6WPtrvbv5h/Fq
 npxPB99RPlhofpHPKhpilWSU2XmivxBF/8eBMDMpqlqpAo7fJd6UKBd4P26/ppqwpY1d
 7aXfZ50rTgR/5McrTzxWJsBraQQUjUEkO1+iqOv+2y9WlVfWoSuHweCRsvfeODJRbX1B
 YuWA==
X-Gm-Message-State: AOJu0YyiZvoruKmg7LRYUlJ0veT/Tae0iPiWEAu41huCdaE2ZYBEWK1p
 gWMy5KmdRCsA+V32guO8063cYrivSYHJJLaPGhE/REDrwHGakFGlMqYi3plunyR2zpba6dhzPC/
 CQuEhE1PhBpb8zGZ1+q0i/cCtZ+n/LKqtH12gE3esgAlpB/S9TKetsQ==
X-Google-Smtp-Source: AGHT+IEe96wduaMV0u4VNw5LJaX1A3CQSAi1RkrE1q/Zf6lVeNeGAIUr70ua7Yqh+oyvxCfX2MDLjH18Glm4oaXpEiN3
MIME-Version: 1.0
X-Received: by 2002:a05:6000:2d0f:b0:3a5:2d42:aa23 with SMTP id
 ffacd0b85a97d-3a6d1303b54mr9171243f8f.22.1750775776471; Tue, 24 Jun 2025
 07:36:16 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-96dd3170-4351-4bbe-b38e-1417e4ccb4aa@google.com>
Date: Tue, 24 Jun 2025 14:36:16 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ (BST)
 (qemu-devel@nongnu.org)
From: alex.bennee@linaro.org
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="0000000000003d1ed20638524006"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x44a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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
Reply-To: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000003d1ed20638524006
Content-Type: multipart/alternative; boundary="0000000000003d1ed10638524004"

--0000000000003d1ed10638524004
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KDQpVbml0ZWQgS2luZ2RvbSBU
aW1lDQoNCkxvY2F0aW9uDQpodHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0
cHM6Ly93d3cuZ29vZ2xlLmNvbS91cmw/cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3Zt
Y2FsbG1lZXRpbmcmc2E9RCZ1c3Q9MTc1MTIwNzc2MDAwMDAwMCZ1c2c9QU92VmF3Mzg0eTlnNnRE
dWtFR1l0MkZpWFlUTw0KDQoNCg0KQXR0YWNobWVudHMNCk5vdGVzIOKAkyBRRU1VL0tWTSBkZXZl
bG9wZXJzIGNvbmZlcmVuY2UgY2FsbCAgDQpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVu
dC9kLzEtTHRxMTFMTHp4Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCg0K
SWYgeW91IG5lZWQgY2FsbCBkZXRhaWxzLCBwbGVhc2UgY29udGFjdCBtZTogYWxleC5iZW5uZWVA
bGluYXJvLm9yZw0KDQpHdWVzdHMNCmFsZXguYmVubmVlQGxpbmFyby5vcmcNCmFybWJydUByZWRo
YXQuY29tDQpiY2FpbkBxdWljaW5jLmNvbQ0KYmVycmFuZ2VAcmVkaGF0LmNvbQ0KY2ppYUBudmlk
aWEuY29tDQpjd0BmMDBmLm9yZw0KZWJsYWtlQHJlZGhhdC5jb20NCmVkZ2FyLmlnbGVzaWFzQGdt
YWlsLmNvbQ0KZWR1YXJkb0BoYWJrb3N0Lm5ldA0KZmVsaXBlQG51dGFuaXguY29tDQppZ2d5QHRo
ZWlnZ3kuY29tDQppbXBAYnNkaW1wLmNvbQ0KamdnQG52aWRpYS5jb20NCmppZG9uZy54aWFvQGdt
YWlsLmNvbQ0KamltLnNodUBzaWZpdmUuY29tDQptYnVydG9uQHF0aS5xdWFsY29tbS5jb20NCm1k
ZWFuQHJlZGhhdC5jb20NCnBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbQ0KcGJvbnppbmlAcmVkaGF0
LmNvbQ0KcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8u
b3JnDQpzaGVudGV5QGdtYWlsLmNvbQ0Kc3RlZmFuaGFAZ21haWwuY29tDQp3ZWkudy53YW5nQGlu
dGVsLmNvbQ0Kend1Lmtlcm5lbEBnbWFpbC5jb20NCnBoaWxtZEBsaW5hcm8ub3JnDQplYmxvdEBy
aXZvc2luYy5jb20NCm1heC5jaG91QHNpZml2ZS5jb20NCm1hbm9zLnBpdHNpZGlhbmFraXNAbGlu
YXJvLm9yZw0KdGh1dGhAcmVkaGF0LmNvbQ0KcmJjQG1ldGEuY29tDQphbGlzdGFpci5mcmFuY2lz
QHdkYy5jb20NCmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCmFsZUByZXYubmcNCmNsZ0BrYW9kLm9y
Zw0KYW5qb0ByZXYubmcNCmNoYW8ucC5wZW5nQGxpbnV4LmludGVsLmNvbQ0KZGhlZGRlQGthbHJh
eWluYy5jb20NCmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tDQplcmljLmF1Z2VyQHJlZGhhdC5j
b20NCmphbi5raXN6a2FAd2ViLmRlDQpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpsdWNAbG1p
Y2hlbC5mcg0KbWltdUBsaW51eC52bmV0LmlibS5jb20NCnNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbQ0Kei5odW9AMTM5LmNvbQ0Kemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNv
bQ0KcWVtdS1kZXZlbEBub25nbnUub3JnDQpuZWxzb24uaG9Ad2luZHJpdmVyLmNvbQ0KZGVtaW9i
ZW5vdXJAZ21haWwuY29tDQpoaUBhbHlzc2EuaXMNCg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJv
bSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8N
Cg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5k
ZWUgb24gdGhlIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3VsZCBhbGxv
dyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5pemVyLCBi
ZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNzIG9mICAN
CnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4NCg0KTGVh
cm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIvMzcxMzUj
Zm9yd2FyZGluZw0K
--0000000000003d1ed10638524004
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
/InformAction"><span itemprop=3D"object" itemscope itemtype=3D"http://schem=
a.org/Event"><meta itemprop=3D"eventStatus" content=3D"http://schema.org/Ev=
entScheduled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://sc=
hema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar"/=
></span><meta itemprop=3D"eventId/googleCalendar" content=3D"1gvub9435o7hrr=
em0a0ralnl5i_R20250624T130000"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develope=
rs conference call</span><span aria-hidden=3D"true"><time itemprop=3D"start=
Date" datetime=3D"20250624T130000Z"></time><time itemprop=3D"endDate" datet=
ime=3D"20250624T140000Z"></time></span><table border=3D"0" cellpadding=3D"0=
" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:1=
00%;" class=3D"body-container"><tbody><tr><td style=3D"" class=3D"" align=
=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspaci=
ng=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"height:16px;"=
><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true"> &nbsp; </div=
><!--[if mso | IE]></td></tr></table><![endif]--><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D""><tbody><tr><td style=3D"background-color: #fef7=
e0;color: #340f03;padding: 12px 32px; border-radius: 8px;font-family: Robot=
o, sans-serif;font-size: 14px; line-height: 20px;text-align: left;" class=
=3D"info-bar-inner"><span style=3D"font-weight: 700;">This email keeps the =
event up to date in your calendar.</span><br><b>Set up inbox filters to hid=
e this and similar calendar sync emails.</b><br><a style=3D"text-decoration=
: underline !important; color: #340f03 !important;" href=3D"https://support=
.google.com/calendar?p=3Dfilter_invitations" target=3D"_blank">Learn more a=
bout calendar sync emails and setting up filters</a></td></tr></tbody></tab=
le><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0=
" role=3D"presentation"><tr><td height=3D"12" style=3D"height:12px;"><![end=
if]--><div style=3D"height:12px;" aria-hidden=3D"true"> &nbsp; </div><!--[i=
f mso | IE]></td></tr></table><![endif]--><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"wi=
dth:100%;" class=3D""><tbody><tr><td style=3D"border: solid 1px #dadce0; bo=
rder-radius: 8px; direction: rtl; font-size: 0; padding: 24px 32px; text-al=
ign: left; vertical-align: top;" class=3D"main-container-inner"><!--[if mso=
 | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation"><tr><![endif]--><!--[if mso | IE]><td class=3D"" style=3D"vertica=
l-align:top;width:37%;" ><![endif]--><div class=3D"column-per-37 outlook-gr=
oup-fix" style=3D"font-size: 13px; text-align: left; direction: ltr; displa=
y: inline-block; vertical-align: top; width: 100%;overflow: hidden; word-wr=
ap: break-word;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" ro=
le=3D"presentation" width=3D"100%"><tbody><tr><td style=3D"vertical-align:t=
op;padding:0;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" width=3D"100%"><tr><td style=3D"font-size: 0; padding: 0;=
 text-align: left; word-break: break-word;;padding-bottom:0px;"><div style=
=3D"font-family: Roboto, sans-serif;font-size: 14px; line-height: 20px; mso=
-line-height-rule: exactly; text-align: left;" class=3D"primary-text" role=
=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" r=
ole=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"pr=
imary-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;=
font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;=
">Attachments</h2></td></tr></table></div></td></tr><tr><td style=3D"font-s=
ize: 0; padding: 0; text-align: left; word-break: break-word;;padding-botto=
m:24px;padding-left: 1px; padding-right: 1px;"><table border=3D"0" cellpadd=
ing=3D"0" cellspacing=3D"0" role=3D"presentation" class=3D"attachment-chip"=
 style=3D"border: solid 1px #dadce0; border-radius: 16px; border-collapse: =
separate; padding: 4px 0 4px 0;"><tr><td style=3D"padding: 3px 10px; height=
: 14px; width: 14px;"><img src=3D"https://drive-thirdparty.googleuserconten=
t.com/16/type/application/vnd.google-apps.document" width=3D"14" height=3D"=
14" alt=3D"" style=3D"display: inline-block; vertical-align: middle;"></td>=
<td align=3D"left" style=3D"padding: 0; padding-left: 0; padding-right: 10p=
x; max-width: 160px; overflow: hidden; text-overflow: ellipsis; white-space=
: nowrap;"><div style=3D"overflow: hidden; height: 20px;"><a href=3D"https:=
//docs.google.com/document/d/1-Ltq11LLzxCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/e=
dit" target=3D"_blank" style=3D"font-weight: 400;font-family: &#39;Google S=
ans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: =
120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; text=
-transform: none;;font-family: Roboto, sans-serif;; display: inline-block; =
height: 20px; max-width: 160px; line-height: 20px; overflow: hidden; text-o=
verflow: ellipsis; vertical-align: middle; white-space: normal;" class=3D"g=
rey-button-text" title=3D"Notes =E2=80=93 QEMU/KVM developers conference ca=
ll">Notes =E2=80=93 QEMU/KVM devel...</a></div></td></tr></table></td></tr>=
</table></td></tr></tbody></table></div><!--[if mso | IE]></td><![endif]-->=
<!--[if mso | IE]><td class=3D"" style=3D"vertical-align:top;width:63%;padd=
ing-right:32px;" ><![endif]--><div class=3D"column-per-63 outlook-group-fix=
" style=3D"font-size: 13px; text-align: left; direction: ltr; display: inli=
ne-block; vertical-align: top; width: 100%;overflow: hidden; word-wrap: bre=
ak-word;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"p=
resentation" width=3D"100%" class=3D"main-column-table-ltr" style=3D"paddin=
g-right: 32px; padding-left: 0;;table-layout: fixed;"><tbody><tr><td class=
=3D"main-column-td" style=3D"padding:0; vertical-align:top;"><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"1=
00%" style=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0; padding:=
 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div st=
yle=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400=
; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043;=
 text-decoration: none;" class=3D"primary-text" role=3D"presentation"><span=
>If you need call details, please contact me: <a href=3D"mailto:quintela@re=
dhat.com" target=3D"_blank">alex.bennee@linaro.org</a></span><meta itemprop=
=3D"description" content=3D"If you need call details, please contact me: al=
ex.bennee@linaro.org"/></div></td></tr><tr><td style=3D"font-size: 0; paddi=
ng: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div=
 style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: =
400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c40=
43; text-decoration: none;" class=3D"primary-text" role=3D"presentation"><s=
pan aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20250624T=
130000Z"></time><time itemprop=3D"endDate" datetime=3D"20250624T140000Z"></=
time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D=
"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-=
text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-w=
eight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">When=
</h2></td></tr></table><span> (United Kingdom Time)</span></div></td></tr><=
tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: bre=
ak-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-seri=
f;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px;=
 letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"pri=
mary-text" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" cell=
spacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td>=
<h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-de=
coration: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin:=
 0; padding: 0;">Location</h2></td></tr></table><span itemprop=3D"location"=
 itemscope itemtype=3D"http://schema.org/Place"><span itemprop=3D"name" cla=
ss=3D"primary-text notranslate" style=3D"font-family: Roboto, sans-serif;fo=
nt-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; let=
ter-spacing: 0.2px;color: #3c4043; text-decoration: none;">https://meet.jit=
.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.com/url?q=3Dhtt=
ps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D17512077600000=
00&amp;usg=3DAOvVaw384y9g6tDukEGYt2FiXYTO" class=3D"accent-text underline-o=
n-hover" style=3D"display: inline-block;;color: #1a73e8; text-decoration: n=
one;font-weight: 700;" target=3D"_blank" itemprop=3D"map">View map</a></spa=
n></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: le=
ft; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family=
: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px;=
 line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: =
none;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" cel=
lpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bot=
tom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;colo=
r: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: =
antialiased;margin: 0; padding: 0;">Guests</h2></td></tr></table><div style=
=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;"><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a></span=
><meta itemprop=3D"email" content=3D"alex.bennee@linaro.org"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a></span><meta itemprop=3D"email" content=3D"armbru@redhat.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:bcain@quicinc.com=
">bcain@quicinc.com</a></span><meta itemprop=3D"email" content=3D"bcain@qui=
cinc.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:berra=
nge@redhat.com">berrange@redhat.com</a></span><meta itemprop=3D"email" cont=
ent=3D"berrange@redhat.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a></span><meta itemprop=3D=
"email" content=3D"cjia@nvidia.com"/></span><span class=3D"secondary-text" =
style=3D"color: #70757a; text-decoration: none;"></span></div><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"e=
mail" content=3D"cw@f00f.org"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a></span><meta itempr=
op=3D"email" content=3D"eblake@redhat.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.=
com</a></span><meta itemprop=3D"email" content=3D"edgar.iglesias@gmail.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:eduardo@habkos=
t.net">eduardo@habkost.net</a></span><meta itemprop=3D"email" content=3D"ed=
uardo@habkost.net"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:felipe@nutanix.com">felipe@nutanix.com</a></span><meta itemprop=3D"emai=
l" content=3D"felipe@nutanix.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></span><meta itemp=
rop=3D"email" content=3D"iggy@theiggy.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a></span><meta =
itemprop=3D"email" content=3D"imp@bsdimp.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><me=
ta itemprop=3D"email" content=3D"jgg@nvidia.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.=
com</a></span><meta itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:jim.shu@sifive.co=
m">jim.shu@sifive.com</a></span><meta itemprop=3D"email" content=3D"jim.shu=
@sifive.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:m=
burton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span><meta itemprop=
=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Per=
son"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text=
 underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-d=
ecoration: none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></sp=
an><meta itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:paul.walmsley@sifive.com">paul.wa=
lmsley@sifive.com</a></span><meta itemprop=3D"email" content=3D"paul.walmsl=
ey@sifive.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
pbonzini@redhat.com">pbonzini@redhat.com</a></span><meta itemprop=3D"email"=
 content=3D"pbonzini@redhat.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a></s=
pan><meta itemprop=3D"email" content=3D"peter.maydell@linaro.org"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:richard.henderson@linaro=
.org">richard.henderson@linaro.org</a></span><meta itemprop=3D"email" conte=
nt=3D"richard.henderson@linaro.org"/></span><span class=3D"secondary-text" =
style=3D"color: #70757a; text-decoration: none;"></span></div><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:shentey@gmail.com">shentey@gmail.com</a></span><meta i=
temprop=3D"email" content=3D"shentey@gmail.com"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Per=
son"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text=
 underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-d=
ecoration: none;" href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>=
</span><meta itemprop=3D"email" content=3D"stefanha@gmail.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:wei.w.wang@intel.com">wei.=
w.wang@intel.com</a></span><meta itemprop=3D"email" content=3D"wei.w.wang@i=
ntel.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:zwu.k=
ernel@gmail.com">zwu.kernel@gmail.com</a></span><meta itemprop=3D"email" co=
ntent=3D"zwu.kernel@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a></span><meta itempr=
op=3D"email" content=3D"philmd@linaro.org"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:eblot@rivosinc.com">eblot@rivosinc.com</a></spa=
n><meta itemprop=3D"email" content=3D"eblot@rivosinc.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:max.chou@sifive.com">max.chou@si=
five.com</a></span><meta itemprop=3D"email" content=3D"max.chou@sifive.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:manos.pitsidia=
nakis@linaro.org">manos.pitsidianakis@linaro.org</a></span><meta itemprop=
=3D"email" content=3D"manos.pitsidianakis@linaro.org"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:thuth@redhat.com">thuth@redhat.com=
</a></span><meta itemprop=3D"email" content=3D"thuth@redhat.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:rbc@meta.com">rbc@meta.co=
m</a></span><meta itemprop=3D"email" content=3D"rbc@meta.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:alistair.francis@wdc.com">=
alistair.francis@wdc.com</a></span><meta itemprop=3D"email" content=3D"alis=
tair.francis@wdc.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:konrad.wilk@oracle.com">konrad.wilk@oracle.com</a></span><meta itemp=
rop=3D"email" content=3D"konrad.wilk@oracle.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><meta it=
emprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:clg@kaod.org">clg@kaod.org</a></span><meta itempro=
p=3D"email" content=3D"clg@kaod.org"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></span><meta itemprop=3D"=
email" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:chao.p.peng@linux.intel.com">chao.p.peng@linux.intel.com</a=
></span><meta itemprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:dhedde@kalrayinc.=
com">dhedde@kalrayinc.com</a></span><meta itemprop=3D"email" content=3D"dhe=
dde@kalrayinc.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:elena.ufimtseva@oracle.com">elena.ufimtseva@oracle.com</a></span><meta =
itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:eric.auger@redhat.com">eric.auge=
r@redhat.com</a></span><meta itemprop=3D"email" content=3D"eric.auger@redha=
t.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jan.kisz=
ka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" content=3D"=
jan.kiszka@web.de"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:joao.m.martins@oracle.com">joao.m.martins@oracle.com</a></span><meta it=
emprop=3D"email" content=3D"joao.m.martins@oracle.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:luc@lmichel.fr">luc@lmichel.fr</a>=
</span><meta itemprop=3D"email" content=3D"luc@lmichel.fr"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@l=
inux.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"mimu@linux.=
vnet.ibm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:s=
hameerali.kolothum.thodi@huawei.com">shameerali.kolothum.thodi@huawei.com</=
a></span><meta itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huaw=
ei.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@1=
39.com">z.huo@139.com</a></span><meta itemprop=3D"email" content=3D"z.huo@1=
39.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:zhiwei_=
liu@linux.alibaba.com">zhiwei_liu@linux.alibaba.com</a></span><meta itempro=
p=3D"email" content=3D"zhiwei_liu@linux.alibaba.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@non=
gnu.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:nelson.ho@win=
driver.com">nelson.ho@windriver.com</a></span><meta itemprop=3D"email" cont=
ent=3D"nelson.ho@windriver.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:demiobenour@gmail.com">demiobenour@gmail.com</a></span><me=
ta itemprop=3D"email" content=3D"demiobenour@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a></sp=
an><meta itemprop=3D"email" content=3D"hi@alyssa.is"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div></div></div></td></tr></table></td></tr></tbody></table></div><!--[if m=
so | IE]></td><![endif]--><!--[if mso | IE]></tr></table><![endif]--></td><=
/tr></tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"=
 role=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><t=
body><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-brea=
k: break-word;;padding:4px 12px;" class=3D"" align=3D"left"><div class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;font-family: =
Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule=
: exactly; text-align: left;"><p>Invitation from <a href=3D"https://calenda=
r.google.com/calendar/" class=3D"accent-text underline-on-hover" style=3D"f=
ont-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line=
-height-rule: exactly;;color: #1a73e8; text-decoration: none;" target=3D"_b=
lank">Google Calendar</a></p><p>You are receiving this email because you ar=
e an attendee on the event.</p><p>Forwarding this invitation could allow an=
y recipient to send a response to the organizer, be added to the guest list=
, invite others regardless of their own invitation status, or modify your R=
SVP. <a class=3D"accent-text underline-on-hover" style=3D"font-family: Robo=
to, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: ex=
actly;;color: #1a73e8; text-decoration: none;" href=3D"https://support.goog=
le.com/calendar/answer/37135#forwarding">Learn more</a></p></div></td></tr>=
</tbody></table></td></tr></tbody></table></span></span></body></html>
--0000000000003d1ed10638524004
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
DTSTART;TZID=3DAmerica/New_York:20250624T090000
DTEND;TZID=3DAmerica/New_York:20250624T100000
DTSTAMP:20250624T143616Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20250624T130000@google.com
CREATED:20230221T153950Z
LAST-MODIFIED:20250624T143608Z
SEQUENCE:0
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

--0000000000003d1ed10638524004--

--0000000000003d1ed20638524006
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
VDtUWklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNTA2MjRUMDkwMDAwDQpEVEVORDtUWklEPUFtZXJp
Y2EvTmV3X1lvcms6MjAyNTA2MjRUMTAwMDAwDQpEVFNUQU1QOjIwMjUwNjI0VDE0MzYxNloNCk9S
R0FOSVpFUjtDTj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJr
dTVzaTAxYmxtbmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjFndnViOTQzNW83
aHJyZW0wYTByYWxubDVpX1IyMDI1MDYyNFQxMzAwMDBAZ29vZ2xlLmNvbQ0KQ1JFQVRFRDoyMDIz
MDIyMVQxNTM5NTBaDQpMQVNULU1PRElGSUVEOjIwMjUwNjI0VDE0MzYwOFoNClNFUVVFTkNFOjAN
ClNUQVRVUzpDQU5DRUxMRUQNClNVTU1BUlk6UUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNl
IGNhbGwNClRSQU5TUDpPUEFRVUUNCkFUVEFDSDtGSUxFTkFNRT1Ob3RlcyDigJMgUUVNVS9LVk0g
ZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGw7Rk1UVFlQRT1hcHBsaWNhDQogdGlvbi92bmQuZ29v
Z2xlLWFwcHMuZG9jdW1lbnQ6aHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xLUx0
cTExTEx6DQogeENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNKQkdRWnJlay9lZGl0DQpCRUdJTjpW
QUxBUk0NCkFDVElPTjpFTUFJTA0KREVTQ1JJUFRJT046VGhpcyBpcyBhbiBldmVudCByZW1pbmRl
cg0KU1VNTUFSWTpBbGFybSBub3RpZmljYXRpb24NCkFUVEVOREVFOm1haWx0bzpxZW11LWRldmVs
QG5vbmdudS5vcmcNClRSSUdHRVI6LVAyRA0KRU5EOlZBTEFSTQ0KRU5EOlZFVkVOVA0KRU5EOlZD
QUxFTkRBUg0K
--0000000000003d1ed20638524006--

