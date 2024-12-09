Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4106E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 11:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKblS-0001ZT-Fm; Mon, 09 Dec 2024 06:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3utFWZwsKCvkbmfy.cfooffmjobsp.pshrfnv-efwfmopohov.psh@calendar-server.bounces.google.com>)
 id 1tKblQ-0001ZJ-W0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:17:21 -0500
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3utFWZwsKCvkbmfy.cfooffmjobsp.pshrfnv-efwfmopohov.psh@calendar-server.bounces.google.com>)
 id 1tKblO-0004SO-3v
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:17:20 -0500
Received: by mail-ed1-x549.google.com with SMTP id
 4fb4d7f45d1cf-5d124077928so1473471a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 03:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733743034; x=1734347834; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EtBbeUX98BxKFJjPNFxrI3pOpUEUtA++0T9AXTtCLAY=;
 b=RQ1iRLWD8VRfSJrU+OaV8qufxuSmy9/T2vo93LYAXm6tkIRmPDPILEoKagbgfZgf7u
 llvB2ygDW9ge5SbpI0pJ8AaFpCLJG+/9JB0qCPO3sGYUzNhUesRtBbcTR/YNIJwoqq7O
 HvWiuMI6vKqCfAXz6A7a9b7Ibp+t1ZefijozXeR7OVBltm2fO77fjrH89TqHfkaNP+/2
 O+7IksmWnV2dpSC7dWUGx6xTmXRUv3puB6hfza13U4YhE8NqfZV5tVzHTLRsUmM6oG5k
 VU39b1SGtgho+kDeLsjsYgKXmHwUXtpozzUpPvdEzgrIinqhdHSe47YXHwmxBxw7UemO
 0qMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733743034; x=1734347834; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EtBbeUX98BxKFJjPNFxrI3pOpUEUtA++0T9AXTtCLAY=;
 b=vD9mGmXRyCI+kjBAbUG+ZssVIbZcV4SwYzK88SmyRVddRP7ltkeOq9xsAyj0gxhliy
 wTJNSTGMg61v/NyRpItmrF/K8zNnvUDEPz3zHtyKQqoyirlSOkAXEKsT/Q7UcyUN5Cj3
 2CAHTDGqX9Hshu5AkaT9MMEIBPVY0jAijBaCZr44V/hHocKiomRJxsTPHLbEXONMJEC4
 muq7gjDc3NQOF/bx9a7rxq8/d9OjBmfpYHVDPm+5zL70S7TY1raBbkL1WDqYTNj8Mlg0
 FxLWjhp1h+efibXP1eMQsOYsMo/yeHmAP4cFY5lDQgg6oWy3pjhw7NVFGj+4jIcIh1Xa
 PVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733743034; x=1734347834;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EtBbeUX98BxKFJjPNFxrI3pOpUEUtA++0T9AXTtCLAY=;
 b=S2oSOUa++EwUlM0TVemBBrro6jcKd2Rthpuou7baOt4O+u2SEz685PWLY0ZB2+UPZG
 WggoeGus/JlIEKo7G2ZpjeUrU7nFBAVDj5gk6PmFVzqLjPdy3MjjUukk4yHf8TaoZlP2
 AFtC4EZU32QPbNo6mbXZoFVIpsGbhn3wqRNJiXKuTrmKuZHpAm1GKNEQUozNemqKYco9
 Oi6y8+gC+ocs23Zwd9xIyp2zr2zbXBdH5lynIMdTRhxgHY1YLOy+m32Nj6iiB/t9M3l7
 +yFtvqWVYsd0UAeM/RGm9mkqxoNFQ/hVxgHdYZuZT7saxdc/YGDtiWVMTLsnTNaO1Dgu
 YZJg==
