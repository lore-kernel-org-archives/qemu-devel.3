Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC81EC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZ5U-0003Lf-JM; Tue, 19 Mar 2024 09:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmZ4y-0002zK-7G
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:00:32 -0400
Received: from mail-lf1-x14a.google.com ([2a00:1450:4864:20::14a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmZ4v-0004LD-8z
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:00:31 -0400
Received: by mail-lf1-x14a.google.com with SMTP id
 2adb3069b0e04-513e9ac73bbso1835642e87.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710853226; x=1711458026; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Wx4AmdhoN8ZZIXibAAhktiWjpl2/M9Rycucxp8JX50=;
 b=WOm90tmLo36RAaX7X1RP1KkbS3c5MQwtrkWNlYwUoxjkcYCpzEtEtJ/X2TBzov/JXb
 aoSRW0ENtYMSBshSSI/CK3D+H90FInbWjia/fnWVf2f+4mHPJj6gAptc+ftgdA/yhU/E
 tsxbge9m9Z+cY03B3v/uYjH8oF6VaIkKRtCgKeqJL3wJdMAb9CKO5VXjhRJxD1sad9Bm
 P2JalR3djx8NSSbLKFUkOhXApEcQvyPTSyTPtuPzfbuoTKG/SNuAh/WA9T7dB2CrjeJy
 fQFp90IrBPPMqhvzWmweFpbeUtP3nFXEL/QnzghksWD2dDo4P/poJ6oedrbu4+/WlPZx
 7iTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853226; x=1711458026; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Wx4AmdhoN8ZZIXibAAhktiWjpl2/M9Rycucxp8JX50=;
 b=ljJnLdHmx/CLWo0Wuqg+PGRRqNQtMLgqHHjzwBZjUPf7ir7wPZ8Mt89hwIeuE+AcK7
 SxWb/wt1SWDZJ9+rtriQuwDHYTQ3eprh9Ao0zIgjD377NvlUMbKeIWFOX3FfVNA9ehly
 VhttXrSMtR/KbGQFL52Tinu4mt1VtzedNT/AvOHG/hw1HD2432uqFcEN4CFoxb5np5gE
 XKCmkmw+4wbrLraqT6mEfAPpTewIQRbCAa7sbvX/GFrNG0fzNcazkPmfYpp1w0BJmTkK
 pjTCTrfNZLevGsTK3JwJ/6naxnthKThRREVX5Ccxhu8TAH+JqzdvDXuN+cjbw9WYNFlU
 FFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853226; x=1711458026;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Wx4AmdhoN8ZZIXibAAhktiWjpl2/M9Rycucxp8JX50=;
 b=WBLRUt+Kd87BVXaYjgJ2hipxNSfjS5Mc1sYagrLJ/LN/Mfo2zWc6yOPHvJT1rDhfDo
 M0FWbVFAKeoqIH6/aHzD9u9StPJ5g0/aHor7M85iAh5s4qnYptnXSSLkYb8aMtK0VBNx
 nOh2ViQUf8GCh5uYLqmEWpnSoeMibVSt6/Hek06LieBs/hHbc0mPb8ptItReG4UsAdWc
 dufXSEFcPajq42LDqzb++1m6XKCjnXWfj7XlkIcl09ADZXlB8WuQPS6NA/pjCohkTRXB
 RqN3KZHmORlvKPJItjbhuFmID5BYbdPHw2W/EQehZ/Miz7sGxA91XhxiR9lVN8sOK0mf
 azjw==
X-Gm-Message-State: AOJu0YzdCbdNcLexCNfUK1K7yJKYz0e9s99QsJXtH70KZAk0f0hCU+Ea
 /Rf1fIH1Hl4elNc/q/OvwTfu1TtL6qmUhvjxt5scgD9nYHeW3qUeyvWiE4MYPzfNdjT7qx/t2LO
 +wz+kVvtzpbP9ccy95dk5QNDyhhIMe2lFNTbBonPwtd55T2wDww==
X-Google-Smtp-Source: AGHT+IHcnLh8knNlJojKi0esyMd4D4pwWIRV+62HaNtcALXxKxYK0MbPZZHyJNCzoDMWeXVNoz5yY3pVfSA0E1kzhndN
MIME-Version: 1.0
X-Received: by 2002:a2e:9581:0:b0:2d4:3dfc:af88 with SMTP id
 w1-20020a2e9581000000b002d43dfcaf88mr7828578ljh.7.1710853220941; Tue, 19 Mar
 2024 06:00:20 -0700 (PDT)
Message-ID: <calendar-f3a2e8fc-9eba-4e91-a1ea-7d4c248ae98f@google.com>
Date: Tue, 19 Mar 2024 13:00:20 +0000
Subject: Invitation: QEMU/KVM developers conference call @ Tue 2 Apr 2024
 14:00 - 15:00 (BST) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, ale@rev.ng, alistair.francis@wdc.com, 
 armbru@redhat.com, bcain@quicinc.com, berrange@redhat.com, cjia@nvidia.com, 
 clg@kaod.org, cw@f00f.org, eblake@redhat.com, edgar.iglesias@gmail.com, 
 eduardo@habkost.net, felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, 
 jgg@nvidia.com, jidong.xiao@gmail.com, jim.shu@sifive.com, 
 konrad.wilk@oracle.com, mburton@qti.qualcomm.com, mdean@redhat.com, 
 paul.walmsley@sifive.com, pbonzini@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 shentey@gmail.com, stefanha@gmail.com, wei.w.wang@intel.com, 
 zwu.kernel@gmail.com, =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 eblot@rivosinc.com, max.chou@sifive.com, afaerber@suse.de, 
 Anton Johansson <anjo@rev.ng>, bbauman@redhat.com,
 Chao Peng <chao.p.peng@linux.intel.com>, 
 Damien Hedde <dhedde@kalrayinc.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com, 
 jan.kiszka@web.de, jjherne@linux.vnet.ibm.com, 
 Joao Martins <joao.m.martins@oracle.com>, Luc Michel <luc@lmichel.fr>,
 mimu@linux.vnet.ibm.com, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/mixed; boundary="0000000000007f67d30614030e0d"
Received-SPF: pass client-ip=2a00:1450:4864:20::14a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x14a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000007f67d30614030e0d
Content-Type: multipart/alternative; boundary="0000000000007f67d10614030e0b"

--0000000000007f67d10614030e0b
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

UUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwNClR1ZXNkYXkgMiBBcHIgMjAyNCDi
i4UgMTQ6MDAg4oCTIDE1OjAwDQpVbml0ZWQgS2luZ2RvbSBUaW1lDQoNCkxvY2F0aW9uDQpodHRw
czovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS91
cmw/cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcmc2E9RCZ1c3Q9
MTcxMTI4NTIwMDAwMDAwMCZ1c2c9QU92VmF3MVpFbDZRNUt4ZVRuZXg4WWJkZ2hZQQ0KDQoNCg0K
QXR0YWNobWVudHMNCk5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2Fs
bCAgDQpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHp4Q2NjZnFm
Tk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCg0KSWYgeW91IG5lZWQgY2FsbCBkZXRh
aWxzLCBwbGVhc2UgY29udGFjdCBtZTogYWxleC5iZW5uZWVAbGluYXJvLm9yZw0KDQpHdWVzdHMN
CmFsZUByZXYubmcNCkFsZXggQmVubsOpZQ0KYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tDQphcm1i
cnVAcmVkaGF0LmNvbQ0KYmNhaW5AcXVpY2luYy5jb20NCmJlcnJhbmdlQHJlZGhhdC5jb20NCmNq
aWFAbnZpZGlhLmNvbQ0KY2xnQGthb2Qub3JnDQpjd0BmMDBmLm9yZw0KZWJsYWtlQHJlZGhhdC5j
b20NCmVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbQ0KZWR1YXJkb0BoYWJrb3N0Lm5ldA0KZmVsaXBl
QG51dGFuaXguY29tDQppZ2d5QHRoZWlnZ3kuY29tDQppbXBAYnNkaW1wLmNvbQ0KamdnQG52aWRp
YS5jb20NCmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KamltLnNodUBzaWZpdmUuY29tDQprb25yYWQu
d2lsa0BvcmFjbGUuY29tDQptYnVydG9uQHF0aS5xdWFsY29tbS5jb20NCm1kZWFuQHJlZGhhdC5j
b20NCnBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbQ0KcGJvbnppbmlAcmVkaGF0LmNvbQ0KUGV0ZXIg
TWF5ZGVsbA0KUmljaGFyZCBIZW5kZXJzb24NCnNoZW50ZXlAZ21haWwuY29tDQpzdGVmYW5oYUBn
bWFpbC5jb20NCndlaS53LndhbmdAaW50ZWwuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KUGhp
bCBNYXRoaWV1LURhdWTDqQ0KZWJsb3RAcml2b3NpbmMuY29tDQptYXguY2hvdUBzaWZpdmUuY29t
DQphZmFlcmJlckBzdXNlLmRlDQpBbnRvbiBKb2hhbnNzb24NCmJiYXVtYW5AcmVkaGF0LmNvbQ0K
Q2hhbyBQZW5nDQpEYW1pZW4gSGVkZGUNCkVsZW5hIFVmaW10c2V2YQ0KZXJpYy5hdWdlckByZWRo
YXQuY29tDQpqYW4ua2lzemthQHdlYi5kZQ0KampoZXJuZUBsaW51eC52bmV0LmlibS5jb20NCkpv
YW8gTWFydGlucw0KTHVjIE1pY2hlbA0KbWltdUBsaW51eC52bmV0LmlibS5jb20NClNoYW1lZXJh
bGkgS29sb3RodW0gVGhvZGkNCnouaHVvQDEzOS5jb20NCkxJVSBaaGl3ZWkNCnFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KVmlldyBhbGwgZ3Vlc3QgaW5mbyAgDQpodHRwczovL2NhbGVuZGFyLmdvb2ds
ZS5jb20vY2FsZW5kYXIvZXZlbnQ/YWN0aW9uPVZJRVcmZWlkPU1XZDJkV0k1TkRNMWJ6ZG9jbkps
YlRCaE1ISmhiRzVzTldsZk1qQXlOREEwTURKVU1UTXdNREF3V2lCeFpXMTFMV1JsZG1Wc1FHNXZi
bWR1ZFM1dmNtYyZ0b2s9TlRRalkxOXJOWEF5YkhCbmRtSndkR1JwY210MU5YTnBNREZpYkcxdWEw
Qm5jbTkxY0M1allXeGxibVJoY2k1bmIyOW5iR1V1WTI5dFpXUXlOakJpTUdZNU1qSm1PV0UzTXpC
aU56RmtPVE5rWkRoak5qVTBNR0UxTlRsa01EVmlOQSZjdHo9RXVyb3BlJTJGTG9uZG9uJmhsPWVu
JmVzPTANCg0KUmVwbHkgZm9yIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyBhbmQgdmlldyBtb3JlIGRl
dGFpbHMgIA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyL2V2ZW50P2FjdGlv
bj1WSUVXJmVpZD1NV2QyZFdJNU5ETTFiemRvY25KbGJUQmhNSEpoYkc1c05XbGZNakF5TkRBME1E
SlVNVE13TURBd1dpQnhaVzExTFdSbGRtVnNRRzV2Ym1kdWRTNXZjbWMmdG9rPU5UUWpZMTlyTlhB
eWJIQm5kbUp3ZEdScGNtdDFOWE5wTURGaWJHMXVhMEJuY205MWNDNWpZV3hsYm1SaGNpNW5iMjlu
YkdVdVkyOXRaV1F5TmpCaU1HWTVNakptT1dFM016QmlOekZrT1ROa1pEaGpOalUwTUdFMU5UbGtN
RFZpTkEmY3R6PUV1cm9wZSUyRkxvbmRvbiZobD1lbiZlcz0wDQpZb3VyIGF0dGVuZGFuY2UgaXMg
b3B0aW9uYWwuDQoNCn5+Ly9+fg0KSW52aXRhdGlvbiBmcm9tIEdvb2dsZSBDYWxlbmRhcjogaHR0
cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyLw0KDQpZb3UgYXJlIHJlY2VpdmluZyB0
aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFyZSBhbiBhdHRlbmRlZSBvbiB0aGUgZXZlbnQuIFRvICAN
CnN0b3AgcmVjZWl2aW5nIGZ1dHVyZSB1cGRhdGVzIGZvciB0aGlzIGV2ZW50LCBkZWNsaW5lIHRo
aXMgZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNvdWxkIGFsbG93IGFueSBy
ZWNpcGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdhbml6ZXIsIGJlIGFkZGVk
IHRvIHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxlc3Mgb2YgIA0KdGhlaXIg
b3duIGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBSU1ZQLg0KDQpMZWFybiBtb3Jl
IGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dlci8zNzEzNSNmb3J3YXJk
aW5nDQo=
--0000000000007f67d10614030e0b
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
  src: url(//fonts.gstatic.com/s/materialiconsextended/v149/kJEjBvgX7BgnkSr=
UwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v137/Gw6kwdfw6UnXLJCcm=
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
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v113/WWXFlimHYg6=
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
ndar" content=3D"1gvub9435o7hrrem0a0ralnl5i_20240402T130000Z"/><span style=
=3D"display: none; font-size: 1px; color: #fff; line-height: 1px; height: 0=
; max-height: 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;" ite=
mprop=3D"name">QEMU/KVM developers conference call</span><meta itemprop=3D"=
url" content=3D"https://calendar.google.com/calendar/event?action=3DVIEW&am=
p;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDA0MDJUMTMwMDAwWiBxZW11LWR=
ldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bn=
cm91cC5jYWxlbmRhci5nb29nbGUuY29tZWQyNjBiMGY5MjJmOWE3MzBiNzFkOTNkZDhjNjU0MGE=
1NTlkMDViNA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0"/><span aria-h=
idden=3D"true"><time itemprop=3D"startDate" datetime=3D"20240402T130000Z"><=
/time><time itemprop=3D"endDate" datetime=3D"20240402T140000Z"></time></spa=
n><div style=3D"display: none; font-size: 1px; color: #fff; line-height: 1p=
x; height: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; overflow: =
hidden;">If you need call details, please contact me: alex.bennee@linaro.or=
g</div><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation" align=3D"center" style=3D"width:100%;" class=3D"body-container"><=
tbody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if mso | IE]><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr=
><td height=3D"16" style=3D"height:16px;"><![endif]--><div style=3D"height:=
16px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr></tab=
le><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
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
e itemprop=3D"startDate" datetime=3D"20240402T130000Z"></time><time itempro=
p=3D"endDate" datetime=3D"20240402T140000Z"></time></span><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"paddi=
ng-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14p=
x;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoot=
hing: antialiased;margin: 0; padding: 0;">When</h2></td></tr></table><span>=
Tuesday 2 Apr 2024 =E2=8B=85 14:00 =E2=80=93 15:00 (United Kingdom Time)</s=
pan></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: =
left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-fami=
ly: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14p=
x; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration=
: none;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-b=
ottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;co=
lor: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing=
: antialiased;margin: 0; padding: 0;">Location</h2></td></tr></table><span =
itemprop=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span =
itemprop=3D"name" class=3D"primary-text notranslate" style=3D"font-family: =
Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; l=
ine-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: no=
ne;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.g=
oogle.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp=
;ust=3D1711285200000000&amp;usg=3DAOvVaw1ZEl6Q5KxeTnex8YbdghYA" class=3D"ac=
cent-text underline-on-hover" style=3D"display: inline-block;;color: #1a73e=
8; text-decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"m=
ap">View map</a></span></div></td></tr><tr><td style=3D"font-size: 0; paddi=
ng: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div=
 style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: =
400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c40=
43; text-decoration: none;" class=3D"primary-text" role=3D"presentation"><t=
able border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"=
 style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D=
"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-we=
bkit-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td></=
tr></table><div style=3D"padding-bottom: 4px; text-align: left;;color: #3c4=
042;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.=
org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prima=
ry-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043;=
 text-decoration: none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><m=
eta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:alex.bennee@linaro.org">Alex Benn=C3=A9e</a>=
</span><meta itemprop=3D"email" content=3D"alex.bennee@linaro.org"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:alistair.francis@wdc.co=
m">alistair.francis@wdc.com</a></span><meta itemprop=3D"email" content=3D"a=
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
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:clg@kaod.org">cl=
g@kaod.org</a></span><meta itemprop=3D"email" content=3D"clg@kaod.org"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.org">cw@f=
00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.com">ebla=
ke@redhat.com</a></span><meta itemprop=3D"email" content=3D"eblake@redhat.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.igles=
ias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email" =
content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</a></span><m=
eta itemprop=3D"email" content=3D"eduardo@habkost.net"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">felipe@nutanix=
.com</a></span><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@theiggy.com"=
>iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"iggy@theigg=
y.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:imp@bsdi=
mp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=3D"imp@bs=
dimp.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jgg@n=
vidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"email" content=3D"jgg=
@nvidia.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:j=
idong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"ema=
il" content=3D"jidong.xiao@gmail.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:jim.shu@sifive.com">jim.shu@sifive.com</a></span><me=
ta itemprop=3D"email" content=3D"jim.shu@sifive.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com">konrad.wilk@o=
racle.com</a></span><meta itemprop=3D"email" content=3D"konrad.wilk@oracle.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mburton@qt=
i.qualcomm.com">mburton@qti.qualcomm.com</a></span><meta itemprop=3D"email"=
 content=3D"mburton@qti.qualcomm.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.com</a></span><meta i=
temprop=3D"email" content=3D"mdean@redhat.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:paul.walmsley@sifive.com">paul.walmsley@sif=
ive.com</a></span><meta itemprop=3D"email" content=3D"paul.walmsley@sifive.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:pbonzini@r=
edhat.com">pbonzini@redhat.com</a></span><meta itemprop=3D"email" content=
=3D"pbonzini@redhat.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></span><meta itemprop=
=3D"email" content=3D"peter.maydell@linaro.org"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Per=
son"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text=
 underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-d=
ecoration: none;" href=3D"mailto:richard.henderson@linaro.org">Richard Hend=
erson</a></span><meta itemprop=3D"email" content=3D"richard.henderson@linar=
o.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:shentey@=
gmail.com">shentey@gmail.com</a></span><meta itemprop=3D"email" content=3D"=
shentey@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:stefanha@gmail.com">stefanha@gmail.com</a></span><meta itemprop=3D"emai=
l" content=3D"stefanha@gmail.com"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span><me=
ta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@g=
mail.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:philmd@linaro=
.org">Phil Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D=
"philmd@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:eblot@rivosinc.com">eblot@rivosinc.com</a></span><meta itemprop=3D"e=
mail" content=3D"eblot@rivosinc.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:max.chou@sifive.com">max.chou@sifive.com</a></span><m=
eta itemprop=3D"email" content=3D"max.chou@sifive.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.de=
</a></span><meta itemprop=3D"email" content=3D"afaerber@suse.de"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:anjo@rev.ng">Anton Johans=
son</a></span><meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:bbauman@redhat.com">bbauma=
n@redhat.com</a></span><meta itemprop=3D"email" content=3D"bbauman@redhat.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:chao.p.peng=
@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"email" content=3D"c=
hao.p.peng@linux.intel.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:dhedde@kalrayinc.com">Damien Hedde</a></span><meta itemprop=
=3D"email" content=3D"dhedde@kalrayinc.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a=
></span><meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></=
span><span class=3D"secondary-text" style=3D"color: #70757a; text-decoratio=
n: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@redhat=
.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" content=3D"e=
ric.auger@redhat.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"ema=
il" content=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</=
a></span><meta itemprop=3D"email" content=3D"jjherne@linux.vnet.ibm.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.martins@or=
acle.com">Joao Martins</a></span><meta itemprop=3D"email" content=3D"joao.m=
.martins@oracle.com"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:luc@lmichel.fr">Luc Michel</a></span><meta itemprop=3D"email" conten=
t=3D"luc@lmichel.fr"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta ite=
mprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"=
secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></d=
iv><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org=
/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-=
text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; te=
xt-decoration: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei.com">=
Shameerali Kolothum Thodi</a></span><meta itemprop=3D"email" content=3D"sha=
meerali.kolothum.thodi@huawei.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=
=3D"email" content=3D"z.huo@139.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhiwei</a></span><m=
eta itemprop=3D"email" content=3D"zhiwei_liu@linux.alibaba.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qem=
u-devel@nongnu.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel=
@nongnu.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div></div><a href=3D"https://calendar.go=
ogle.com/calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJ=
hbG5sNWlfMjAyNDA0MDJUMTMwMDAwWiBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQj=
Y19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZWQ=
yNjBiMGY5MjJmOWE3MzBiNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;ctz=3DEurope%2FLond=
on&amp;hl=3Den&amp;es=3D0" style=3D"display: inline-block;;color: #1a73e8; =
text-decoration: none;font-weight: 700;" target=3D"_blank" class=3D"accent-=
text underline-on-hover">View all guest info</a></div></td></tr><tr><td sty=
le=3D"font-size: 0; padding: 0; text-align: left; word-break: break-word;;p=
adding-bottom:0px;"><div style=3D"color: #3c4043; text-decoration: none;;fo=
nt-family: Roboto, sans-serif;font-size: 14px; line-height: 20px; mso-line-=
height-rule: exactly; text-align: left;" class=3D"primary-text"><div><span =
style=3D"font-weight: 700;-webkit-font-smoothing: antialiased;">Reply</span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"> for <a class=3D"secondary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #70757a; text-decoration: none;" href=3D"mailto:qemu-=
devel@nongnu.org">qemu-devel@nongnu.org</a></span></div></div></td></tr><tr=
><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: break=
-word;;padding-bottom:16px;"><div style=3D"font-family: Roboto, sans-serif;=
font-size: 14px; line-height: 20px; mso-line-height-rule: exactly; text-ali=
gn: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"=
presentation" style=3D"border-collapse: separate;"><tr><td style=3D"padding=
-top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP buttons --><tab=
le border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" s=
tyle=3D"border: solid 1px #dadce0; border-radius: 16px; border-collapse: se=
parate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;;display: inl=
ine-block;;margin-right: 12px; margin-left: 0;"><tr><td align=3D"center" ve=
rtical-align=3D"middle" role=3D"presentation"><span itemprop=3D"potentialac=
tion" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D=
"attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><span itempr=
op=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHandler"><=
link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"/>=
<span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/cale=
ndar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfM=
jAyNDA0MDJUMTMwMDAwWiBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=3DNT=
QjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZ=
WQyNjBiMGY5MjJmOWE3MzBiNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;ctz=3DEurope%2FLo=
ndon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;Go=
ogle Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-he=
ight: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none=
; text-transform: none;" class=3D"grey-button-text" itemprop=3D"url" target=
=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D=
"presentation"><tr><td align=3D"center" role=3D"presentation" valign=3D"mid=
dle" style=3D"padding: 6px 0; padding-left: 16px; padding-right: 12px; whit=
e-space: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calen=
dar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMj=
AyNDA0MDJUMTMwMDAwWiBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&amp;tok=3DNTQ=
jY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZW=
QyNjBiMGY5MjJmOWE3MzBiNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;ctz=3DEurope%2FLon=
don&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" tar=
get=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D"font-w=
eight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5=
f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; m=
argin: 0; text-decoration: none; text-transform: none;">Yes</span><!--[if m=
so]></a><![endif]--></td></tr></table></a></span></span></span></td><td ali=
gn=3D"center" vertical-align=3D"middle" role=3D"presentation" style=3D"bord=
er-left: solid 1px #dadce0; border-right: solid 1px #dadce0;"><span itempro=
p=3D"potentialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><=
meta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/No=
"/><span itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpA=
ctionHandler"><link itemprop=3D"method" href=3D"http://schema.org/HttpReque=
stMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.=
google.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbT=
BhMHJhbG5sNWlfMjAyNDA0MDJUMTMwMDAwWiBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=
=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRh=
ci5nb29nbGUuY29tZWQyNjBiMGY5MjJmOWE3MzBiNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;=
ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;fon=
t-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-si=
ze: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text=
-decoration: none; text-transform: none;" class=3D"grey-button-text" itempr=
op=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"presentati=
on" valign=3D"middle" style=3D"padding: 6px 12px; white-space: nowrap;"><!-=
-[if mso]><a href=3D"https://calendar.google.com/calendar/event?action=3DRE=
SPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDA0MDJUMTMwMDAwWiB=
xZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRp=
cmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZWQyNjBiMGY5MjJmOWE3MzB=
iNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;e=
s=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_blank"><![end=
if]--><span class=3D"grey-button-text" style=3D"font-weight: 400;font-famil=
y: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14p=
x; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decora=
tion: none; text-transform: none;">No</span><!--[if mso]></a><![endif]--></=
td></tr></table></a></span></span></span></td><td align=3D"center" vertical=
-align=3D"middle" role=3D"presentation"><span itemprop=3D"potentialaction" =
itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itemprop=3D"atten=
dance" content=3D"http://schema.org/RsvpAttendance/Maybe"/><span itemprop=
=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHandler"><li=
nk itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod/GET"/><s=
pan style=3D"color: #5f6367;"><a href=3D"https://calendar.google.com/calend=
ar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjA=
yNDA0MDJUMTMwMDAwWiBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;tok=3DNTQj=
Y19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZWQ=
yNjBiMGY5MjJmOWE3MzBiNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;ctz=3DEurope%2FLond=
on&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: &#39;Goog=
le Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-heig=
ht: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: none; =
text-transform: none;" class=3D"grey-button-text" itemprop=3D"url" target=
=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D=
"presentation"><tr><td align=3D"center" role=3D"presentation" valign=3D"mid=
dle" style=3D"padding: 6px 0; padding-left: 12px; padding-right: 16px; whit=
e-space: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calen=
dar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMj=
AyNDA0MDJUMTMwMDAwWiBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;tok=3DNTQ=
jY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZW=
QyNjBiMGY5MjJmOWE3MzBiNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;ctz=3DEurope%2FLon=
don&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" tar=
get=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D"font-w=
eight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5=
f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; m=
argin: 0; text-decoration: none; text-transform: none;">Maybe</span><!--[if=
 mso]></a><![endif]--></td></tr></table></a></span></span></span></td></tr>=
