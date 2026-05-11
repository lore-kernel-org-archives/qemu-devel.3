Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A47BCD37B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 11:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMOjh-0008Cf-Ci; Mon, 11 May 2026 07:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMOjf-0008Bz-35
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:23:43 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMOjc-0001pl-Cf
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:23:42 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-48d1bc85bb3so21512775e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778498619; x=1779103419; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6shyHaytBIv57TmLZiSIAhgBiQHsXpqm32vrUU38/A=;
 b=HjwpFJZgBr+Zt5+z4FDQ3HhNZFlOo/hzT3U11LSG0ixB3rfVVB2fQ23FlWboiWBiiR
 pyxUfvBTgEGoBmRsI/7I0ncDFRKSaOEUyG/NflAqF9t04E0bRjJ3ohK1f7G8NtM8IK93
 ZLFX4NwIr9W4n5hfdPgZoHrvO8K7n6G1LmgvwPpgPUdWvmI/tUX9At4WH6B+1+utzMi/
 Eo+W/neOeiKVZLgmUPnvgobpvTq0rZoXfkkx0yxV9gKzRZfcW6tfT0dCCHojAmK79oFE
 k6FiuOVXwPgknlcY6Zm/WDEfuOdVEmEf2vJ7mfvPRwMGg+JDo1H0z6Lf9YoGPJ5rH8aY
 rchg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778498619; x=1779103419; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6shyHaytBIv57TmLZiSIAhgBiQHsXpqm32vrUU38/A=;
 b=FEdcCsVljTS0jRALkuHyknueJDjGMWvdmR0pyi1v85O3/dvLU16pMPUX/icleGsD3h
 P3zTG+XdozVSHsUcUSgj9qFsFSviHH97d4sNFYm4hIJ4cOOJ5hgPV8xiZmhqx+rN3x9V
 bBJtctsN+uJI18ZBuFy7JSPjtHyvQFY6uOl5fcwJhZF3kX91giUYoIUBLiZSZZBHq3Sq
 cqpnMMp7plWu72VCRnud45MRoBVoR74Dk712RCjxBwJRo3pJkL7aYSzU2OjVBrfIewQO
 j0XaAbHtzKFPbE6FF0+Z6uvTHuiuiN8JhS2GjMJx2w0HkmiWaGN1PB8+VNxsonSJp703
 hmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778498619; x=1779103419;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z6shyHaytBIv57TmLZiSIAhgBiQHsXpqm32vrUU38/A=;
 b=VCMUDsXYXSEqhXWJCHgYSyhlH+Hn1MUr+YP95bBEWs1Qc/q7mO/nlCsYXGNRdYkRk9
 +AUB9t32XWTcJf4gkV7lSqjEtTT85JJi1lzekvlUZKgyLbcK5PQZT79kQY+Xqxos7EKl
 dZ9VQzmg0rQzuG2wpfYmSeAkkmVennbyLJoEAM6qKQmbpYglsUoGj6QtAGylrfaGugT8
 U47SV65XM5PRd1P3fT/U/MXEzEJ5FJEV4HGPQ41mxzZ7ipuiyNwd6qduRdxS/c0UP4xD
 BgLzS9eip9rHoJNeIBtveswiocd7KcMGnIsg/38VCQx4R2JjKGUrKaoIgMTMbPk3hkEX
 CUGw==
X-Gm-Message-State: AOJu0YxJj1apcTpOuxyNOijbRAPosi0wi6VB1h+mREdobY6F6AtiqmuV
 N120TCakHZm+AdHZz1omm21f1tgWWdMqN/luYympXt8YrGqNI1m00zSEjs2NRLOPgMtPXrS76gt
 hGKMzsCnTmcdkQ1U1WSGINCQYc8NfOGHGOTvzKLh63+T65HOvlnRktA==
MIME-Version: 1.0
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48e5dffabcamr286439405e9.9.1778498618732; Mon, 11 May 2026
 04:23:38 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-63932830-1515-4a81-9191-ba13bd742171@google.com>
Date: Mon, 11 May 2026 11:23:38 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 15:00 to 16:00 on Tuesday (BST) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="00000000000067424f065188fad7"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x34a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

--00000000000067424f065188fad7
Content-Type: multipart/alternative; boundary="00000000000067424d065188fad5"