X-Gm-Message-State: AOJu0YyeJse9f+s9r+x8kTSo31XWjda8vR5nVY292GGJoYK69oWNeZuG
 NQHEIQJiu0utP6Rz0c2sOGXSYBIOl/d7XT97eex8R7liapobfrBI6mpZCWjv81r1wl83XOuxd1n
 kqINvQ2juZsARxappWcIFasD+44d6+ATmRuZ/B6M5gmdqDSdoEg==
X-Google-Smtp-Source: AGHT+IF65o1+gQtzBQrB+dmUuUEc/UinjfSQJIGL+rlIMTokTBM/WfT1NBGJNamodD/KPwgEray1yVYJOEtNAwIjankR
MIME-Version: 1.0
X-Received: by 2002:a05:6402:3184:b0:5d3:d8bb:3c5c with SMTP id
 4fb4d7f45d1cf-5d3d8bb3cedmr7258850a12.12.1733743034249; Mon, 09 Dec 2024
 03:17:14 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-026feda8-a0cb-4239-bf40-1a323eda1e42@google.com>
Date: Mon, 09 Dec 2024 11:17:14 +0000
Subject: Canceled event: QEMU/KVM developers conference call @ Tue 24 Dec 2024
 14:00 - 15:00 (GMT) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000b05ae20628d48107"
Received-SPF: pass client-ip=2a00:1450:4864:20::549;
 envelope-from=3utFWZwsKCvkbmfy.cfooffmjobsp.pshrfnv-efwfmopohov.psh@calendar-server.bounces.google.com;
 helo=mail-ed1-x549.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_FONT_LOW_CONTRAST=0.001,
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

--000000000000b05ae20628d48107
Content-Type: multipart/alternative; boundary="000000000000b05ae10628d48105"

