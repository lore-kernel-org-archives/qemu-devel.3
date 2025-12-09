Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AD4D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 14:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyFW-00052J-4W; Tue, 09 Dec 2025 08:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSyFT-00051N-1Y
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:59:27 -0500
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSyFP-0004BM-VF
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:59:26 -0500
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-42b2ffbba05so2638007f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 05:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765288762; x=1765893562; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zUX1hTT6YeANogp4Ktoix+dqaaW5b4qThL9x+sm+lkk=;
 b=ol0Ug0yXgP6rknuKH1o1xxSI/Da//L2Hj1YTIR3kYt6uwotrq/Yx9+BnymKlMehdjX
 zuh5M0mxVeRuF6CcFsfdCExrGIFqJYD/tSJEiPIDQ/Y74fLNxgFLIT/eXI+tlRuiUkjg
 Ofm2pJkPQDdBocyhf3kFpw/YAVv8qOa9YE7OA0Lp5cVm3KEtt2+iHs7jTeLmA4v0IKiT
 0oIW1hgyS/3Tf4FCGmqnD0B7b9hvxKeKPD4B+Rt5P2zJTpPSzuTN/DRcVTAEqOjDwJdc
 qPxd7Fp59B2tBmt9XQBMzCw5LayfoJXPndaQPkkPwRGhqQAp1gRwX+QMulYwu0UpVyAo
 FMcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765288762; x=1765893562; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zUX1hTT6YeANogp4Ktoix+dqaaW5b4qThL9x+sm+lkk=;
 b=heu7FugQLqcIClxOFn9Ys+emAoEcd4RE0e98la8GkcCMzdmzBOL9uri/VFe1XbIRNn
 V7XUJdsFE0kkOVhmGJF1nQmQmlV0hX5+75yP8iXU8cvJXSFMzbAJje0Q8/dDZZK2qx8E
 q6TaX2sPNuMCbe+F18DSpSX0cKYhgCqqijtv7FFj7n4TXk2Hd5/QiL257Ma/j+ldouY9
 9WZZjMBUYAJyiCPMP+XvQSYAFj3Ooikp+WYTAaRmaxwbvFeb9MdM+GDTjjOD1cI3u7jJ
 gN7SVeOcDZWKuJ67oq2mVDS7aWamFCT6CdkNw6n87rQ6KJY6cMNxpt1MjWhEbewnWyga
 ffPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765288762; x=1765893562;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zUX1hTT6YeANogp4Ktoix+dqaaW5b4qThL9x+sm+lkk=;
 b=ga1RcI3+xdPccTSJEWmMvo/VZGfZlPHZTAy4ueZSAn1NxrpsgAn5l5lF9hypEIvyxh
 PJ4X88OiRtdnSJSeVdK6+c+BCfsxQNs+g70ay30437i1+sgLlyi6/yeg0Lg8mUwtslUH
 S6zde8w5HCHI3tuH8S/qKoJJRbavt8tDBkk/0Raz04tG6NBDj0JYNkwa5MR3NWjZHTxt
 qqeCj+DQmKjBbzViZ4LpPKgipL5d1cgVrt6wMgqXdAFLUJFQvs2w6naHO9mx6s0ZWohY
 sdNRjI7hpAuFElgxkV8Lau/qtuQaifwi9VFI/s/iRrGLVvSEuNgeFAcXw+PONT+bPB3x
 vJYQ==
X-Gm-Message-State: AOJu0Yx6govZnuYbCfE85ftmuCkLEtP5UD4bgLaIxgI//V7GsGeap6fR
 P/2D/CdTP1+fpTVhDsZUUmCdVA1Zj7vDoQYQe0SNYE0VlIjRgBgHdK3PC00u3DPZ2fqw+5ee5Cf
 QhljU7yfnyQYcfmeH0dfk7jOWEAn8zoGLM80s+uOaHI2oN6czzMGFVg==
X-Google-Smtp-Source: AGHT+IH+D7gPvHOXJ0qi2Cbi3sZMffx+bSwfNu919IG2r/ZATHmxw6L5dOK1LrAKMCUlTJ/D2b+5qhX+1wRL4z676opO
MIME-Version: 1.0
X-Received: by 2002:a05:600c:5489:b0:477:7925:f7fb with SMTP id
 5b1f17b1804b1-47939dfcc18mr126156745e9.10.1765288762143; Tue, 09 Dec 2025
 05:59:22 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-6f940d78-d90a-4c31-b808-ed0de0a3cf1c@google.com>
