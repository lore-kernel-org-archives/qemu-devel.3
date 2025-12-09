Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE7DD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyFG-0004wU-QV; Tue, 09 Dec 2025 08:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSyFC-0004sx-SS
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:59:11 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSyF9-00049G-50
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:59:10 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so30320405e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 05:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765288745; x=1765893545; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2TmpRBCw5sRtSrgV2AHNmQaf2E7vY/X9ET87ar1UeEc=;
 b=G/vsxRhA3dAP2sWe7jr9zReucX/2I2S+cph4ZVG9DxS0sD0DJABfJp3pD7AxVM96cA
 r7WNoIzw0shvJAsn2wgwbSaILKojuOymvJDuhk4k4j/r/RS4BnV7Y/8OVDiwujHZnXxh
 Xdnf4YJ9dRCTkJtjIFbuj06w2vM0OlCJwBMhywp5Bp5b586yAPpVfb4MvD5mp/YSBj6k
 Qal+E7sgemERySeHQirL7bJcrv7XCCvgxo69I7CSrfWQjBsePwv/z/gfUFkWNRzkjqqs
 xqfc+jk6epgwFLpal0zJF4XpRuCo9fq7Crx+FLhUD3iXSpXf7Hq7YGlIOuRY4LKDLHWl
 MpXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765288745; x=1765893545; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2TmpRBCw5sRtSrgV2AHNmQaf2E7vY/X9ET87ar1UeEc=;
 b=K/qvMhZGLqc3I+VYp1Rx+PBOfPm/CnLGsKsfAlT+y6OoIUXZhWP+farjljKLfsO8mV
 na91I+h91n25n+okLz7bmCoBxTy8URVKrwkCgYT35dG7Yek2IQCDrxDBwVV7Q0J1WzTk
 rE1ux3KeGL87MgkDy3p6oUqQ5UMXeIwka+ndxmGnLzQe+kZfIqD1QkwJqQ3EBRcs5ZyT
 KEPuxipKpqAr1j1KtGzQVGjDvDz2i8txuN+zgIiDREIp9TrhX+pU8qyXi+9wEOhzV2GD
 Oy5gIOA9qYAtANdbkqeLSsSWpC5li4MKfwB7VeAx+rtGsJxBr09ADdWPKfa/m1ajt9hF
 q7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765288745; x=1765893545;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2TmpRBCw5sRtSrgV2AHNmQaf2E7vY/X9ET87ar1UeEc=;
 b=adtqGUTjF5xbkFXvRU8FMRi4e3WnCEpgf7Ts3kDnTXZ0PaXDpbJi7kiv8ANrU5CO9a
 hVyLhqnH60jiAWXMYbnDf1pUfKRrykbXwriqDbYZ2JH5fwxjegDaG6VZrBc3OVmhhvpg
 gcHAAZwwG5qBWTyMj9CgDDICXHC1P2pClUzL5ofTevF+E5MwgJoaDD6U712uPyaR6j1g
 Z1Chn+viayBPOznQgnFsm+TEG4zVCeHFVySwfE3oWv1CTgXMxP1OZv5irZ9Ku/c0Wuks
 PjA2BgY+HUV4vGTWLGFQYy+YvtNygIO1FLVeqxNOksQBvInVagi86xBZXf5HEDpzNati
 pGww==
X-Gm-Message-State: AOJu0YxT0FcjExS99vFBKZKDaKkLNQwzSKcEtAxqmKDiAUWbjFgmTP8W
 bpTR/oIcJ8QqHlIZf5RdFDySQvsxnKF95vKjuDKbFcCIxWq1m7LBRaKPImk60mx81923dQ9KXgn
 5D9suwaDSAC7Gdc6NW1tYa3y95AuNWpvnfx3acNMGLSgp5vpwDVb0Ng==
X-Google-Smtp-Source: AGHT+IEkQSMpifEe2uKPsVeru7MTLdRQ+cFClxq6/qemJqtYf3fMRN7/UpVzIrbr9N97uhwwoQoBGxGvRiCiduM6YaHs
MIME-Version: 1.0
X-Received: by 2002:a05:600c:1c1f:b0:477:8ba7:fe17 with SMTP id
 5b1f17b1804b1-47939df2650mr148739875e9.7.1765288745557; Tue, 09 Dec 2025
 05:59:05 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-c77df742-0c20-4837-8c32-2919227d117d@google.com>