--000000000000b05ae10628d48105
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiBjYW5jZWxlZC4NCg0KUUVNVS9LVk0gZGV2ZWxvcGVycyBjb25m
ZXJlbmNlIGNhbGwNClR1ZXNkYXkgMjQgRGVjIDIwMjQg4ouFIDE0OjAwIOKAkyAxNTowMA0KVW5p
dGVkIEtpbmdkb20gVGltZQ0KDQpMb2NhdGlvbg0KaHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxs
bWVldGluZwkNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vdXJsP3E9aHR0cHMlM0ElMkYlMkZtZWV0
LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5nJnNhPUQmdXN0PTE3MzQxNzUwMjAwMDAwMDAmdXNnPUFP
dlZhdzFpc3gxeXZVZlpTakYyRldxOGpYMWUNCg0KDQoNCkF0dGFjaG1lbnRzDQpOb3RlcyDigJMg
UUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwgIA0KaHR0cHM6Ly9kb2NzLmdvb2ds
ZS5jb20vZG9jdW1lbnQvZC8xLUx0cTExTEx6eENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNKQkdR
WnJlay9lZGl0DQoNCklmIHlvdSBuZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3QgbWU6
IGFsZXguYmVubmVlQGxpbmFyby5vcmcNCg0KR3Vlc3RzDQpBbGVzc2FuZHJvIERpIEZlZGVyaWNv
DQpBbGV4IEJlbm7DqWUNCkFsaXN0YWlyIEZyYW5jaXMNCmFybWJydUByZWRoYXQuY29tDQpiY2Fp
bkBxdWljaW5jLmNvbQ0KYmVycmFuZ2VAcmVkaGF0LmNvbQ0KY2ppYUBudmlkaWEuY29tDQpDw6lk
cmljIExlIEdvYXRlcg0KY3dAZjAwZi5vcmcNCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5pZ2xl
c2lhc0BnbWFpbC5jb20NCmVkdWFyZG9AaGFia29zdC5uZXQNCmZlbGlwZUBudXRhbml4LmNvbQ0K
aWdneUB0aGVpZ2d5LmNvbQ0KaW1wQGJzZGltcC5jb20NCmpnZ0BudmlkaWEuY29tDQpqaWRvbmcu
eGlhb0BnbWFpbC5jb20NCmppbS5zaHVAc2lmaXZlLmNvbQ0Ka29ucmFkLndpbGtAb3JhY2xlLmNv
bQ0KbWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tDQptZGVhbkByZWRoYXQuY29tDQpwYXVsLndhbG1z
bGV5QHNpZml2ZS5jb20NCnBib256aW5pQHJlZGhhdC5jb20NClBldGVyIE1heWRlbGwNClJpY2hh
cmQgSGVuZGVyc29uDQpzaGVudGV5QGdtYWlsLmNvbQ0Kc3RlZmFuaGFAZ21haWwuY29tDQp3ZWku
dy53YW5nQGludGVsLmNvbQ0Kend1Lmtlcm5lbEBnbWFpbC5jb20NClBoaWwgTWF0aGlldS1EYXVk
w6kNCmVibG90QHJpdm9zaW5jLmNvbQ0KbWF4LmNob3VAc2lmaXZlLmNvbQ0KTWFub3MgUGl0c2lk
aWFuYWtpcw0KdGh1dGhAcmVkaGF0LmNvbQ0KQW50b24gSm9oYW5zc29uDQpDaGFvIFBlbmcNCkRh
bWllbiBIZWRkZQ0KRWxlbmEgVWZpbXRzZXZhDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmphbi5r
aXN6a2FAd2ViLmRlDQpKb2FvIE1hcnRpbnMNCkx1YyBNaWNoZWwNCm1pbXVAbGludXgudm5ldC5p
Ym0uY29tDQpTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQp6Lmh1b0AxMzkuY29tDQpMSVUgWmhp
d2VpDQpxZW11LWRldmVsQG5vbmdudS5vcmcNCm5lbHNvbi5ob0B3aW5kcml2ZXIuY29tDQoNCg0K
fn4vL35+DQpJbnZpdGF0aW9uIGZyb20gR29vZ2xlIENhbGVuZGFyOiBodHRwczovL2NhbGVuZGFy
Lmdvb2dsZS5jb20vY2FsZW5kYXIvDQoNCllvdSBhcmUgcmVjZWl2aW5nIHRoaXMgZW1haWwgYmVj
YXVzZSB5b3UgYXJlIGFuIGF0dGVuZGVlIG9uIHRoZSBldmVudC4NCg0KRm9yd2FyZGluZyB0aGlz
IGludml0YXRpb24gY291bGQgYWxsb3cgYW55IHJlY2lwaWVudCB0byBzZW5kIGEgcmVzcG9uc2Ug
dG8gIA0KdGhlIG9yZ2FuaXplciwgYmUgYWRkZWQgdG8gdGhlIGd1ZXN0IGxpc3QsIGludml0ZSBv
dGhlcnMgcmVnYXJkbGVzcyBvZiAgDQp0aGVpciBvd24gaW52aXRhdGlvbiBzdGF0dXMsIG9yIG1v
ZGlmeSB5b3VyIFJTVlAuDQoNCkxlYXJuIG1vcmUgaHR0cHM6Ly9zdXBwb3J0Lmdvb2dsZS5jb20v
Y2FsZW5kYXIvYW5zd2VyLzM3MTM1I2ZvcndhcmRpbmcNCg==
--000000000000b05ae10628d48105
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
entCancelled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://sc=
hema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar"/=
></span><meta itemprop=3D"eventId/googleCalendar" content=3D"1gvub9435o7hrr=
em0a0ralnl5i_20241224T140000Z"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develope=
rs conference call</span><span aria-hidden=3D"true"><time itemprop=3D"start=
Date" datetime=3D"20241224T140000Z"></time><time itemprop=3D"endDate" datet=
ime=3D"20241224T150000Z"></time></span><table border=3D"0" cellpadding=3D"0=
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
anceled.</span></td></tr></tbody></table><!--[if mso | IE]><table border=3D=
"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td heigh=
t=3D"12" style=3D"height:12px;"><![endif]--><div style=3D"height:12px;" ari=
a-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></table><![endi=
f]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presen=
tation" align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td st=
yle=3D"border: solid 1px #dadce0; border-radius: 8px; direction: rtl; font-=
size: 0; padding: 24px 32px; text-align: left; vertical-align: top;" class=
=3D"main-container-inner"><!--[if mso | IE]><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><![endif]--><!--[if mso =
| IE]><td class=3D"" style=3D"vertical-align:top;width:37%;" ><![endif]--><=
div class=3D"column-per-37 outlook-group-fix" style=3D"font-size: 13px; tex=
t-align: left; direction: ltr; display: inline-block; vertical-align: top; =
width: 100%;overflow: hidden; word-wrap: break-word;"><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"><tb=
ody><tr><td style=3D"vertical-align:top;padding:0;"><table border=3D"0" cel=
lpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%"><tr><=
td style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-w=
ord;;padding-bottom:0px;"><div style=3D"font-family: Roboto, sans-serif;fon=
t-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text-align:=
 left;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bo=