Date: Tue, 09 Dec 2025 13:59:22 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ Tue 12 May
 2026 14:00 - 15:00 (BST) (qemu-devel@nongnu.org)
From: alex.bennee@linaro.org
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="00000000000097fb5206458551a8"
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x449.google.com
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

--00000000000097fb5206458551a8
Content-Type: multipart/alternative; boundary="00000000000097fb5106458551a6"

--00000000000097fb5106458551a6
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KVHVlc2RheSAxMiBNYXkgMjAy
NiDii4UgMTQ6MDAg4oCTIDE1OjAwDQpVbml0ZWQgS2luZ2RvbSBUaW1lDQoNCkxvY2F0aW9uDQpo
dHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29vZ2xlLmNv
bS91cmw/cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcmc2E9RCZz
b3VyY2U9Y2FsZW5kYXImdXN0PTE3NjU3MjA3NDAwMDAwMDAmdXNnPUFPdlZhdzFKaklmeEdmd21I
aHg1V3NnOTloNnMNCg0KDQoNCkF0dGFjaG1lbnRzDQpOb3RlcyDigJMgUUVNVS9LVk0gZGV2ZWxv
cGVycyBjb25mZXJlbmNlIGNhbGwgIA0KaHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQv
ZC8xLUx0cTExTEx6eENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNKQkdRWnJlay9lZGl0DQoNCklm
IHlvdSBuZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3QgbWU6IGFsZXguYmVubmVlQGxp
bmFyby5vcmcNCg0KR3Vlc3RzDQphbGV4LmJlbm5lZUBsaW5hcm8ub3JnIC0gY3JlYXRvcg0KYXJt
YnJ1QHJlZGhhdC5jb20NCmJjYWluQHF1aWNpbmMuY29tDQpiZXJyYW5nZUByZWRoYXQuY29tDQpj
amlhQG52aWRpYS5jb20NCmN3QGYwMGYub3JnDQplYmxha2VAcmVkaGF0LmNvbQ0KZWRnYXIuaWds
ZXNpYXNAZ21haWwuY29tDQplZHVhcmRvQGhhYmtvc3QubmV0DQpmZWxpcGVAbnV0YW5peC5jb20N
CmlnZ3lAdGhlaWdneS5jb20NCmltcEBic2RpbXAuY29tDQpqZ2dAbnZpZGlhLmNvbQ0Kamlkb25n
LnhpYW9AZ21haWwuY29tDQpqaW0uc2h1QHNpZml2ZS5jb20NCm1idXJ0b25AcXRpLnF1YWxjb21t
LmNvbQ0KbWRlYW5AcmVkaGF0LmNvbQ0KcGF1bC53YWxtc2xleUBzaWZpdmUuY29tDQpwYm9uemlu
aUByZWRoYXQuY29tDQpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCnJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmcNCnNoZW50ZXlAZ21haWwuY29tDQpzdGVmYW5oYUBnbWFpbC5jb20NCndlaS53
LndhbmdAaW50ZWwuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KcGhpbG1kQGxpbmFyby5vcmcN
CmVibG90QHJpdm9zaW5jLmNvbQ0KbWF4LmNob3VAc2lmaXZlLmNvbQ0KbWFub3MucGl0c2lkaWFu
YWtpc0BsaW5hcm8ub3JnDQp0aHV0aEByZWRoYXQuY29tDQpyYmNAbWV0YS5jb20NCmRlbWlvYmVu
b3VyQGdtYWlsLmNvbQ0KaGlAYWx5c3NhLmlzDQpkaGVkZGVAa2FscmF5aW5jLmNvbQ0KYWZhcmlh
QHJlZGhhdC5jb20NCmFlc3RldmVAcmVkaGF0LmNvbQ0KbWFyY2FuZHJlLmx1cmVhdUBnbWFpbC5j
b20NCmFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbQ0Ka29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KYWxl
QHJldi5uZw0KY2xnQGthb2Qub3JnDQphbmpvQHJldi5uZw0KY2hhby5wLnBlbmdAbGludXguaW50
ZWwuY29tDQplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQ0KZXJpYy5hdWdlckByZWRoYXQuY29t
DQpqYW4ua2lzemthQHdlYi5kZQ0Kam9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbQ0KbHVjQGxtaWNo
ZWwuZnINCnNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbQ0Kei5odW9AMTM5LmNv
bQ0Kemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KcWVtdS1kZXZlbEBub25nbnUub3JnDQpu
ZWxzb24uaG9Ad2luZHJpdmVyLmNvbQ0KDQoNCn5+Ly9+fg0KSW52aXRhdGlvbiBmcm9tIEdvb2ds
ZSBDYWxlbmRhcjogaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyLw0KDQpZb3Ug
YXJlIHJlY2VpdmluZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFyZSBhbiBhdHRlbmRlZSBvbiB0
aGUgZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNvdWxkIGFsbG93IGFueSBy
ZWNpcGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdhbml6ZXIsIGJlIGFkZGVk
IHRvIHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxlc3Mgb2YgIA0KdGhlaXIg
b3duIGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBSU1ZQLg0KDQpMZWFybiBtb3Jl
IGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dlci8zNzEzNSNmb3J3YXJk
aW5nDQo=
--00000000000097fb5106458551a6
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
46204rq8mc53_20260512T130000Z"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develope=
rs conference call</span><span aria-hidden=3D"true"><time itemprop=3D"start=
Date" datetime=3D"20260512T130000Z"></time><time itemprop=3D"endDate" datet=
ime=3D"20260512T140000Z"></time></span><table border=3D"0" cellpadding=3D"0=
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
130000Z"></time><time itemprop=3D"endDate" datetime=3D"20260512T140000Z"></=
time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D=
"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-=
text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-w=
eight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">When=
</h2></td></tr></table><span>Tuesday 12 May 2026 =E2=8B=85 14:00 =E2=80=93 =
15:00 (United Kingdom Time)</span></div></td></tr><tr><td style=3D"font-siz=
e: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:=
24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; fo=
nt-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;c=
olor: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"prese=
ntation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pr=
esentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-tex=
t" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weig=
ht: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Locatio=
n</h2></td></tr></table><span itemprop=3D"location" itemscope itemtype=3D"h=
ttp://schema.org/Place"><span itemprop=3D"name" class=3D"primary-text notra=
nslate" style=3D"font-family: Roboto, sans-serif;font-style: normal; font-w=
eight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color=
: #3c4043; text-decoration: none;">https://meet.jit.si/kvmcallmeeting</span=
><br/><a href=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2=
Fkvmcallmeeting&amp;sa=3DD&amp;source=3Dcalendar&amp;ust=3D1765720740000000=
&amp;usg=3DAOvVaw1JjIfxGfwmHhx5Wsg99h6s" class=3D"accent-text underline-on-=
hover" style=3D"display: inline-block;;color: #1a73e8; text-decoration: non=
e;font-weight: 700;" target=3D"_blank" itemprop=3D"map">View map</a></span>=
</div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left=
; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: =
Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; l=
ine-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: no=
ne;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" cellp=
adding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-botto=
m: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color:=
 #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: an=
