Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADE8C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4g2-00010T-70; Tue, 24 Jun 2025 10:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU4fp-0000tL-IB
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:30:59 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU4fi-0005iJ-7w
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:30:57 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso30189255e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750775448; x=1751380248; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=no8bscLNMeJ9xedsJlAnk4bOlXaGrLm5WP9CeeTTH8g=;
 b=T9+caNIz0FvGrFW8v3UOHjVJbPQ79HJL/vNW6oVMtlhh103VdHh19BI+bFaURsMkEG
 W/asW0iV9VQ70VMkKWDan6cgNa5ixTEihAVdkwNuAsU4l4H5KnRu9T2M+JKd9DNINugo
 nXHoXoSJBluNuJPY7CarvGPVEP7xI24p7OK6wpkdSJnGFxg9lak2LVjQaJ+g0ppF9wFz
 31AJUKejGTtJrv2emr+2Zyx3cJ46AePphORWKGrNAz2MkLtxa9KuYQ7aS8YeGv4fSccD
 zW836/lJ2E29pFWEfFttKfUbO2aVQz3ZIt7IaUVBfgdi0J8/ZjnWwTIiXGj9+rGoqdNP
 Jh4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750775448; x=1751380248; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=no8bscLNMeJ9xedsJlAnk4bOlXaGrLm5WP9CeeTTH8g=;
 b=gwkl0ILWMrJPKTnTP/6gGuQvbjq89YHOjiufQXPr+YrCpBtStqqHxPlmEKbFJK8MlR
 aeLt1VaZnNdYotEkXMEyfFTW+MdvzUJMp4pNfaZZCedJCR3HbNTtMjEpqfSoXbGNEFNX
 o4MNypVqBXwiqp9lIlwCz3UO0r5R+lTzyTCHdaYggzv064oicUYNcMeB6dQcSOtr5xy+
 jPqXIyd0Ukx3xGosLBGIYLzr/etX+p8N5ybh1AeilTkvz1oIaZMkUGouK0Mdp6pO0FTj
 +tp9Vrz+Suz7l5xbGI5xQeTNzxV21P6QpGpTwCSMwoE3nNnTO3625rskmBk0nUlHf2FJ
 bI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775448; x=1751380248;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=no8bscLNMeJ9xedsJlAnk4bOlXaGrLm5WP9CeeTTH8g=;
 b=QSe/3Lp1svWzmZeCnvoXNrNEjDcvhz/xTu5Vtf6aMno+tTAEqdUbJ1WhvzHPrxXIJr
 10hXzQCyl3AJD2QZL4PIFfPeTuKOYL/JQAIeBWhXMIDHE5UO7QJLFe33k07ph383s1Cv
 c87rz5uI/zp0ffdM6SIh5b227co5jy1njpEZIWAs2TnFiaRZLNlLsXWl1LuvKUVriRDK
 WvkclE1nPAySExIwQ5ZVdQuJnR5mH4X09rfT/kMNuJQHyrYzH30WPwwEY2Z7/ZikvWHe
 5gp9CwFV1UPnC6iepmSFJWKWXsvwrOfZPx4YY2cizLbrLqblLRV3ucSlCJtxyVgjErCV
 uaoA==
X-Gm-Message-State: AOJu0YwuUFZr9PoWtcHjxJ3WnEsKAzhc2Nbch2HJKgG/fFMMqAlll7dK
 frJwVyB/K3Vpi0bQ4Eqh23sMnYCtcgQFikKq5o7wQxe8GjMEjqgGGBv6j/tqz1UqQGgy9kKbpE/
 cy1XahesH6qAMUDUi5cnbf5N4wUKW+BNcFBYYuHZHNLYK/iK4gvyQfw==
X-Google-Smtp-Source: AGHT+IFWgmbykmQGgAVbMsSpzyjKUA1kdTSg0AaeUaRiAzrWQkc4f1UsIaWFP0vy/By0QOaoF4UBPg82yuOngm9df6Gb
MIME-Version: 1.0
X-Received: by 2002:a05:600c:4f51:b0:450:c9e3:91fe with SMTP id
 5b1f17b1804b1-4537b654daemr35344755e9.0.1750775447629; Tue, 24 Jun 2025
 07:30:47 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-08fcaa6e-ef65-4027-9e3c-29e18c71f113@google.com>
Date: Tue, 24 Jun 2025 14:30:47 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 14:00 to 15:00 on Tuesday (BST) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000a34d2b0638522c78"
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

--000000000000a34d2b0638522c78
Content-Type: multipart/alternative; boundary="000000000000a34d2b0638522c76"