ttom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;col=
or: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing:=
 antialiased;margin: 0; padding: 0;">Attachments</h2></td></tr></table></di=
v></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; wo=
rd-break: break-word;;padding-bottom:24px;padding-left: 1px; padding-right:=
 1px;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation" class=3D"attachment-chip" style=3D"border: solid 1px #dadce0; bor=
der-radius: 16px; border-collapse: separate; padding: 4px 0 4px 0;"><tr><td=
 style=3D"padding: 3px 10px; height: 14px; width: 14px;"><img src=3D"https:=
//drive-thirdparty.googleusercontent.com/16/type/application/vnd.google-app=
s.document" width=3D"14" height=3D"14" alt=3D"" style=3D"display: inline-bl=
ock; vertical-align: middle;"></td><td align=3D"left" style=3D"padding: 0; =
padding-left: 0; padding-right: 10px; max-width: 160px; overflow: hidden; t=
ext-overflow: ellipsis; white-space: nowrap;"><div style=3D"overflow: hidde=
n; height: 20px;"><a href=3D"https://docs.google.com/document/d/1-Ltq11LLzx=
CccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit" target=3D"_blank" style=3D"font-wei=
ght: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6=
368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; mar=
gin: 0; text-decoration: none; text-transform: none;;font-family: Roboto, s=
ans-serif;; display: inline-block; height: 20px; max-width: 160px; line-hei=
ght: 20px; overflow: hidden; text-overflow: ellipsis; vertical-align: middl=
e; white-space: normal;" class=3D"grey-button-text" title=3D"Notes =E2=80=
=93 QEMU/KVM developers conference call">Notes =E2=80=93 QEMU/KVM devel...<=
/a></div></td></tr></table></td></tr></table></td></tr></tbody></table></di=
v><!--[if mso | IE]></td><![endif]--><!--[if mso | IE]><td class=3D"" style=
=3D"vertical-align:top;width:63%;padding-right:32px;" ><![endif]--><div cla=
ss=3D"column-per-63 outlook-group-fix" style=3D"font-size: 13px; text-align=
: left; direction: ltr; display: inline-block; vertical-align: top; width: =
100%;overflow: hidden; word-wrap: break-word;"><table border=3D"0" cellpadd=
ing=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" class=3D"m=
ain-column-table-ltr" style=3D"padding-right: 32px; padding-left: 0;;table-=
layout: fixed;"><tbody><tr><td class=3D"main-column-td" style=3D"padding:0;=
 vertical-align:top;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"=