tialiased;margin: 0; padding: 0;">Guests</h2></td></tr></table><div style=
=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;"><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a></span=
><meta itemprop=3D"email" content=3D"alex.bennee@linaro.org"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"> =
- creator</span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:armbru@redhat.com=
">armbru@redhat.com</a></span><meta itemprop=3D"email" content=3D"armbru@re=
dhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:bcain=
@quicinc.com">bcain@quicinc.com</a></span><meta itemprop=3D"email" content=
=3D"bcain@quicinc.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:berrange@redhat.com">berrange@redhat.com</a></span><meta itemprop=
=3D"email" content=3D"berrange@redhat.com"/></span><span class=3D"secondary=
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
decoration: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta =
itemprop=3D"email" content=3D"cw@f00f.org"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a></span>=
<meta itemprop=3D"email" content=3D"eblake@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:edgar.iglesias@gmail.com">edgar.ig=
lesias@gmail.com</a></span><meta itemprop=3D"email" content=3D"edgar.iglesi=
as@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:e=
duardo@habkost.net">eduardo@habkost.net</a></span><meta itemprop=3D"email" =
content=3D"eduardo@habkost.net"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:felipe@nutanix.com">felipe@nutanix.com</a></span><meta ite=
mprop=3D"email" content=3D"felipe@nutanix.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:iggy@theiggy.com">iggy@theiggy.com</a></spa=
n><meta itemprop=3D"email" content=3D"iggy@theiggy.com"/></span><span class=
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
043; text-decoration: none;" href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com<=
/a></span><meta itemprop=3D"email" content=3D"jgg@nvidia.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:jidong.xiao@gmail.com">jid=
ong.xiao@gmail.com</a></span><meta itemprop=3D"email" content=3D"jidong.xia=
o@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:j=
im.shu@sifive.com">jim.shu@sifive.com</a></span><meta itemprop=3D"email" co=
ntent=3D"jim.shu@sifive.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></spa=
n><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:mdean@redhat.com">mdean@re=
dhat.com</a></span><meta itemprop=3D"email" content=3D"mdean@redhat.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:paul.walmsley@sif=
ive.com">paul.walmsley@sifive.com</a></span><meta itemprop=3D"email" conten=
t=3D"paul.walmsley@sifive.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a></span><meta it=
emprop=3D"email" content=3D"pbonzini@redhat.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:peter.maydell@linaro.org">peter.maydell@l=
inaro.org</a></span><meta itemprop=3D"email" content=3D"peter.maydell@linar=
o.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:richard.=
henderson@linaro.org">richard.henderson@linaro.org</a></span><meta itemprop=
=3D"email" content=3D"richard.henderson@linaro.org"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:shentey@gmail.com">shentey@gmail.com</=
a></span><meta itemprop=3D"email" content=3D"shentey@gmail.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmail.com">stefan=
ha@gmail.com</a></span><meta itemprop=3D"email" content=3D"stefanha@gmail.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:wei.w.wang@=
intel.com">wei.w.wang@intel.com</a></span><meta itemprop=3D"email" content=
=3D"wei.w.wang@intel.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span><meta itemp=
rop=3D"email" content=3D"zwu.kernel@gmail.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a></s=
pan><meta itemprop=3D"email" content=3D"philmd@linaro.org"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:eblot@rivosinc.com">eblot@rivos=
inc.com</a></span><meta itemprop=3D"email" content=3D"eblot@rivosinc.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:max.chou@sifive.=
com">max.chou@sifive.com</a></span><meta itemprop=3D"email" content=3D"max.=
chou@sifive.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:manos.pitsidianakis@linaro.org">manos.pitsidianakis@linaro.org</a></span>=
<meta itemprop=3D"email" content=3D"manos.pitsidianakis@linaro.org"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:thuth@redhat.com">thut=
h@redhat.com</a></span><meta itemprop=3D"email" content=3D"thuth@redhat.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:rbc@meta.com"=
>rbc@meta.com</a></span><meta itemprop=3D"email" content=3D"rbc@meta.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:demiobenour@gmai=
l.com">demiobenour@gmail.com</a></span><meta itemprop=3D"email" content=3D"=
demiobenour@gmail.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:hi@alyssa.is">hi@alyssa.is</a></span><meta itemprop=3D"email" conte=
nt=3D"hi@alyssa.is"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:dhedde@kalrayinc.com">dhedde@kalrayinc.com</a></span><meta itemprop=
=3D"email" content=3D"dhedde@kalrayinc.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:afaria@redhat.com">afaria@redhat.com</a></span=
><meta itemprop=3D"email" content=3D"afaria@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:aesteve@redhat.com">aesteve@redhat=
.com</a></span><meta itemprop=3D"email" content=3D"aesteve@redhat.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:marcandre.lureau@=
gmail.com">marcandre.lureau@gmail.com</a></span><meta itemprop=3D"email" co=
ntent=3D"marcandre.lureau@gmail.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:alistair.francis@wdc.com">alistair.francis@wdc.com</a=
></span><meta itemprop=3D"email" content=3D"alistair.francis@wdc.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@oracle.c=
om">konrad.wilk@oracle.com</a></span><meta itemprop=3D"email" content=3D"ko=
nrad.wilk@oracle.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:ale@rev.ng">ale@rev.ng</a></span><meta itemprop=3D"email" content=3D=
"ale@rev.ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:c=
lg@kaod.org">clg@kaod.org</a></span><meta itemprop=3D"email" content=3D"clg=
@kaod.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:anjo=
@rev.ng">anjo@rev.ng</a></span><meta itemprop=3D"email" content=3D"anjo@rev=
.ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:chao.p.pen=
g@linux.intel.com">chao.p.peng@linux.intel.com</a></span><meta itemprop=3D"=
email" content=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:elena.ufimtseva@oracle.com">elena.ufimtseva=
@oracle.com</a></span><meta itemprop=3D"email" content=3D"elena.ufimtseva@o=
racle.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric=
.auger@redhat.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email"=
 content=3D"eric.auger@redhat.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta it=