</table><!-- More options --><a href=3D"https://calendar.google.com/calenda=
r/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDA=
0MDJUMTMwMDAwWiBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndmJw=
dGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZWQyNjBiMGY5MjJmOWE=
3MzBiNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&a=
mp;es=3D0" style=3D"display: inline-block;;font-weight: 400;font-family: &#=
39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; li=
ne-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration:=
 none; text-transform: none;" class=3D"grey-button-text" target=3D"_blank">=
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentatio=
n" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-collapse=
: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;"><tr><td=
 align=3D"center" vertical-align=3D"middle" role=3D"presentation" style=3D"=
padding: 6px 0; padding-left: 16px; padding-right: 12px; white-space: nowra=
p;;color: #5f6367;"><!--[if mso]><a href=3D"https://calendar.google.com/cal=
endar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjA=
yNDA0MDJUMTMwMDAwWiBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBn=
dmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tZWQyNjBiMGY5MjJ=
mOWE3MzBiNzFkOTNkZDhjNjU0MGE1NTlkMDViNA&amp;ctz=3DEurope%2FLondon&amp;hl=3D=
en&amp;es=3D0" class=3D"grey-button-text" target=3D"_blank"><![endif]--><sp=
an class=3D"grey-button-text" style=3D"font-weight: 400;font-family: &#39;G=
oogle Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; line-h=
eight: 120%; mso-line-height-rule: exactly; margin: 0; text-decoration: non=
e; text-transform: none;">More options</span><!--[if mso]></a><![endif]--><=
/td></tr></table></a></td></tr></table></div></td></tr></table></td></tr></=
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
ving this email because you are an attendee on the event. To stop receiving=
 future updates for this event, decline this event.</p><p>Forwarding this i=