--00000000000067424d065188fad5
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9t
IDE1OjAwIHRvIDE2OjAwIG9uIFR1ZXNkYXkNClVuaXRlZCBLaW5nZG9tIFRpbWUNCg0KTG9jYXRp
b24NCmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29n
bGUuY29tL3VybD9xPWh0dHBzJTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZz
YT1EJnNvdXJjZT1jYWxlbmRhciZ1c3Q9MTc3ODkzMDU4MDAwMDAwMCZ1c2c9QU92VmF3MXpCRWlM
ZFlESHhVeUhBWEJURFBsZQ0KDQoNCg0KQXR0YWNobWVudHMNCk5vdGVzIOKAkyBRRU1VL0tWTSBk
ZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbCAgDQpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1
bWVudC9kLzEtTHRxMTFMTHp4Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQN
Cg0KSWYgeW91IG5lZWQgY2FsbCBkZXRhaWxzLCBwbGVhc2UgY29udGFjdCBtZTogYWxleC5iZW5u
ZWVAbGluYXJvLm9yZw0KDQpHdWVzdHMNCkFsZXggQmVubsOpZSAtIGNyZWF0b3INCmFybWJydUBy
ZWRoYXQuY29tDQpiY2FpbkBxdWljaW5jLmNvbQ0KYmVycmFuZ2VAcmVkaGF0LmNvbQ0KY2ppYUBu
dmlkaWEuY29tDQpjd0BmMDBmLm9yZw0KZWJsYWtlQHJlZGhhdC5jb20NCmVkZ2FyLmlnbGVzaWFz
QGdtYWlsLmNvbQ0KZWR1YXJkb0BoYWJrb3N0Lm5ldA0KZmVsaXBlQG51dGFuaXguY29tDQppZ2d5
QHRoZWlnZ3kuY29tDQppbXBAYnNkaW1wLmNvbQ0KamdnQG52aWRpYS5jb20NCmppZG9uZy54aWFv
QGdtYWlsLmNvbQ0KamltLnNodUBzaWZpdmUuY29tDQptYnVydG9uQHF0aS5xdWFsY29tbS5jb20N
CnBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbQ0KcGJvbnppbmlAcmVkaGF0LmNvbQ0KUGV0ZXIgTWF5
ZGVsbA0KUmljaGFyZCBIZW5kZXJzb24NCnNoZW50ZXlAZ21haWwuY29tDQpzdGVmYW5oYUBnbWFp
bC5jb20NCndlaS53LndhbmdAaW50ZWwuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KUGhpbCBN
YXRoaWV1LURhdWTDqQ0KZWJsb3RAcml2b3NpbmMuY29tDQptYXguY2hvdUBzaWZpdmUuY29tDQpN
YW5vcyBQaXRzaWRpYW5ha2lzDQp0aHV0aEByZWRoYXQuY29tDQpyYmNAbWV0YS5jb20NCmRlbWlv
YmVub3VyQGdtYWlsLmNvbQ0KaGlAYWx5c3NhLmlzDQpkaGVkZGVAa2FscmF5aW5jLmNvbQ0KYWZh
cmlhQHJlZGhhdC5jb20NCmFlc3RldmVAcmVkaGF0LmNvbQ0KbWFyY2FuZHJlLmx1cmVhdUBnbWFp
bC5jb20NCm1hdHRoaWV1QG1pbmlvLmlvDQpqYWNvYi5vdXJzbGFuZEBnbWFpbC5jb20NCkFsaXN0
YWlyIEZyYW5jaXMNCmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCkFsZXNzYW5kcm8gRGkgRmVkZXJp
Y28NCkPDqWRyaWMgTGUgR29hdGVyDQpBbnRvbiBKb2hhbnNzb24NCkNoYW8gUGVuZw0KRWxlbmEg
VWZpbXRzZXZhDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmphbi5raXN6a2FAd2ViLmRlDQpKb2Fv
IE1hcnRpbnMNCkx1YyBNaWNoZWwNClNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCnouaHVvQDEz
OS5jb20NCkxJVSBaaGl3ZWkNCnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KbmVsc29uLmhvQHdpbmRy
aXZlci5jb20NCg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJvbSBHb29nbGUgQ2FsZW5kYXI6IGh0
dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8NCg0KWW91IGFyZSByZWNlaXZpbmcg
dGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5kZWUgb24gdGhlIGV2ZW50Lg0KDQpG
b3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNl
bmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5pemVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3Qg
bGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNzIG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9u
IHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4NCg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBv
cnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--00000000000067424d065188fad5
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
entScheduled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://sc=
hema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar"/=
></span><meta itemprop=3D"eventId/googleCalendar" content=3D"3tmn51v3ap1pkb=
eqj4divuh46c_R20260512T140000"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develope=
rs conference call</span><span aria-hidden=3D"true"><time itemprop=3D"start=
Date" datetime=3D"20260512T140000Z"></time><time itemprop=3D"endDate" datet=
ime=3D"20260512T150000Z"></time></span><table border=3D"0" cellpadding=3D"0=
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
pan aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20260512T=
140000Z"></time><time itemprop=3D"endDate" datetime=3D"20260512T150000Z"></=
time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D=
"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-=
text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-w=
eight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">When=
</h2></td></tr></table><span>Every 2 weeks from 15:00 to 16:00 on Tuesday (=
United Kingdom Time)</span></div></td></tr><tr><td style=3D"font-size: 0; p=
adding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;">=
<div style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weig=
ht: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #=
3c4043; text-decoration: none;" class=3D"primary-text" role=3D"presentation=
"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentat=
ion" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" styl=
e=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700=
;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Location</h2><=
/td></tr></table><span itemprop=3D"location" itemscope itemtype=3D"http://s=
chema.org/Place"><span itemprop=3D"name" class=3D"primary-text notranslate"=
 style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: =