emprop=3D"email" content=3D"jan.kiszka@web.de"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@o=
racle.com</a></span><meta itemprop=3D"email" content=3D"joao.m.martins@orac=
le.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:luc@lmi=
chel.fr">luc@lmichel.fr</a></span><meta itemprop=3D"email" content=3D"luc@l=
michel.fr"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:sham=
eerali.kolothum.thodi@huawei.com">shameerali.kolothum.thodi@huawei.com</a><=
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
@linux.alibaba.com">zhiwei_liu@linux.alibaba.com</a></span><meta itemprop=
=3D"email" content=3D"zhiwei_liu@linux.alibaba.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nong=
nu.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:nelson.ho@wind=
river.com">nelson.ho@windriver.com</a></span><meta itemprop=3D"email" conte=
nt=3D"nelson.ho@windriver.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div></div></div></td><=
/tr></table></td></tr></tbody></table></div><!--[if mso | IE]></td><![endif=
]--><!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></table><t=
able border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"=
 align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"=
font-size: 0; padding: 0; text-align: left; word-break: break-word;;padding=
:4px 12px;" class=3D"" align=3D"left"><div class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;font-family: Roboto, sans-serif;f=
ont-size: 12px; line-height: 16px; mso-line-height-rule: exactly; text-alig=
n: left;"><p>Invitation from <a href=3D"https://calendar.google.com/calenda=
r/" class=3D"accent-text underline-on-hover" style=3D"font-family: Roboto, =
sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: exactl=
y;;color: #1a73e8; text-decoration: none;" target=3D"_blank">Google Calenda=
r</a></p><p>You are receiving this email because you are an attendee on the=
 event.</p><p>Forwarding this invitation could allow any recipient to send =