nvitation could allow any recipient to send a response to the organizer, be=
 added to the guest list, invite others regardless of their own invitation =
status, or modify your RSVP. <a class=3D"accent-text underline-on-hover" st=
yle=3D"font-family: Roboto, sans-serif;font-size: 12px; line-height: 16px; =
mso-line-height-rule: exactly;;color: #1a73e8; text-decoration: none;" href=
=3D"https://support.google.com/calendar/answer/37135#forwarding">Learn more=
</a></p></div></td></tr></tbody></table></td></tr></tbody></table></span></=
span></body></html>
--0000000000007f67d10614030e0b
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
DTSTART;TZID=3DAmerica/New_York:20240402T090000
DTEND;TZID=3DAmerica/New_York:20240402T100000
DTSTAMP:20240319T130020Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20240319T130000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dale@rev.ng;X-NUM-GUESTS=3D0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;RSV=
P=3DTRUE
 ;X-NUM-GUESTS=3D0;X-RESPONSE-COMMENT=3D"Declined because I am out of offic=
e. Pl
 ease see Viresh for Orko questions and Richard/Peter for QEMU ones.":mailt=
o
 :alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dalistair.francis@wdc.com;X-NUM-GUESTS=3D0:mailto:alistair.franci=
s@wdc
 .com
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
 TRUE;CN=3Dclg@kaod.org;X-NUM-GUESTS=3D0:mailto:clg@kaod.org
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
 TRUE;CN=3Dkonrad.wilk@oracle.com;X-NUM-GUESTS=3D0:mailto:konrad.wilk@oracl=