0" role=3D"presentation" width=3D"100%" style=3D"table-layout: fixed;"><tr>=
<td style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-=
word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;f=
ont-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; le=
tter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primar=
y-text" role=3D"presentation"><span>If you need call details, please contac=
t me: <a href=3D"mailto:quintela@redhat.com" target=3D"_blank">alex.bennee@=
linaro.org</a></span><meta itemprop=3D"description" content=3D"If you need =
call details, please contact me: alex.bennee@linaro.org"/></div></td></tr><=
tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: bre=
ak-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-seri=
f;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px;=
 letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"pri=
mary-text" role=3D"presentation"><span aria-hidden=3D"true"><time itemprop=
=3D"startDate" datetime=3D"20241224T140000Z"></time><time itemprop=3D"endDa=
te" datetime=3D"20241224T150000Z"></time></span><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom:=
 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #=
3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: anti=
aliased;margin: 0; padding: 0;">When</h2></td></tr></table><span>Tuesday 24=
 Dec 2024 =E2=8B=85 14:00 =E2=80=93 15:00 (United Kingdom Time)</span></div=
></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; wor=
d-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Robot=
o, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-h=
eight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" =
class=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpaddin=
g=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4p=
x;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4=
043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antiali=
ased;margin: 0; padding: 0;">Location</h2></td></tr></table><span itemprop=
=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span itemprop=
=3D"name" class=3D"primary-text notranslate" style=3D"font-family: Roboto, =
sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heig=
ht: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">htt=
ps://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.co=
m/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D1=
734175020000000&amp;usg=3DAOvVaw1isx1yvUfZSjF2FWq8jX1e" class=3D"accent-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #1a73e8; text-=
decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"map">View=
 map</a></span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; t=
ext-align: left; word-break: break-word;;padding-bottom:24px;"><div style=
=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; f=
ont-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; te=
xt-decoration: none;" class=3D"primary-text" role=3D"presentation"><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=
=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-=
size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-f=
ont-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td></tr></t=
able><div style=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;">=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:ale@rev.ng">Alessandro Di Federico</a></s=
pan><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:alex.bennee@linaro.org">Alex Benn=C3=
=A9e</a></span><meta itemprop=3D"email" content=3D"alex.bennee@linaro.org"/=
></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decora=
tion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemty=
pe=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslat=
e"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bl=
ock;;color: #3c4043; text-decoration: none;" href=3D"mailto:alistair.franci=
s@wdc.com">Alistair Francis</a></span><meta itemprop=3D"email" content=3D"a=
listair.francis@wdc.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:armbru@redhat.com">armbru@redhat.com</a></span><meta itemprop=3D=
"email" content=3D"armbru@redhat.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:bcain@quicinc.com">bcain@quicinc.com</a></span><meta=
 itemprop=3D"email" content=3D"bcain@quicinc.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:berrange@redhat.com">berrange@redhat.com=
</a></span><meta itemprop=3D"email" content=3D"berrange@redhat.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.com">cjia@=
nvidia.com</a></span><meta itemprop=3D"email" content=3D"cjia@nvidia.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:clg@kaod.org">C=
=C3=A9dric Le Goater</a></span><meta itemprop=3D"email" content=3D"clg@kaod=
.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.o=
rg">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/=
></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decora=
tion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemty=
pe=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslat=
e"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bl=
ock;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.c=
om">eblake@redhat.com</a></span><meta itemprop=3D"email" content=3D"eblake@=
redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:e=
dgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=
=3D"email" content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Per=
son"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text=
 underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-d=