a response to the organizer, be added to the guest list, invite others rega=
rdless of their own invitation status, or modify your RSVP. <a class=3D"acc=
ent-text underline-on-hover" style=3D"font-family: Roboto, sans-serif;font-=
size: 12px; line-height: 16px; mso-line-height-rule: exactly;;color: #1a73e=
8; text-decoration: none;" href=3D"https://support.google.com/calendar/answ=
er/37135#forwarding">Learn more</a></p></div></td></tr></tbody></table></td=
></tr></tbody></table></span></span></body></html>
--00000000000097fb5106458551a6
Content-Type: text/calendar; charset="UTF-8"; method=CANCEL
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:CANCEL
BEGIN:VEVENT
DTSTART:20260512T130000Z
DTEND:20260512T140000Z
DTSTAMP:20251209T135922Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:5o8knt1c26rbmq46204rq8mc53@google.com
RECURRENCE-ID:20260512T130000Z
CREATED:20230221T153950Z
LAST-MODIFIED:20251209T135854Z
SEQUENCE:2
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

--00000000000097fb5106458551a6--

--00000000000097fb5206458551a8
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6Q0FOQ0VM
DQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ6MjAyNjA1MTJUMTMwMDAwWg0KRFRFTkQ6MjAyNjA1MTJU
MTQwMDAwWg0KRFRTVEFNUDoyMDI1MTIwOVQxMzU5MjJaDQpPUkdBTklaRVI7Q049UUVNVSBQcm9q
ZWN0IENhbGVuZGFyOm1haWx0bzpjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGdyb3UNCiBw
LmNhbGVuZGFyLmdvb2dsZS5jb20NClVJRDo1bzhrbnQxYzI2cmJtcTQ2MjA0cnE4bWM1M0Bnb29n
bGUuY29tDQpSRUNVUlJFTkNFLUlEOjIwMjYwNTEyVDEzMDAwMFoNCkNSRUFURUQ6MjAyMzAyMjFU
MTUzOTUwWg0KTEFTVC1NT0RJRklFRDoyMDI1MTIwOVQxMzU4NTRaDQpTRVFVRU5DRToyDQpTVEFU
VVM6Q0FOQ0VMTEVEDQpTVU1NQVJZOlFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxs
DQpUUkFOU1A6T1BBUVVFDQpBVFRBQ0g7RklMRU5BTUU9Tm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVs
b3BlcnMgY29uZmVyZW5jZSBjYWxsO0ZNVFRZUEU9YXBwbGljYQ0KIHRpb24vdm5kLmdvb2dsZS1h
cHBzLmRvY3VtZW50Omh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxM
eg0KIHhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1TSkJHUVpyZWsvZWRpdA0KQkVHSU46VkFMQVJN
DQpBQ1RJT046RU1BSUwNCkRFU0NSSVBUSU9OOlRoaXMgaXMgYW4gZXZlbnQgcmVtaW5kZXINClNV
TU1BUlk6QWxhcm0gbm90aWZpY2F0aW9uDQpBVFRFTkRFRTptYWlsdG86cWVtdS1kZXZlbEBub25n
bnUub3JnDQpUUklHR0VSOi1QMkQNCkVORDpWQUxBUk0NCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5E
QVINCg==
--00000000000097fb5206458551a8--