400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c40=
43; text-decoration: none;">https://meet.jit.si/kvmcallmeeting</span><br/><=
a href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcal=
lmeeting&amp;sa=3DD&amp;source=3Dcalendar&amp;ust=3D1778930580000000&amp;us=
g=3DAOvVaw1zBEiLdYDHxUyHAXBTDPle" class=3D"accent-text underline-on-hover" =
style=3D"display: inline-block;;color: #1a73e8; text-decoration: none;font-=
weight: 700;" target=3D"_blank" itemprop=3D"map">View map</a></span></div><=
/td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-=
break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto,=
 sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-hei=
ght: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" cl=
ass=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpadding=
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
tion: none;" href=3D"mailto:paul.walmsley@sifive.com">paul.walmsley@sifive.=
com</a></span><meta itemprop=3D"email" content=3D"paul.walmsley@sifive.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:pbonzini@redha=
t.com">pbonzini@redhat.com</a></span><meta itemprop=3D"email" content=3D"pb=
onzini@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:peter.maydell@linaro.org">Peter Maydell</a></span><meta itemprop=3D"ema=
il" content=3D"peter.maydell@linaro.org"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:richard.henderson@linaro.org">Richard Henderson</=
a></span><meta itemprop=3D"email" content=3D"richard.henderson@linaro.org"/=
></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decora=
tion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemty=
pe=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslat=
e"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bl=
ock;;color: #3c4043; text-decoration: none;" href=3D"mailto:shentey@gmail.c=
om">shentey@gmail.com</a></span><meta itemprop=3D"email" content=3D"shentey=
@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:s=
tefanha@gmail.com">stefanha@gmail.com</a></span><meta itemprop=3D"email" co=
ntent=3D"stefanha@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span><meta =
itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail=
.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:philmd@linaro.org=
">Phil Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D"phi=
lmd@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:eblot@rivosinc.com">eblot@rivosinc.com</a></span><meta itemprop=3D"email" =
content=3D"eblot@rivosinc.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:max.chou@sifive.com">max.chou@sifive.com</a></span><meta it=
emprop=3D"email" content=3D"max.chou@sifive.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:manos.pitsidianakis@linaro.org">Manos Pit=
sidianakis</a></span><meta itemprop=3D"email" content=3D"manos.pitsidianaki=
s@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:t=
huth@redhat.com">thuth@redhat.com</a></span><meta itemprop=3D"email" conten=
t=3D"thuth@redhat.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:rbc@meta.com">rbc@meta.com</a></span><meta itemprop=3D"email" conte=
nt=3D"rbc@meta.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:demiobenour@gmail.com">demiobenour@gmail.com</a></span><meta itempro=
p=3D"email" content=3D"demiobenour@gmail.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a></span><meta i=
temprop=3D"email" content=3D"hi@alyssa.is"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:dhedde@kalrayinc.com">dhedde@kalrayinc.com</a><=
/span><meta itemprop=3D"email" content=3D"dhedde@kalrayinc.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:afaria@redhat.com">afaria@=
redhat.com</a></span><meta itemprop=3D"email" content=3D"afaria@redhat.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:aesteve@redhat=
.com">aesteve@redhat.com</a></span><meta itemprop=3D"email" content=3D"aest=
eve@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</a></span><meta ite=
mprop=3D"email" content=3D"marcandre.lureau@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:matthieu@minio.io">matthieu@minio.=
io</a></span><meta itemprop=3D"email" content=3D"matthieu@minio.io"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:jacob.oursland@gmail.c=
om">jacob.oursland@gmail.com</a></span><meta itemprop=3D"email" content=3D"=
jacob.oursland@gmail.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:alistair.francis@wdc.com">Alistair Francis</a></span><meta itemp=
rop=3D"email" content=3D"alistair.francis@wdc.com"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@ora=
cle.com</a></span><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.co=
m"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:ale@rev.ng">=
Alessandro Di Federico</a></span><meta itemprop=3D"email" content=3D"ale@re=
v.ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:clg@kaod.=
org">C=C3=A9dric Le Goater</a></span><meta itemprop=3D"email" content=3D"cl=
g@kaod.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:a=
njo@rev.ng">Anton Johansson</a></span><meta itemprop=3D"email" content=3D"a=
njo@rev.ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:c=
hao.p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"email" co=
ntent=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></spa=
n><meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@redhat.com">e=
ric.auger@redhat.com</a></span><meta itemprop=3D"email" content=3D"eric.aug=
er@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" con=
tent=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></span><meta itemp=
rop=3D"email" content=3D"joao.m.martins@oracle.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:luc@lmichel.fr">Luc Michel</a></span><=
meta itemprop=3D"email" content=3D"luc@lmichel.fr"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei.com">S=
hameerali Kolothum Thodi</a></span><meta itemprop=3D"email" content=3D"sham=
eerali.kolothum.thodi@huawei.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=3D=
"email" content=3D"z.huo@139.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhiwei</a></span><meta=
 itemprop=3D"email" content=3D"zhiwei_liu@linux.alibaba.com"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-d=