ecoration: none;" href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</=
a></span><meta itemprop=3D"email" content=3D"eduardo@habkost.net"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">feli=
pe@nutanix.com</a></span><meta itemprop=3D"email" content=3D"felipe@nutanix=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@thei=
ggy.com">iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"igg=
y@theiggy.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
imp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=
=3D"imp@bsdimp.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"email" co=
ntent=3D"jgg@nvidia.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><meta ite=
mprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:jim.shu@sifive.com">jim.shu@sifive.com</=
a></span><meta itemprop=3D"email" content=3D"jim.shu@sifive.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com">k=
onrad.wilk@oracle.com</a></span><meta itemprop=3D"email" content=3D"konrad.=
wilk@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span><meta itempr=
op=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></=
span><meta itemprop=3D"email" content=3D"mdean@redhat.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:paul.walmsley@sifive.com">paul.=
walmsley@sifive.com</a></span><meta itemprop=3D"email" content=3D"paul.walm=
sley@sifive.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:pbonzini@redhat.com">pbonzini@redhat.com</a></span><meta itemprop=3D"emai=
l" content=3D"pbonzini@redhat.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></span><meta=
 itemprop=3D"email" content=3D"peter.maydell@linaro.org"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:richard.henderson@linaro.org">Ric=
hard Henderson</a></span><meta itemprop=3D"email" content=3D"richard.hender=
son@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:shentey@gmail.com">shentey@gmail.com</a></span><meta itemprop=3D"email" co=
ntent=3D"shentey@gmail.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a></span><meta itemp=
rop=3D"email" content=3D"stefanha@gmail.com"/></span><span class=3D"seconda=
ry-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div=
><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person=
"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text un=
derline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-deco=
ration: none;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a=
></span><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zw=
u.kernel@gmail.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel=
@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:p=
hilmd@linaro.org">Phil Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email=
" content=3D"philmd@linaro.org"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:eblot@rivosinc.com">eblot@rivosinc.com</a></span><meta ite=
mprop=3D"email" content=3D"eblot@rivosinc.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:max.chou@sifive.com">max.chou@sifive.com</a=
></span><meta itemprop=3D"email" content=3D"max.chou@sifive.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:manos.pitsidianakis@linar=
o.org">Manos Pitsidianakis</a></span><meta itemprop=3D"email" content=3D"ma=
nos.pitsidianakis@linaro.org"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a></span><meta itemprop=
=3D"email" content=3D"thuth@redhat.com"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:anjo@rev.ng">Anton Johansson</a></span><meta itemp=
rop=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</a></span><me=
ta itemprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/></span><span=
 class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;">=
</span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://=
schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:dhedde@kalrayinc.com">Dami=
en Hedde</a></span><meta itemprop=3D"email" content=3D"dhedde@kalrayinc.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:elena.ufimtse=
va@oracle.com">Elena Ufimtseva</a></span><meta itemprop=3D"email" content=
=3D"elena.ufimtseva@oracle.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a></span><me=
ta itemprop=3D"email" content=3D"eric.auger@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.=
de</a></span><meta itemprop=3D"email" content=3D"jan.kiszka@web.de"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.martins@oracle.=
com">Joao Martins</a></span><meta itemprop=3D"email" content=3D"joao.m.mart=
ins@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:luc@lmichel.fr">Luc Michel</a></span><meta itemprop=3D"email" content=3D"l=
uc@lmichel.fr"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta itemprop=
=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei.com">Shame=
erali Kolothum Thodi</a></span><meta itemprop=3D"email" content=3D"shameera=
li.kolothum.thodi@huawei.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=3D"em=
ail" content=3D"z.huo@139.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhiwei</a></span><meta it=
emprop=3D"email" content=3D"zhiwei_liu@linux.alibaba.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-deve=
l@nongnu.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel@nongn=
u.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:nelson.h=
o@windriver.com">nelson.ho@windriver.com</a></span><meta itemprop=3D"email"=
 content=3D"nelson.ho@windriver.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div></div></div>=
</td></tr></table></td></tr></tbody></table></div><!--[if mso | IE]></td><!=
[endif]--><!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></ta=
ble><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"present=
ation" align=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td sty=
le=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;p=
adding:4px 12px;" class=3D"" align=3D"left"><div class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;font-family: Roboto, sans-ser=
if;font-size: 12px; line-height: 16px; mso-line-height-rule: exactly; text-=
align: left;"><p>Invitation from <a href=3D"https://calendar.google.com/cal=
endar/" class=3D"accent-text underline-on-hover" style=3D"font-family: Robo=
to, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: ex=
actly;;color: #1a73e8; text-decoration: none;" target=3D"_blank">Google Cal=
endar</a></p><p>You are receiving this email because you are an attendee on=
 the event.</p><p>Forwarding this invitation could allow any recipient to s=