Date: Tue, 09 Dec 2025 13:59:05 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 13:00 to 14:00 on Tuesday from Tue 11 Nov to Mon 5 Jan 2026 (GMT)
 (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="0000000000009af49106458550f0"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x349.google.com
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
Reply-To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000009af49106458550f0
Content-Type: multipart/alternative; boundary="0000000000009af49006458550ee"

--0000000000009af49006458550ee
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9t
IDEzOjAwIHRvIDE0OjAwIG9uIFR1ZXNkYXkgZnJvbSBUdWVzZGF5IDExIE5vdiB0byBNb25kYXkg
IA0KNSBKYW4gMjAyNg0KVW5pdGVkIEtpbmdkb20gVGltZQ0KDQpMb2NhdGlvbg0KaHR0cHM6Ly9t
ZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZwkNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vdXJsP3E9
aHR0cHMlM0ElMkYlMkZtZWV0LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5nJnNhPUQmc291cmNlPWNh
bGVuZGFyJnVzdD0xNzY1NzIwNzQwMDAwMDAwJnVzZz1BT3ZWYXcxSmpJZnhHZndtSGh4NVdzZzk5
aDZzDQoNCg0KDQpBdHRhY2htZW50cw0KTm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29u
ZmVyZW5jZSBjYWxsICANCmh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHEx
MUxMenhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1TSkJHUVpyZWsvZWRpdA0KDQpJZiB5b3UgbmVl
ZCBjYWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
DQoNCkd1ZXN0cw0KQWxleCBCZW5uw6llIC0gY3JlYXRvcg0KYXJtYnJ1QHJlZGhhdC5jb20NCmJj
YWluQHF1aWNpbmMuY29tDQpiZXJyYW5nZUByZWRoYXQuY29tDQpjamlhQG52aWRpYS5jb20NCmN3
QGYwMGYub3JnDQplYmxha2VAcmVkaGF0LmNvbQ0KZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tDQpl
ZHVhcmRvQGhhYmtvc3QubmV0DQpmZWxpcGVAbnV0YW5peC5jb20NCmlnZ3lAdGhlaWdneS5jb20N
CmltcEBic2RpbXAuY29tDQpqZ2dAbnZpZGlhLmNvbQ0Kamlkb25nLnhpYW9AZ21haWwuY29tDQpq
aW0uc2h1QHNpZml2ZS5jb20NCm1idXJ0b25AcXRpLnF1YWxjb21tLmNvbQ0KbWRlYW5AcmVkaGF0
LmNvbQ0KcGF1bC53YWxtc2xleUBzaWZpdmUuY29tDQpwYm9uemluaUByZWRoYXQuY29tDQpQZXRl
ciBNYXlkZWxsDQpSaWNoYXJkIEhlbmRlcnNvbg0Kc2hlbnRleUBnbWFpbC5jb20NCnN0ZWZhbmhh
QGdtYWlsLmNvbQ0Kd2VpLncud2FuZ0BpbnRlbC5jb20NCnp3dS5rZXJuZWxAZ21haWwuY29tDQpQ
aGlsIE1hdGhpZXUtRGF1ZMOpDQplYmxvdEByaXZvc2luYy5jb20NCm1heC5jaG91QHNpZml2ZS5j
b20NCk1hbm9zIFBpdHNpZGlhbmFraXMNCnRodXRoQHJlZGhhdC5jb20NCnJiY0BtZXRhLmNvbQ0K
ZGVtaW9iZW5vdXJAZ21haWwuY29tDQpoaUBhbHlzc2EuaXMNCmRoZWRkZUBrYWxyYXlpbmMuY29t
DQphZmFyaWFAcmVkaGF0LmNvbQ0KYWVzdGV2ZUByZWRoYXQuY29tDQptYXJjYW5kcmUubHVyZWF1
QGdtYWlsLmNvbQ0KQWxpc3RhaXIgRnJhbmNpcw0Ka29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KQWxl
c3NhbmRybyBEaSBGZWRlcmljbw0KQ8OpZHJpYyBMZSBHb2F0ZXINCkFudG9uIEpvaGFuc3Nvbg0K
Q2hhbyBQZW5nDQpFbGVuYSBVZmltdHNldmENCmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KamFuLmtp
c3prYUB3ZWIuZGUNCkpvYW8gTWFydGlucw0KTHVjIE1pY2hlbA0KU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaQ0Kei5odW9AMTM5LmNvbQ0KTElVIFpoaXdlaQ0KcWVtdS1kZXZlbEBub25nbnUub3Jn
DQpuZWxzb24uaG9Ad2luZHJpdmVyLmNvbQ0KDQoNCn5+Ly9+fg0KSW52aXRhdGlvbiBmcm9tIEdv
b2dsZSBDYWxlbmRhcjogaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyLw0KDQpZ
b3UgYXJlIHJlY2VpdmluZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFyZSBhbiBhdHRlbmRlZSBv
biB0aGUgZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNvdWxkIGFsbG93IGFu
eSByZWNpcGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdhbml6ZXIsIGJlIGFk
ZGVkIHRvIHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxlc3Mgb2YgIA0KdGhl
aXIgb3duIGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBSU1ZQLg0KDQpMZWFybiBt
b3JlIGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dlci8zNzEzNSNmb3J3
YXJkaW5nDQo=
--0000000000009af49006458550ee
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
></span><meta itemprop=3D"eventId/googleCalendar" content=3D"5o8knt1c26rbmq=
46204rq8mc53_R20251111T130000"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develope=
rs conference call</span><span aria-hidden=3D"true"><time itemprop=3D"start=
Date" datetime=3D"20251111T130000Z"></time><time itemprop=3D"endDate" datet=
ime=3D"20251111T140000Z"></time></span><table border=3D"0" cellpadding=3D"0=
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
pan aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20251111T=
130000Z"></time><time itemprop=3D"endDate" datetime=3D"20251111T140000Z"></=
time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D=
"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-=
text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-w=
eight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">When=
</h2></td></tr></table><span>Every 2 weeks from 13:00 to 14:00 on Tuesday f=
rom Tuesday 11 Nov to Monday 5 Jan 2026 (United Kingdom Time)</span></div><=
/td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-=
break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto,=
 sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-hei=
ght: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" cl=
ass=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px=
;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c40=
43; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialia=
sed;margin: 0; padding: 0;">Location</h2></td></tr></table><span itemprop=
=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span itemprop=
=3D"name" class=3D"primary-text notranslate" style=3D"font-family: Roboto, =
sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heig=
ht: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">htt=
ps://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.co=
m/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;source=
=3Dcalendar&amp;ust=3D1765720740000000&amp;usg=3DAOvVaw1JjIfxGfwmHhx5Wsg99h=
6s" class=3D"accent-text underline-on-hover" style=3D"display: inline-block=
;;color: #1a73e8; text-decoration: none;font-weight: 700;" target=3D"_blank=
" itemprop=3D"map">View map</a></span></div></td></tr><tr><td style=3D"font=
-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-bot=
tom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal=
; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2=
px;color: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"p=
resentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"prima=
ry-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;fon=
t-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">G=
uests</h2></td></tr></table><div style=3D"padding-bottom: 4px; text-align: =
left;;color: #3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:alex.bennee@linar=
o.org">Alex Benn=C3=A9e</a></span><meta itemprop=3D"email" content=3D"alex.=
bennee@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"> - creator</span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a></span><meta itempro=
p=3D"email" content=3D"armbru@redhat.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:bcain@quicinc.com">bcain@quicinc.com</a></span><=
meta itemprop=3D"email" content=3D"bcain@quicinc.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:berrange@redhat.com">berrange@redh=
at.com</a></span><meta itemprop=3D"email" content=3D"berrange@redhat.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.com"=
>cjia@nvidia.com</a></span><meta itemprop=3D"email" content=3D"cjia@nvidia.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.or=
g">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.co=
m">eblake@redhat.com</a></span><meta itemprop=3D"email" content=3D"eblake@r=
edhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:edga=
r.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"=
email" content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</a></=
span><meta itemprop=3D"email" content=3D"eduardo@habkost.net"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">felipe=
@nutanix.com</a></span><meta itemprop=3D"email" content=3D"felipe@nutanix.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@theigg=
y.com">iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"iggy@=
theiggy.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:i=
mp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=3D=
"imp@bsdimp.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:jgg@nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"email" content=
=3D"jgg@nvidia.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><meta itempro=
p=3D"email" content=3D"jidong.xiao@gmail.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:jim.shu@sifive.com">jim.shu@sifive.com</a></=
span><meta itemprop=3D"email" content=3D"jim.shu@sifive.com"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:mburton@qti.qualcomm.com">mbu=
rton@qti.qualcomm.com</a></span><meta itemprop=3D"email" content=3D"mburton=
@qti.qualcomm.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:mdean@redhat.com">mdean@redhat.com</a></span><meta itemprop=3D"email" c=
ontent=3D"mdean@redhat.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:paul.walmsley@sifive.com">paul.walmsley@sifive.com</a></span=
><meta itemprop=3D"email" content=3D"paul.walmsley@sifive.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:pbonzini@redhat.com">pbonz=
ini@redhat.com</a></span><meta itemprop=3D"email" content=3D"pbonzini@redha=
t.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:peter.ma=
ydell@linaro.org">Peter Maydell</a></span><meta itemprop=3D"email" content=
=3D"peter.maydell@linaro.org"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:richard.henderson@linaro.org">Richard Henderson</a></span><=
meta itemprop=3D"email" content=3D"richard.henderson@linaro.org"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:shentey@gmail.com">shente=
y@gmail.com</a></span><meta itemprop=3D"email" content=3D"shentey@gmail.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmai=
l.com">stefanha@gmail.com</a></span><meta itemprop=3D"email" content=3D"ste=
fanha@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span><meta itemprop=3D"em=
ail" content=3D"wei.w.wang@intel.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span=
><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:philmd@linaro.org">Phil Mathieu=
-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D"philmd@linaro.org=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblot@rivosin=
c.com">eblot@rivosinc.com</a></span><meta itemprop=3D"email" content=3D"ebl=
ot@rivosinc.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:max.chou@sifive.com">max.chou@sifive.com</a></span><meta itemprop=3D"emai=
l" content=3D"max.chou@sifive.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:manos.pitsidianakis@linaro.org">Manos Pitsidianakis</a>=
</span><meta itemprop=3D"email" content=3D"manos.pitsidianakis@linaro.org"/=
></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decora=
tion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemty=
pe=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslat=
e"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bl=
ock;;color: #3c4043; text-decoration: none;" href=3D"mailto:thuth@redhat.co=
m">thuth@redhat.com</a></span><meta itemprop=3D"email" content=3D"thuth@red=
hat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsco=
pe itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"n=
otranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: =
inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:rbc@me=
ta.com">rbc@meta.com</a></span><meta itemprop=3D"email" content=3D"rbc@meta=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:demiobeno=
ur@gmail.com">demiobenour@gmail.com</a></span><meta itemprop=3D"email" cont=
ent=3D"demiobenour@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a></span><meta itemprop=3D"emai=
l" content=3D"hi@alyssa.is"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:dhedde@kalrayinc.com">dhedde@kalrayinc.com</a></span><meta i=
temprop=3D"email" content=3D"dhedde@kalrayinc.com"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:afaria@redhat.com">afaria@redhat.com</a=
></span><meta itemprop=3D"email" content=3D"afaria@redhat.com"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:aesteve@redhat.com">aestev=
e@redhat.com</a></span><meta itemprop=3D"email" content=3D"aesteve@redhat.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:marcandre.l=
ureau@gmail.com">marcandre.lureau@gmail.com</a></span><meta itemprop=3D"ema=
il" content=3D"marcandre.lureau@gmail.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:alistair.francis@wdc.com">Alistair Francis</a><=
/span><meta itemprop=3D"email" content=3D"alistair.francis@wdc.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com=
">konrad.wilk@oracle.com</a></span><meta itemprop=3D"email" content=3D"konr=
ad.wilk@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:ale@rev.ng">Alessandro Di Federico</a></span><meta itemprop=3D"email=
" content=3D"ale@rev.ng"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:clg@kaod.org">C=C3=A9dric Le Goater</a></span><meta itemprop=3D"=
email" content=3D"clg@kaod.org"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:anjo@rev.ng">Anton Johansson</a></span><meta itemprop=3D"e=
mail" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</a></span><meta item=
prop=3D"email" content=3D"chao.p.peng@linux.intel.com"/></span><span class=
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
or: #3c4043; text-decoration: none;" href=3D"mailto:shameerali.kolothum.tho=
di@huawei.com">Shameerali Kolothum Thodi</a></span><meta itemprop=3D"email"=
 content=3D"shameerali.kolothum.thodi@huawei.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><=
meta itemprop=3D"email" content=3D"z.huo@139.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhiwei=
</a></span><meta itemprop=3D"email" content=3D"zhiwei_liu@linux.alibaba.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel@no=
ngnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" content=
=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:nelson.ho@windriver.com">nelson.ho@windriver.com</a></span><m=
eta itemprop=3D"email" content=3D"nelson.ho@windriver.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div></div></div></td></tr></table></td></tr></tbody></table></div><!-=
-[if mso | IE]></td><![endif]--><!--[if mso | IE]></tr></table><![endif]-->=
</td></tr></tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=
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
e you are an attendee on the event.</p><p>Forwarding this invitation could =
allow any recipient to send a response to the organizer, be added to the gu=
est list, invite others regardless of their own invitation status, or modif=
y your RSVP. <a class=3D"accent-text underline-on-hover" style=3D"font-fami=
ly: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-=
rule: exactly;;color: #1a73e8; text-decoration: none;" href=3D"https://supp=
ort.google.com/calendar/answer/37135#forwarding">Learn more</a></p></div></=
td></tr></tbody></table></td></tr></tbody></table></span></span></body></ht=
ml>
--0000000000009af49006458550ee
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VEVENT
DTSTART:20251111T130000Z
DTEND:20251111T140000Z
RRULE:FREQ=3DWEEKLY;WKST=3DMO;UNTIL=3D20260105T235959Z;INTERVAL=3D2;BYDAY=
=3DTU
DTSTAMP:20251209T135905Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:5o8knt1c26rbmq46204rq8mc53_R20251111T130000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Darmbru@redhat.com;X-NUM-GUESTS=3D0:mailto:armbru@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbcain@quicinc.com;X-NUM-GUESTS=3D0:mailto:bcain@quicinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dberrange@redhat.com;X-NUM-GUESTS=3D0:mailto:berrange@redhat.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDELETED;RSVP=
=3DTRUE;
 CN=3Dmdean@redhat.com;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;RSV=
P=3DTRUE
 ;CN=3Dpaul.walmsley@sifive.com;X-NUM-GUESTS=3D0;X-RESPONSE-COMMENT=3D"Decl=
ined be
 cause it&#39\;s outside of working hours":mailto:paul.walmsley@sifive.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Deblot@rivosinc.com;X-NUM-GUESTS=3D0:mailto:eblot@rivosinc.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;RSV=
P=3DTRUE
 ;CN=3Dafaria@redhat.com;X-NUM-GUESTS=3D0:mailto:afaria@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Daesteve@redhat.com;X-NUM-GUESTS=3D0:mailto:aesteve@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dmarcandre.lureau@gmail.com;X-NUM-GUESTS=3D0:mailto:marcandre.lureau=
@gmai
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;RSV=
P=3DTRUE
 ;CN=3Dqemu-devel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dnelson.ho@windriver.com;X-NUM-GUESTS=3D0:mailto:nelson.ho@windri=
ver.c
 om
X-MICROSOFT-CDO-OWNERAPPTID:-956004320
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20251209T135854Z
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

--0000000000009af49006458550ee--

--0000000000009af49106458550f0
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjUxMTExVDEzMDAwMFoNCkRURU5EOjIwMjUxMTEx
VDE0MDAwMFoNClJSVUxFOkZSRVE9V0VFS0xZO1dLU1Q9TU87VU5USUw9MjAyNjAxMDVUMjM1OTU5
WjtJTlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjUxMjA5VDEzNTkwNVoNCk9SR0FOSVpF
UjtDTj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJrdTVzaTAx
YmxtbmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjVvOGtudDFjMjZyYm1xNDYy
MDRycThtYzUzX1IyMDI1MTExMVQxMzAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxleC5iZW5uZWVAbGluYXJvLm9yZw0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hcm1icnVAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86YXJtYnJ1QHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
YmNhaW5AcXVpY2luYy5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJjYWluQHF1aWNpbmMuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049YmVycmFuZ2VAcmVkaGF0LmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86YmVycmFuZ2VAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1jamlhQG52aWRpYS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNqaWFAbnZpZGlhLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jd0BmMDBmLm9yZztYLU5VTS1HVUVTVFM9
MDptYWlsdG86Y3dAZjAwZi5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZWJsYWtl
QHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVibGFrZUByZWRoYXQuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86ZWRnYXIuaWdsZXNpYXNAZ21haWwNCiAuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPWVkdWFyZG9AaGFia29zdC5uZXQ7WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OmVkdWFyZG9AaGFia29zdC5uZXQNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZmVsaXBl
QG51dGFuaXguY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpmZWxpcGVAbnV0YW5peC5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aWdneUB0aGVpZ2d5LmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86aWdneUB0aGVpZ2d5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1p
bXBAYnNkaW1wLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86aW1wQGJzZGltcC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amdnQG52aWRpYS5jb207WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmpnZ0BudmlkaWEuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWppZG9uZy54
aWFvQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amlkb25nLnhpYW9AZ21haWwuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWppbS5zaHVAc2lmaXZlLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86amltLnNodUBzaWZpdmUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPW1idXJ0b25AcXRpLnF1YWxjb21tLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWJ1
cnRvbkBxdGkucXVhbGNvbW0NCiAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUxFVEVEO1JTVlA9VFJVRTsNCiBDTj1tZGVhbkBy
ZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptZGVhbkByZWRoYXQuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUNMSU5F
RDtSU1ZQPVRSVUUNCiA7Q049cGF1bC53YWxtc2xleUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0w
O1gtUkVTUE9OU0UtQ09NTUVOVD0iRGVjbGluZWQgYmUNCiBjYXVzZSBpdCYjMzlcO3Mgb3V0c2lk
ZSBvZiB3b3JraW5nIGhvdXJzIjptYWlsdG86cGF1bC53YWxtc2xleUBzaWZpdmUuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXBib256aW5pQHJlZGhhdC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049UGV0ZXIgTWF5ZGVsbDtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPVJpY2hhcmQgSGVuZGVyc29uO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3INCiBnDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXNoZW50ZXlAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpzaGVudGV5QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1z
dGVmYW5oYUBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnN0ZWZhbmhhQGdtYWlsLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj13ZWkudy53YW5nQGludGVsLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86d2VpLncud2FuZ0BpbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049end1Lmtlcm5lbEBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnp3
dS5rZXJuZWxAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpwaGlsbWRAbGluYXJvLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO1JTVlA9VFJVDQogRTtDTj1l
YmxvdEByaXZvc2luYy5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVibG90QHJpdm9zaW5jLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYXguY2hvdUBzaWZpdmUuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzptYXguY2hvdUBzaWZpdmUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPU1hbm9zIFBpdHNpZGlhbmFraXM7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1hbm9z
LnBpdHNpZGlhbmFraXNAbGluYXINCiBvLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj10aHV0aEByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp0aHV0aEByZWRoYXQuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXJiY0BtZXRhLmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86cmJjQG1ldGEuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWRlbWlv
YmVub3VyQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZGVtaW9iZW5vdXJAZ21haWwu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWhpQGFseXNzYS5pcztYLU5VTS1HVUVT
VFM9MDptYWlsdG86aGlAYWx5c3NhLmlzDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWRo
ZWRkZUBrYWxyYXlpbmMuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpkaGVkZGVAa2FscmF5aW5j
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9REVDTElORUQ7UlNWUD1UUlVFDQogO0NOPWFmYXJpYUByZWRoYXQuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzphZmFyaWFAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO1JTVlA9VFJVDQogRTtD
Tj1hZXN0ZXZlQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFlc3RldmVAcmVkaGF0
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9VEVOVEFUSVZFO1JTVlA9VFJVDQogRTtDTj1tYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFyY2FuZHJlLmx1cmVhdUBnbWFpDQogbC5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049QWxpc3RhaXIgRnJhbmNpcztYLU5VTS1HVUVTVFM9
MDptYWlsdG86YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPWtvbnJhZC53aWxrQG9yYWNsZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmtvbnJh
ZC53aWxrQG9yYWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049QWxlc3NhbmRy
byBEaSBGZWRlcmljbztYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxlQHJldi5uZw0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2xnQGthb2Qub3JnDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUFudG9uIEpvaGFuc3NvbjtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86YW5qb0ByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Q2hhbyBQZW5n
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjaGFvLnAucGVuZ0BsaW51eC5pbnRlbC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049RWxlbmEgVWZpbXRzZXZhO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1lcmljLmF1Z2VyQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVyaWMuYXVn
ZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qYW4ua2lzemthQHdl
Yi5kZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amFuLmtpc3prYUB3ZWIuZGUNCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqb2Fv
Lm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUx1YyBN
aWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmx1Y0BsbWljaGVsLmZyDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPVNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGk7WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOnNoYW1lZXJhbGkua29sb3RodW0NCiAudGhvZGlAaHVhd2VpLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj16Lmh1b0AxMzkuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6
Lmh1b0AxMzkuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUxJVSBaaGl3ZWk7WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOnpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPURFQ0xJTkVE
O1JTVlA9VFJVRQ0KIDtDTj1xZW11LWRldmVsQG5vbmdudS5vcmc7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1u
ZWxzb24uaG9Ad2luZHJpdmVyLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bmVsc29uLmhvQHdp
bmRyaXZlci5jDQogb20NClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJRDotOTU2MDA0MzIwDQpD
UkVBVEVEOjIwMjMwMjIxVDE1Mzk1MFoNCkRFU0NSSVBUSU9OOklmIHlvdSBuZWVkIGNhbGwgZGV0
YWlsc1wsIHBsZWFzZSBjb250YWN0IG1lOiA8YSBocmVmPSJtYWlsdG86cQ0KIHVpbnRlbGFAcmVk
aGF0LmNvbSI+YWxleC5iZW5uZWVAbGluYXJvLm9yZzwvYT4NCkxBU1QtTU9ESUZJRUQ6MjAyNTEy
MDlUMTM1ODU0Wg0KTE9DQVRJT046aHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZw0K
U0VRVUVOQ0U6MQ0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpRRU1VL0tWTSBkZXZlbG9wZXJz
IGNvbmZlcmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFVRQ0KQVRUQUNIO0ZJTEVOQU1FPU5vdGVzIOKA
kyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbDtGTVRUWVBFPWFwcGxpY2ENCiB0
aW9uL3ZuZC5nb29nbGUtYXBwcy5kb2N1bWVudDpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1
bWVudC9kLzEtTHRxMTFMTHoNCiB4Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2Vk
aXQNCkJFR0lOOlZBTEFSTQ0KQUNUSU9OOkVNQUlMDQpERVNDUklQVElPTjpUaGlzIGlzIGFuIGV2
ZW50IHJlbWluZGVyDQpTVU1NQVJZOkFsYXJtIG5vdGlmaWNhdGlvbg0KQVRURU5ERUU6bWFpbHRv
OnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KVFJJR0dFUjotUDJEDQpFTkQ6VkFMQVJNDQpFTkQ6VkVW
RU5UDQpFTkQ6VkNBTEVOREFSDQo=
--0000000000009af49106458550f0--