evel@nongnu.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel@no=
ngnu.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:nelso=
n.ho@windriver.com">nelson.ho@windriver.com</a></span><meta itemprop=3D"ema=
il" content=3D"nelson.ho@windriver.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div></div></d=
iv></td></tr></table></td></tr></tbody></table></div><!--[if mso | IE]></td=
><![endif]--><!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody><=
/table><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation" align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td =
style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word=
;;padding:4px 12px;" class=3D"" align=3D"left"><div class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;font-family: Roboto, sans-=
serif;font-size: 12px; line-height: 16px; mso-line-height-rule: exactly; te=
xt-align: left;"><p>Invitation from <a href=3D"https://calendar.google.com/=
calendar/" class=3D"accent-text underline-on-hover" style=3D"font-family: R=
oboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule:=
 exactly;;color: #1a73e8; text-decoration: none;" target=3D"_blank">Google =
Calendar</a></p><p>You are receiving this email because you are an attendee=
 on the event.</p><p>Forwarding this invitation could allow any recipient t=
o send a response to the organizer, be added to the guest list, invite othe=
rs regardless of their own invitation status, or modify your RSVP. <a class=
=3D"accent-text underline-on-hover" style=3D"font-family: Roboto, sans-seri=
f;font-size: 12px; line-height: 16px; mso-line-height-rule: exactly;;color:=
 #1a73e8; text-decoration: none;" href=3D"https://support.google.com/calend=
ar/answer/37135#forwarding">Learn more</a></p></div></td></tr></tbody></tab=
le></td></tr></tbody></table></span></span></body></html>
--00000000000067424d065188fad5
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VEVENT
DTSTART:20260512T140000Z
DTEND:20260512T150000Z
RRULE:FREQ=3DWEEKLY;WKST=3DMO;INTERVAL=3D2;BYDAY=3DTU
DTSTAMP:20260511T112338Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:3tmn51v3ap1pkbeqj4divuh46c_R20260512T140000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;X-NUM-GUESTS=3D0:mailto:alex.bennee@linaro.org
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDELETED;RSVP=
=3DTRUE;
 CN=3Ddemiobenour@gmail.com;X-NUM-GUESTS=3D0:mailto:demiobenour@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dhi@alyssa.is;X-NUM-GUESTS=3D0:mailto:hi@alyssa.is
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Ddhedde@kalrayinc.com;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;RSV=
P=3DTRUE
 ;CN=3Dafaria@redhat.com;X-NUM-GUESTS=3D0:mailto:afaria@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Daesteve@redhat.com;X-NUM-GUESTS=3D0:mailto:aesteve@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dmarcandre.lureau@gmail.com;X-NUM-GUESTS=3D0:mailto:marcandre.lureau@=