--000000000000a34d2b0638522c76
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9t
IDE0OjAwIHRvIDE1OjAwIG9uIFR1ZXNkYXkNClVuaXRlZCBLaW5nZG9tIFRpbWUNCg0KTG9jYXRp
b24NCmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29n
bGUuY29tL3VybD9xPWh0dHBzJTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZz
YT1EJnVzdD0xNzUxMjA3NDAwMDAwMDAwJnVzZz1BT3ZWYXcyaDRVSHJjNWZ2and3TkJicjBxUVp2
DQoNCg0KDQpBdHRhY2htZW50cw0KTm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVy
ZW5jZSBjYWxsICANCmh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxM
enhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1TSkJHUVpyZWsvZWRpdA0KDQpJZiB5b3UgbmVlZCBj
YWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnDQoN
Ckd1ZXN0cw0KQWxleCBCZW5uw6llDQphcm1icnVAcmVkaGF0LmNvbQ0KYmNhaW5AcXVpY2luYy5j
b20NCmJlcnJhbmdlQHJlZGhhdC5jb20NCmNqaWFAbnZpZGlhLmNvbQ0KY3dAZjAwZi5vcmcNCmVi
bGFrZUByZWRoYXQuY29tDQplZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20NCmVkdWFyZG9AaGFia29z
dC5uZXQNCmZlbGlwZUBudXRhbml4LmNvbQ0KaWdneUB0aGVpZ2d5LmNvbQ0KaW1wQGJzZGltcC5j
b20NCmpnZ0BudmlkaWEuY29tDQpqaWRvbmcueGlhb0BnbWFpbC5jb20NCmppbS5zaHVAc2lmaXZl
LmNvbQ0KbWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tDQptZGVhbkByZWRoYXQuY29tDQpwYXVsLndh
bG1zbGV5QHNpZml2ZS5jb20NCnBib256aW5pQHJlZGhhdC5jb20NClBldGVyIE1heWRlbGwNClJp
Y2hhcmQgSGVuZGVyc29uDQpzaGVudGV5QGdtYWlsLmNvbQ0Kc3RlZmFuaGFAZ21haWwuY29tDQp3
ZWkudy53YW5nQGludGVsLmNvbQ0Kend1Lmtlcm5lbEBnbWFpbC5jb20NClBoaWwgTWF0aGlldS1E
YXVkw6kNCmVibG90QHJpdm9zaW5jLmNvbQ0KbWF4LmNob3VAc2lmaXZlLmNvbQ0KTWFub3MgUGl0
c2lkaWFuYWtpcw0KdGh1dGhAcmVkaGF0LmNvbQ0KcmJjQG1ldGEuY29tDQpBbGlzdGFpciBGcmFu
Y2lzDQprb25yYWQud2lsa0BvcmFjbGUuY29tDQpBbGVzc2FuZHJvIERpIEZlZGVyaWNvDQpDw6lk
cmljIExlIEdvYXRlcg0KQW50b24gSm9oYW5zc29uDQpDaGFvIFBlbmcNCkRhbWllbiBIZWRkZQ0K
RWxlbmEgVWZpbXRzZXZhDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmphbi5raXN6a2FAd2ViLmRl
DQpKb2FvIE1hcnRpbnMNCkx1YyBNaWNoZWwNCm1pbXVAbGludXgudm5ldC5pYm0uY29tDQpTaGFt
ZWVyYWxpIEtvbG90aHVtIFRob2RpDQp6Lmh1b0AxMzkuY29tDQpMSVUgWmhpd2VpDQpxZW11LWRl
dmVsQG5vbmdudS5vcmcNCm5lbHNvbi5ob0B3aW5kcml2ZXIuY29tDQpkZW1pb2Jlbm91ckBnbWFp
bC5jb20NCmhpQGFseXNzYS5pcw0KDQoNCn5+Ly9+fg0KSW52aXRhdGlvbiBmcm9tIEdvb2dsZSBD
YWxlbmRhcjogaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyLw0KDQpZb3UgYXJl
IHJlY2VpdmluZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFyZSBhbiBhdHRlbmRlZSBvbiB0aGUg
ZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNvdWxkIGFsbG93IGFueSByZWNp
cGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdhbml6ZXIsIGJlIGFkZGVkIHRv
IHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxlc3Mgb2YgIA0KdGhlaXIgb3du
IGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBSU1ZQLg0KDQpMZWFybiBtb3JlIGh0
dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dlci8zNzEzNSNmb3J3YXJkaW5n
DQo=
--000000000000a34d2b0638522c76
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
</h2></td></tr></table><span>Every 2 weeks from 14:00 to 15:00 on Tuesday (=
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
lmeeting&amp;sa=3DD&amp;ust=3D1751207400000000&amp;usg=3DAOvVaw2h4UHrc5fvjw=
wNBbr0qQZv" class=3D"accent-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #1a73e8; text-decoration: none;font-weight: 700;" target=
=3D"_blank" itemprop=3D"map">View map</a></span></div></td></tr><tr><td sty=
le=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;p=
adding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-sty=
le: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-sp=
acing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text"=
 role=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=
=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decoration:=
 none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; paddi=
ng: 0;">Guests</h2></td></tr></table><div style=3D"padding-bottom: 4px; tex=
t-align: left;;color: #3c4042;"><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:alex.benn=
ee@linaro.org">Alex Benn=C3=A9e</a></span><meta itemprop=3D"email" content=
=3D"alex.bennee@linaro.org"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
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
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:alistair.=
francis@wdc.com">Alistair Francis</a></span><meta itemprop=3D"email" conten=
t=3D"alistair.francis@wdc.com"/></span><span class=3D"secondary-text" style=
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
43; text-decoration: none;" href=3D"mailto:ale@rev.ng">Alessandro Di Federi=
co</a></span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:clg@kaod.org">C=C3=A9dric Le =
Goater</a></span><meta itemprop=3D"email" content=3D"clg@kaod.org"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:anjo@rev.ng">Anton Joha=
nsson</a></span><meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:chao.p.peng@linux.intel.c=
om">Chao Peng</a></span><meta itemprop=3D"email" content=3D"chao.p.peng@lin=
ux.intel.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:d=
hedde@kalrayinc.com">Damien Hedde</a></span><meta itemprop=3D"email" conten=
t=3D"dhedde@kalrayinc.com"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></span><meta i=
temprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:eric.auger@redhat.com">eric.auger=
@redhat.com</a></span><meta itemprop=3D"email" content=3D"eric.auger@redhat=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jan.kiszk=
a@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" content=3D"j=
an.kiszka@web.de"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:joao.m.martins@oracle.com">Joao Martins</a></span><meta itemprop=3D"emai=
l" content=3D"joao.m.martins@oracle.com"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:luc@lmichel.fr">Luc Michel</a></span><meta itempr=
op=3D"email" content=3D"luc@lmichel.fr"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</=
a></span><meta itemprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:shameerali.kolothum.=
thodi@huawei.com">Shameerali Kolothum Thodi</a></span><meta itemprop=3D"ema=
il" content=3D"shameerali.kolothum.thodi@huawei.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></spa=
n><meta itemprop=3D"email" content=3D"z.huo@139.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhi=
wei</a></span><meta itemprop=3D"email" content=3D"zhiwei_liu@linux.alibaba.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel=
@nongnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" conte=
nt=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:nelson.ho@windriver.com">nelson.ho@windriver.com</a></span>=
<meta itemprop=3D"email" content=3D"nelson.ho@windriver.com"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:demiobenour@gmail.com">demiob=
enour@gmail.com</a></span><meta itemprop=3D"email" content=3D"demiobenour@g=
mail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:hi@al=
yssa.is">hi@alyssa.is</a></span><meta itemprop=3D"email" content=3D"hi@alys=
sa.is"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div></div></div></td></tr></table></td></tr></=
tbody></table></div><!--[if mso | IE]></td><![endif]--><!--[if mso | IE]></=
tr></table><![endif]--></td></tr></tbody></table><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D""><tbody><tr><td style=3D"font-size: 0; padding: =
0; text-align: left; word-break: break-word;;padding:4px 12px;" class=3D"" =
align=3D"left"><div class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;font-family: Roboto, sans-serif;font-size: 12px; line-heig=
ht: 16px; mso-line-height-rule: exactly; text-align: left;"><p>Invitation f=
rom <a href=3D"https://calendar.google.com/calendar/" class=3D"accent-text =
underline-on-hover" style=3D"font-family: Roboto, sans-serif;font-size: 12p=
x; line-height: 16px; mso-line-height-rule: exactly;;color: #1a73e8; text-d=
ecoration: none;" target=3D"_blank">Google Calendar</a></p><p>You are recei=
ving this email because you are an attendee on the event.</p><p>Forwarding =
this invitation could allow any recipient to send a response to the organiz=
er, be added to the guest list, invite others regardless of their own invit=
ation status, or modify your RSVP. <a class=3D"accent-text underline-on-hov=
er" style=3D"font-family: Roboto, sans-serif;font-size: 12px; line-height: =
16px; mso-line-height-rule: exactly;;color: #1a73e8; text-decoration: none;=
" href=3D"https://support.google.com/calendar/answer/37135#forwarding">Lear=
n more</a></p></div></td></tr></tbody></table></td></tr></tbody></table></s=
pan></span></body></html>
--000000000000a34d2b0638522c76
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
DTSTART;TZID=3DAmerica/New_York:20250624T090000
DTEND;TZID=3DAmerica/New_York:20250624T100000
RRULE:FREQ=3DWEEKLY;WKST=3DMO;INTERVAL=3D2;BYDAY=3DTU
DTSTAMP:20250624T143047Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20250624T130000@google.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Deduardo@habkost.net;X-NUM-GUESTS=3D0:mailto:eduardo@habkost.net
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;RSV=
P=3DTRUE
 ;CN=3Dmdean@redhat.com;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;RSV=
P=3DTRUE
 ;CN=3DManos Pitsidianakis;X-NUM-GUESTS=3D0:mailto:manos.pitsidianakis@lina=
ro.or
 g
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3DDamien Hedde;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dqemu-devel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.org
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
X-MICROSOFT-CDO-OWNERAPPTID:2077672719
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20250624T143038Z
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

--000000000000a34d2b0638522c76--

--000000000000a34d2b0638522c78
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
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjUwNjI0VDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjUwNjI0VDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztJ
TlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjUwNjI0VDE0MzA0N1oNCk9SR0FOSVpFUjtD
Tj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJrdTVzaTAxYmxt
bmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjFndnViOTQzNW83aHJyZW0wYTBy
YWxubDVpX1IyMDI1MDYyNFQxMzAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxleC5iZW5uZWVAbGluYXJvLm9yZw0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hcm1icnVAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86YXJtYnJ1QHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YmNh
aW5AcXVpY2luYy5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJjYWluQHF1aWNpbmMuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWJlcnJhbmdlQHJlZGhhdC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049Y2ppYUBudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjamlhQG52aWRpYS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Y3dAZjAwZi5vcmc7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOmN3QGYwMGYub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVibGFr
ZUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxha2VAcmVkaGF0LmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lZGdhci5pZ2xlc2lhc0BnbWFpbC5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmVkZ2FyLmlnbGVzaWFzQGdtYWlsDQogLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO1JT
VlA9VFJVDQogRTtDTj1lZHVhcmRvQGhhYmtvc3QubmV0O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpl
ZHVhcmRvQGhhYmtvc3QubmV0DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWZlbGlwZUBu
dXRhbml4LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZmVsaXBlQG51dGFuaXguY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWlnZ3lAdGhlaWdneS5jb207WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOmlnZ3lAdGhlaWdneS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aW1w
QGJzZGltcC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPWpnZ0BudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpqZ2dAbnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qaWRvbmcueGlh
b0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmppZG9uZy54aWFvQGdtYWlsLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qaW0uc2h1QHNpZml2ZS5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmppbS5zaHVAc2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1tYnVydG9uQHF0aS5xdWFsY29tbS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1idXJ0
b25AcXRpLnF1YWxjb21tDQogLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9REVDTElORUQ7UlNWUD1UUlVFDQogO0NOPW1kZWFuQHJl
ZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1kZWFuQHJlZGhhdC5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElW
RTtSU1ZQPVRSVQ0KIEU7Q049cGF1bC53YWxtc2xleUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpwYXVsLndhbG1zbGV5QHNpZml2ZS5jbw0KIG0NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049cGJvbnppbmlAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGJvbnpp
bmlAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1QZXRlciBNYXlkZWxs
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049UmljaGFyZCBIZW5kZXJzb247WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcg0KIGcNCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0K
IEU7Q049c2hlbnRleUBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnNoZW50ZXlAZ21h
aWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1URU5UQVRJVkU7UlNWUD1UUlUNCiBFO0NOPXN0ZWZhbmhhQGdtYWlsLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86c3RlZmFuaGFAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPXdlaS53LndhbmdAaW50ZWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp3ZWku
dy53YW5nQGludGVsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj16d3Uua2VybmVs
QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86end1Lmtlcm5lbEBnbWFpbC5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBoaWxtZEBsaW5h
cm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1URU5UQVRJVkU7UlNWUD1UUlUNCiBFO0NOPWVibG90QHJpdm9zaW5jLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86ZWJsb3RAcml2b3NpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPW1heC5jaG91QHNpZml2ZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1heC5j
aG91QHNpZml2ZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPURFQ0xJTkVEO1JTVlA9VFJVRQ0KIDtDTj1NYW5vcyBQaXRzaWRpYW5h
a2lzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYW5vcy5waXRzaWRpYW5ha2lzQGxpbmFyby5vcg0K
IGcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049dGh1dGhAcmVkaGF0LmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86dGh1dGhAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1yYmNAbWV0YS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJiY0BtZXRhLmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1BbGlzdGFpciBGcmFuY2lzO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzphbGlzdGFpci5mcmFuY2lzQHdkYy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049a29ucmFkLndpbGtAb3JhY2xlLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86a29ucmFk
LndpbGtAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1BbGVzc2FuZHJv
IERpIEZlZGVyaWNvO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbGVAcmV2Lm5nDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjbGdAa2FvZC5vcmcNCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049QW50b24gSm9oYW5zc29uO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzphbmpvQHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1DaGFvIFBlbmc7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNoYW8ucC5wZW5nQGxpbnV4LmludGVsLmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBU
RUQ7UlNWUD1UUlVFDQogO0NOPURhbWllbiBIZWRkZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZGhl
ZGRlQGthbHJheWluYy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049RWxlbmEgVWZp
bXRzZXZhO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lcmljLmF1Z2VyQHJlZGhhdC5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1qYW4ua2lzemthQHdlYi5kZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amFuLmtp
c3prYUB3ZWIuZGUNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0aW5zO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPUx1YyBNaWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmx1Y0Bs
bWljaGVsLmZyDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1pbXVAbGludXgudm5ldC5p
Ym0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptaW11QGxpbnV4LnZuZXQuaWJtLmMNCiBvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1TaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpzaGFtZWVyYWxpLmtvbG90aHVtDQogLnRob2RpQGh1YXdlaS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ei5odW9AMTM5LmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86ei5odW9AMTM5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1M
SVUgWmhpd2VpO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049cWVtdS1kZXZlbEBub25nbnUub3JnO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049bmVsc29uLmhvQHdpbmRyaXZlci5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
Om5lbHNvbi5ob0B3aW5kcml2ZXIuYw0KIG9tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PWRlbWlvYmVub3VyQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZGVtaW9iZW5vdXJA
Z21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWhpQGFseXNzYS5pcztYLU5V
TS1HVUVTVFM9MDptYWlsdG86aGlAYWx5c3NhLmlzDQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBU
SUQ6MjA3NzY3MjcxOQ0KQ1JFQVRFRDoyMDIzMDIyMVQxNTM5NTBaDQpERVNDUklQVElPTjpJZiB5
b3UgbmVlZCBjYWxsIGRldGFpbHNcLCBwbGVhc2UgY29udGFjdCBtZTogPGEgaHJlZj0ibWFpbHRv
OnENCiB1aW50ZWxhQHJlZGhhdC5jb20iPmFsZXguYmVubmVlQGxpbmFyby5vcmc8L2E+DQpMQVNU
LU1PRElGSUVEOjIwMjUwNjI0VDE0MzAzOFoNCkxPQ0FUSU9OOmh0dHBzOi8vbWVldC5qaXQuc2kv
a3ZtY2FsbG1lZXRpbmcNClNFUVVFTkNFOjANClNUQVRVUzpDT05GSVJNRUQNClNVTU1BUlk6UUVN
VS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwNClRSQU5TUDpPUEFRVUUNCkFUVEFDSDtG
SUxFTkFNRT1Ob3RlcyDigJMgUUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGw7Rk1U
VFlQRT1hcHBsaWNhDQogdGlvbi92bmQuZ29vZ2xlLWFwcHMuZG9jdW1lbnQ6aHR0cHM6Ly9kb2Nz
Lmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xLUx0cTExTEx6DQogeENjY2ZxZk5OS2NNRzc0SE1VSmY2
RFVSbVNKQkdRWnJlay9lZGl0DQpCRUdJTjpWQUxBUk0NCkFDVElPTjpFTUFJTA0KREVTQ1JJUFRJ
T046VGhpcyBpcyBhbiBldmVudCByZW1pbmRlcg0KU1VNTUFSWTpBbGFybSBub3RpZmljYXRpb24N
CkFUVEVOREVFOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNClRSSUdHRVI6LVAyRA0KRU5E
OlZBTEFSTQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxFTkRBUg0K
--000000000000a34d2b0638522c78--