e.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmburton@qti.qualcomm.com;X-NUM-GUESTS=3D0:mailto:mburton@qti.qua=
lcomm
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dshentey@gmail.com;X-NUM-GUESTS=3D0:mailto:shentey@gmail.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dafaerber@suse.de;X-NUM-GUESTS=3D0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAnton Johansson;X-NUM-GUESTS=3D0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbbauman@redhat.com;X-NUM-GUESTS=3D0:mailto:bbauman@redhat.com
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
 TRUE;CN=3Djjherne@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:jjherne@linux=
.vnet
 .ibm.com
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
X-MICROSOFT-CDO-OWNERAPPTID:-96164369
RECURRENCE-ID;TZID=3DAmerica/New_York:20240402T090000
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20240319T130004Z
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

--0000000000007f67d10614030e0b--

--0000000000007f67d30614030e0d
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
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjQwNDAyVDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjQwNDAyVDEwMDAwMA0KRFRTVEFNUDoyMDI0MDMxOVQxMzAwMjBaDQpP
UkdBTklaRVI7Q049UUVNVSBQcm9qZWN0IENhbGVuZGFyOm1haWx0bzpjX2s1cDJscGd2YnB0ZGly
a3U1c2kwMWJsbW5rQGdyb3UNCiBwLmNhbGVuZGFyLmdvb2dsZS5jb20NClVJRDoxZ3Z1Yjk0MzVv
N2hycmVtMGEwcmFsbmw1aV9SMjAyNDAzMTlUMTMwMDAwQGdvb2dsZS5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049YWxlQHJldi5uZztYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxlQHJl
di5uZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9REVDTElORUQ7UlNWUD1UUlVFDQogO1gtTlVNLUdVRVNUUz0wO1gtUkVTUE9OU0UtQ09N
TUVOVD0iRGVjbGluZWQgYmVjYXVzZSBJIGFtIG91dCBvZiBvZmZpY2UuIFBsDQogZWFzZSBzZWUg
VmlyZXNoIGZvciBPcmtvIHF1ZXN0aW9ucyBhbmQgUmljaGFyZC9QZXRlciBmb3IgUUVNVSBvbmVz
LiI6bWFpbHRvDQogOmFsZXguYmVubmVlQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzph
bGlzdGFpci5mcmFuY2lzQHdkYw0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
YXJtYnJ1QHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFybWJydUByZWRoYXQuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWJjYWluQHF1aWNpbmMuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzpiY2FpbkBxdWljaW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1iZXJyYW5nZUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpiZXJyYW5nZUBy
ZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWNqaWFAbnZpZGlhLmNvbTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86Y2ppYUBudmlkaWEuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPWNsZ0BrYW9kLm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2xnQGthb2Qub3Jn
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWN3QGYwMGYub3JnO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpjd0BmMDBmLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lYmxha2VA
cmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWJsYWtlQHJlZGhhdC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzplZGdhci5pZ2xlc2lhc0BnbWFpbA0KIC5jb20NCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQ
PVRSVQ0KIEU7Q049ZWR1YXJkb0BoYWJrb3N0Lm5ldDtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWR1
YXJkb0BoYWJrb3N0Lm5ldA0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1mZWxpcGVAbnV0
YW5peC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmZlbGlwZUBudXRhbml4LmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO1JTVlA9DQogVFJVRTtDTj1pZ2d5QHRoZWlnZ3kuY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzppZ2d5QHRoZWlnZ3kuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWltcEBi
c2RpbXAuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzppbXBAYnNkaW1wLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1qZ2dAbnZpZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
amdnQG52aWRpYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amlkb25nLnhpYW9A
Z21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqaWRvbmcueGlhb0BnbWFpbC5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amltLnNodUBzaWZpdmUuY29tO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpqaW0uc2h1QHNpZml2ZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049a29ucmFkLndpbGtAb3JhY2xlLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86a29ucmFkLndp
bGtAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYnVydG9uQHF0aS5x
dWFsY29tbS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1idXJ0b25AcXRpLnF1YWxjb21tDQog
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9QUNDRVBURUQ7UlNWUD1UUlVFDQogO0NOPW1kZWFuQHJlZGhhdC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOm1kZWFuQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049
cGF1bC53YWxtc2xleUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYXVsLndhbG1z
bGV5QHNpZml2ZS5jbw0KIG0NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGJvbnppbmlA
cmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1QZXRlciBNYXlkZWxsO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049UmljaGFyZCBIZW5kZXJzb247WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcg0KIGcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049c2hlbnRleUBn
bWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnNoZW50ZXlAZ21haWwuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJ
VkU7UlNWUD1UUlUNCiBFO0NOPXN0ZWZhbmhhQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWls
dG86c3RlZmFuaGFAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXdlaS53
LndhbmdAaW50ZWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp3ZWkudy53YW5nQGludGVsLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj16d3Uua2VybmVsQGdtYWlsLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86end1Lmtlcm5lbEBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBoaWxtZEBsaW5hcm8ub3JnDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJ
VkU7UlNWUD1UUlUNCiBFO0NOPWVibG90QHJpdm9zaW5jLmNvbTtYLU5VTS1HVUVTVFM9MDptYWls
dG86ZWJsb3RAcml2b3NpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1heC5j
aG91QHNpZml2ZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1heC5jaG91QHNpZml2ZS5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YWZhZXJiZXJAc3VzZS5kZTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86YWZhZXJiZXJAc3VzZS5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1BbnRvbiBKb2hhbnNzb247WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFuam9AcmV2Lm5nDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWJiYXVtYW5AcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86YmJhdW1hbkByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PUNoYW8gUGVuZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50ZWwu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049RGFtaWVuIEhlZGRlO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpkaGVkZGVAa2FscmF5aW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1FbGVuYSBVZmltdHNldmE7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVsZW5hLnVmaW10c2V2YUBv
cmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVyaWMuYXVnZXJAcmVkaGF0
LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPWphbi5raXN6a2FAd2ViLmRlO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpqYW4ua2lzemthQHdlYi5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qamhl
cm5lQGxpbnV4LnZuZXQuaWJtLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ampoZXJuZUBsaW51
eC52bmV0DQogLmlibS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0
aW5zO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUx1YyBNaWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFpbHRv
Omx1Y0BsbWljaGVsLmZyDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1pbXVAbGludXgu
dm5ldC5pYm0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptaW11QGxpbnV4LnZuZXQuaWJtLmMN
CiBvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1TaGFtZWVyYWxpIEtvbG90aHVtIFRo
b2RpO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzaGFtZWVyYWxpLmtvbG90aHVtDQogLnRob2RpQGh1
YXdlaS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ei5odW9AMTM5LmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86ei5odW9AMTM5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1MSVUgWmhpd2VpO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6aGl3ZWlfbGl1QGxpbnV4LmFs
aWJhYmEuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXFlbXUtZGV2ZWxAbm9uZ251
Lm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpYLU1JQ1JP
U09GVC1DRE8tT1dORVJBUFBUSUQ6LTk2MTY0MzY5DQpSRUNVUlJFTkNFLUlEO1RaSUQ9QW1lcmlj
YS9OZXdfWW9yazoyMDI0MDQwMlQwOTAwMDANCkNSRUFURUQ6MjAyMzAyMjFUMTUzOTUwWg0KREVT
Q1JJUFRJT046SWYgeW91IG5lZWQgY2FsbCBkZXRhaWxzXCwgcGxlYXNlIGNvbnRhY3QgbWU6IDxh
IGhyZWY9Im1haWx0bzpxDQogdWludGVsYUByZWRoYXQuY29tIj5hbGV4LmJlbm5lZUBsaW5hcm8u
b3JnPC9hPg0KTEFTVC1NT0RJRklFRDoyMDI0MDMxOVQxMzAwMDRaDQpMT0NBVElPTjpodHRwczov
L21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nDQpTRVFVRU5DRTowDQpTVEFUVVM6Q09ORklSTUVE
DQpTVU1NQVJZOlFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsDQpUUkFOU1A6T1BB
UVVFDQpBVFRBQ0g7RklMRU5BTUU9Tm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVy
ZW5jZSBjYWxsO0ZNVFRZUEU9YXBwbGljYQ0KIHRpb24vdm5kLmdvb2dsZS1hcHBzLmRvY3VtZW50
Omh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxMeg0KIHhDY2NmcWZO
TktjTUc3NEhNVUpmNkRVUm1TSkJHUVpyZWsvZWRpdA0KQkVHSU46VkFMQVJNDQpBQ1RJT046RU1B
SUwNCkRFU0NSSVBUSU9OOlRoaXMgaXMgYW4gZXZlbnQgcmVtaW5kZXINClNVTU1BUlk6QWxhcm0g
bm90aWZpY2F0aW9uDQpBVFRFTkRFRTptYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpUUklH
R0VSOi1QMkQNCkVORDpWQUxBUk0NCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--0000000000007f67d30614030e0d--