end a response to the organizer, be added to the guest list, invite others =
regardless of their own invitation status, or modify your RSVP. <a class=3D=
"accent-text underline-on-hover" style=3D"font-family: Roboto, sans-serif;f=
ont-size: 12px; line-height: 16px; mso-line-height-rule: exactly;;color: #1=
a73e8; text-decoration: none;" href=3D"https://support.google.com/calendar/=
answer/37135#forwarding">Learn more</a></p></div></td></tr></tbody></table>=
</td></tr></tbody></table></span></span></body></html>
--000000000000b05ae10628d48105
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
DTSTART;TZID=3DAmerica/New_York:20241224T090000
DTEND;TZID=3DAmerica/New_York:20241224T100000
DTSTAMP:20241209T111714Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20241126T140000@google.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;CN=
=3Dmdean@
 redhat.com;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Dpaul.
 walmsley@sifive.com;X-NUM-GUESTS=3D0:mailto:paul.walmsley@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dpb
 onzini@redhat.com;X-NUM-GUESTS=3D0:mailto:pbonzini@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DPe
 ter Maydell;X-NUM-GUESTS=3D0:mailto:peter.maydell@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DRi
 chard Henderson;X-NUM-GUESTS=3D0:mailto:richard.henderson@linaro.org
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Dqemu-
 devel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dne
 lson.ho@windriver.com;X-NUM-GUESTS=3D0:mailto:nelson.ho@windriver.com
RECURRENCE-ID;TZID=3DAmerica/New_York:20241224T090000
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20241209T111705Z
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

--000000000000b05ae10628d48105--