gmail
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dmatthieu@minio.io;X-NUM-GUESTS=3D0:mailto:matthieu@minio.io
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Djacob.oursland@gmail.com;X-NUM-GUESTS=3D0:mailto:jacob.oursland@gmai=
l.com
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
X-MICROSOFT-CDO-OWNERAPPTID:110589334
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20260511T112327Z
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

--00000000000067424d065188fad5--

--00000000000067424f065188fad7
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjYwNTEyVDE0MDAwMFoNCkRURU5EOjIwMjYwNTEy
VDE1MDAwMFoNClJSVUxFOkZSRVE9V0VFS0xZO1dLU1Q9TU87SU5URVJWQUw9MjtCWURBWT1UVQ0K
RFRTVEFNUDoyMDI2MDUxMVQxMTIzMzhaDQpPUkdBTklaRVI7Q049UUVNVSBQcm9qZWN0IENhbGVu
ZGFyOm1haWx0bzpjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGdyb3UNCiBwLmNhbGVuZGFy
Lmdvb2dsZS5jb20NClVJRDozdG1uNTF2M2FwMXBrYmVxajRkaXZ1aDQ2Y19SMjAyNjA1MTJUMTQw
MDAwQGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO1JTVlA9VFJVRQ0KIDtYLU5VTS1HVUVTVFM9MDptYWls
dG86YWxleC5iZW5uZWVAbGluYXJvLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1h
cm1icnVAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YXJtYnJ1QHJlZGhhdC5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YmNhaW5AcXVpY2luYy5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmJjYWluQHF1aWNpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPWJlcnJhbmdlQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJlcnJhbmdlQHJl
ZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Y2ppYUBudmlkaWEuY29tO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpjamlhQG52aWRpYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049Y3dAZjAwZi5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmN3QGYwMGYub3JnDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVibGFrZUByZWRoYXQuY29tO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzplYmxha2VAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1lZGdhci5pZ2xlc2lhc0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVkZ2FyLmln
bGVzaWFzQGdtYWlsDQogLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lZHVhcmRv
QGhhYmtvc3QubmV0O1gtTlVNLUdVRVNUUz0wOm1haWx0bzplZHVhcmRvQGhhYmtvc3QubmV0DQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWZlbGlwZUBudXRhbml4LmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86ZmVsaXBlQG51dGFuaXguY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPWlnZ3lAdGhlaWdneS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmlnZ3lAdGhlaWdneS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aW1wQGJzZGltcC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PWpnZ0BudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqZ2dAbnZpZGlhLmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qaWRvbmcueGlhb0BnbWFpbC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1qaW0uc2h1QHNpZml2ZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmppbS5zaHVA
c2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYnVydG9uQHF0aS5xdWFs
Y29tbS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1idXJ0b25AcXRpLnF1YWxjb21tDQogLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1wYXVsLndhbG1zbGV5QHNpZml2ZS5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBhdWwud2FsbXNsZXlAc2lmaXZlDQogLmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj1wYm9uemluaUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpwYm9uemluaUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PVBldGVyIE1heWRlbGw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1SaWNoYXJkIEhlbmRlcnNvbjtYLU5V
TS1HVUVTVFM9MDptYWlsdG86cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yDQogZw0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj1zaGVudGV5QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86c2hlbnRleUBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049c3Rl
ZmFuaGFAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzdGVmYW5oYUBnbWFpbC5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049d2VpLncud2FuZ0BpbnRlbC5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOndlaS53LndhbmdAaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPXp3dS5rZXJuZWxAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6d3Uu
a2VybmVsQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86cGhpbG1kQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
ZWJsb3RAcml2b3NpbmMuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxvdEByaXZvc2luYy5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWF4LmNob3VAc2lmaXZlLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86bWF4LmNob3VAc2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1NYW5vcyBQaXRzaWRpYW5ha2lzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYW5v
cy5waXRzaWRpYW5ha2lzQGxpbmFyDQogby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049dGh1dGhAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86dGh1dGhAcmVkaGF0LmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1yYmNAbWV0YS5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnJiY0BtZXRhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9REVMRVRFRDtSU1ZQPVRSVUU7DQogQ049ZGVtaW9iZW5v
dXJAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpkZW1pb2Jlbm91ckBnbWFpbC5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aGlAYWx5c3NhLmlzO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpoaUBhbHlzc2EuaXMNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZGhlZGRl
QGthbHJheWluYy5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmRoZWRkZUBrYWxyYXlpbmMuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ERUNMSU5FRDtSU1ZQPVRSVUUNCiA7Q049YWZhcmlhQHJlZGhhdC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmFmYXJpYUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PWFlc3RldmVAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YWVzdGV2ZUByZWRoYXQu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049bWFyY2FuZHJlLmx1cmVhdUBnbWFpbC5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVAZ21haWwNCiAuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NF
UFRFRDtSU1ZQPVRSVUUNCiA7Q049bWF0dGhpZXVAbWluaW8uaW87WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOm1hdHRoaWV1QG1pbmlvLmlvDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049amFjb2Iub3Vy
c2xhbmRAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqYWNvYi5vdXJzbGFuZEBnbWFp
bC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049QWxpc3RhaXIgRnJhbmNpcztYLU5V
TS1HVUVTVFM9MDptYWlsdG86YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPWtvbnJhZC53aWxrQG9yYWNsZS5jb207WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
QWxlc3NhbmRybyBEaSBGZWRlcmljbztYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxlQHJldi5uZw0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2xnQGthb2Qu
b3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUFudG9uIEpvaGFuc3NvbjtYLU5VTS1H
VUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
Q2hhbyBQZW5nO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjaGFvLnAucGVuZ0BsaW51eC5pbnRlbC5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049RWxlbmEgVWZpbXRzZXZhO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1lcmljLmF1Z2VyQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qYW4u
a2lzemthQHdlYi5kZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amFuLmtpc3prYUB3ZWIuZGUNCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPUx1YyBNaWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmx1Y0BsbWljaGVsLmZyDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPVNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGk7WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOnNoYW1lZXJhbGkua29sb3RodW0NCiAudGhvZGlAaHVhd2VpLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj16Lmh1b0AxMzkuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzp6Lmh1b0AxMzkuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUxJVSBa
aGl3ZWk7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cWVtdS1kZXZlbEBub25nbnUub3JnO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049bmVsc29uLmhvQHdpbmRyaXZlci5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
Om5lbHNvbi5ob0B3aW5kcml2ZXIuYw0KIG9tDQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6
MTEwNTg5MzM0DQpDUkVBVEVEOjIwMjMwMjIxVDE1Mzk1MFoNCkRFU0NSSVBUSU9OOklmIHlvdSBu
ZWVkIGNhbGwgZGV0YWlsc1wsIHBsZWFzZSBjb250YWN0IG1lOiA8YSBocmVmPSJtYWlsdG86cQ0K
IHVpbnRlbGFAcmVkaGF0LmNvbSI+YWxleC5iZW5uZWVAbGluYXJvLm9yZzwvYT4NCkxBU1QtTU9E
SUZJRUQ6MjAyNjA1MTFUMTEyMzI3Wg0KTE9DQVRJT046aHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1j
YWxsbWVldGluZw0KU0VRVUVOQ0U6Mg0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpRRU1VL0tW
TSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFVRQ0KQVRUQUNIO0ZJTEVO
QU1FPU5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbDtGTVRUWVBF
PWFwcGxpY2ENCiB0aW9uL3ZuZC5nb29nbGUtYXBwcy5kb2N1bWVudDpodHRwczovL2RvY3MuZ29v
Z2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHoNCiB4Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJt
U0pCR1FacmVrL2VkaXQNCkJFR0lOOlZBTEFSTQ0KQUNUSU9OOkVNQUlMDQpERVNDUklQVElPTjpU
aGlzIGlzIGFuIGV2ZW50IHJlbWluZGVyDQpTVU1NQVJZOkFsYXJtIG5vdGlmaWNhdGlvbg0KQVRU
RU5ERUU6bWFpbHRvOnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KVFJJR0dFUjotUDJEDQpFTkQ6VkFM
QVJNDQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=
--00000000000067424f065188fad7--