--000000000000b05ae20628d48107
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
VDtUWklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNDEyMjRUMDkwMDAwDQpEVEVORDtUWklEPUFtZXJp
Y2EvTmV3X1lvcms6MjAyNDEyMjRUMTAwMDAwDQpEVFNUQU1QOjIwMjQxMjA5VDExMTcxNFoNCk9S
R0FOSVpFUjtDTj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJr
dTVzaTAxYmxtbmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjFndnViOTQzNW83
aHJyZW0wYTByYWxubDVpX1IyMDI0MTEyNlQxNDAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VU
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
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NF
UFRFRDtDTj1tZGVhbkANCiByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptZGVhbkBy
ZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1URU5UQVRJVkU7Q049cGF1bC4NCiB3YWxtc2xleUBzaWZpdmUuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzpwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20NCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtD
Tj1wYg0KIG9uemluaUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYm9uemluaUBy
ZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049UGUNCiB0ZXIgTWF5ZGVsbDtYLU5VTS1HVUVTVFM9
MDptYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049UmkNCiBj
aGFyZCBIZW5kZXJzb247WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJpY2hhcmQuaGVuZGVyc29uQGxp
bmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPVRFTlRBVElWRTtDTj1zaGVudA0KIGV5QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86c2hlbnRleUBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtDTj1zdGVmYQ0KIG5oYUBnbWFp
bC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnN0ZWZhbmhhQGdtYWlsLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO0NOPXdlDQogaS53LndhbmdAaW50ZWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp3ZWku
dy53YW5nQGludGVsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPXp3DQogdS5rZXJuZWxAZ21haWwuY29t
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O1gtTlVNDQogLUdVRVNUUz0wOm1haWx0bzpwaGlsbWRAbGluYXJvLm9yZw0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO0NO
PWVibG90DQogQHJpdm9zaW5jLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWJsb3RAcml2b3Np
bmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047Q049bWENCiB4LmNob3VAc2lmaXZlLmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86bWF4LmNob3VAc2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9REVDTElORUQ7Q049TWFub3MgDQogUGl0
c2lkaWFuYWtpcztYLU5VTS1HVUVTVFM9MDptYWlsdG86bWFub3MucGl0c2lkaWFuYWtpc0BsaW5h
cm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047Q049dGgNCiB1dGhAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86dGh1dGhAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPUFuDQogdG9uIEpvaGFu
c3NvbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1D
aA0KIGFvIFBlbmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNoYW8ucC5wZW5nQGxpbnV4LmludGVs
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9QUNDRVBURUQ7Q049RGFtaWVuDQogIEhlZGRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpk
aGVkZGVAa2FscmF5aW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPUVsDQogZW5hIFVmaW10c2V2YTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtDTj1lcg0KIGljLmF1Z2VyQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVy
aWMuYXVnZXJAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWphDQogbi5raXN6a2FAd2ViLmRl
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqYW4ua2lzemthQHdlYi5kZQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NO
PUpvDQogYW8gTWFydGlucztYLU5VTS1HVUVTVFM9MDptYWlsdG86am9hby5tLm1hcnRpbnNAb3Jh
Y2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPUx1DQogYyBNaWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmx1Y0BsbWljaGVsLmZyDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049bWkNCiBtdUBsaW51eC52bmV0Lmli
bS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1pbXVAbGludXgudm5ldC5pYm0uY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047Q049U2gNCiBhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaTtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWENCiB3ZWkuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047Q049ei4NCiBodW9AMTM5LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ei5odW9AMTM5LmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO0NOPUxJDQogVSBaaGl3ZWk7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnpo
aXdlaV9saXVAbGludXguYWxpYmFiYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtDTj1xZW11LQ0KIGRldmVsQG5v
bmdudS5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO0NOPW5lDQogbHNvbi5ob0B3aW5kcml2ZXIuY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpuZWxzb24uaG9Ad2luZHJpdmVyLmNvbQ0KUkVDVVJSRU5DRS1JRDtUWklEPUFtZXJpY2Ev
TmV3X1lvcms6MjAyNDEyMjRUMDkwMDAwDQpDUkVBVEVEOjIwMjMwMjIxVDE1Mzk1MFoNCkRFU0NS
SVBUSU9OOklmIHlvdSBuZWVkIGNhbGwgZGV0YWlsc1wsIHBsZWFzZSBjb250YWN0IG1lOiA8YSBo
cmVmPSJtYWlsdG86cQ0KIHVpbnRlbGFAcmVkaGF0LmNvbSI+YWxleC5iZW5uZWVAbGluYXJvLm9y
ZzwvYT4NCkxBU1QtTU9ESUZJRUQ6MjAyNDEyMDlUMTExNzA1Wg0KTE9DQVRJT046aHR0cHM6Ly9t
ZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZw0KU0VRVUVOQ0U6MQ0KU1RBVFVTOkNBTkNFTExFRA0K
U1VNTUFSWTpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFV
RQ0KQVRUQUNIO0ZJTEVOQU1FPU5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVu
Y2UgY2FsbDtGTVRUWVBFPWFwcGxpY2ENCiB0aW9uL3ZuZC5nb29nbGUtYXBwcy5kb2N1bWVudDpo
dHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHoNCiB4Q2NjZnFmTk5L
Y01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCkJFR0lOOlZBTEFSTQ0KQUNUSU9OOkVNQUlM
DQpERVNDUklQVElPTjpUaGlzIGlzIGFuIGV2ZW50IHJlbWluZGVyDQpTVU1NQVJZOkFsYXJtIG5v
dGlmaWNhdGlvbg0KQVRURU5ERUU6bWFpbHRvOnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KVFJJR0dF
UjotUDJEDQpFTkQ6VkFMQVJNDQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=
--000000000000b05ae20628d48107--

