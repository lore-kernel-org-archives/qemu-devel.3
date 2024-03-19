Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772BBC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZ4x-0002wt-Ba; Tue, 19 Mar 2024 09:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmZ4p-0002vF-Qn
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:00:23 -0400
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmZ4l-00044l-Uv
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:00:22 -0400
Received: by mail-ed1-x54a.google.com with SMTP id
 4fb4d7f45d1cf-564fec337b1so6107236a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710853218; x=1711458018; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ygs/Zj+8fXZd3UiT3eWVLSgwpaQepvFUwBMd+RXvnmg=;
 b=2PaJTiP4mgWBpb3hKj9w7XHg3IhYXS54turungJJ6rSIDYcoAvW5mG0Bnd5i+QfD88
 TSoxcIoZoQa7bb0IWP1W5ttYbIXX4eJjk82hmvdlq+t6otufMg+hjowBiIxo3/d8D/jH
 kw1DnqsVOCO+4idQ65Xiw5V+J+35T7+5HD9YAVbMk9KoeTJ9LQvLd+ZcwsbdB5pBxi5x
 AA8agMeUDzQ20gb7/PiIlW4y/7XM//s1XukuOZEFfBRO/wUd2oBUzh3fAGLDHryWqLrD
 g4tbfAkekVBkCItdKHs7rmvitodnN2++jvScdHLggAQbJ9LTAkKboiJnEqBjgoTnYLRQ
 2t4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853218; x=1711458018; darn=nongnu.org;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ygs/Zj+8fXZd3UiT3eWVLSgwpaQepvFUwBMd+RXvnmg=;
 b=dtD9FF9Bic7voWHsW9ag081CMIfRCVyUwb7eFEh2A7Ndm0k36RE384cpYUTLrugdR5
 pskzhEUXcJoEYkvZGIyRpxZkJ0diqZR9Mn2hik/kc281pKOc+4y0T1HYqf4HGoUnBCtw
 R1r/q63BV2BCtBmcg4ShXYb9UkZXtigluY7ugB5+5ysPwP2Uu46jaVXoysHYb13f8o7K
 Q/UWQAastNiUDgew1D7yuVC7jDT61IN0kBnc/cwhsFvtoUJ+TwMGnamULBR5CCYknddR
 G9Gtn8Q72VlVFCuhMqe5TowxPlG4D1YmXqVvv3eouZMcPlwrhXGt+P/DkDUh5BgYMVEL
 Zb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853218; x=1711458018;
 h=to:from:subject:date:message-id:sender:reply-to:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ygs/Zj+8fXZd3UiT3eWVLSgwpaQepvFUwBMd+RXvnmg=;
 b=voduBbI3e5H2+jMq5eKI8RrvY6a3w6/ZxzbMlxAxo37dn3UN5O1ILDxHxSQyiB3A9n
 LeXx7WIqEJulEut8GLmm+zT4O19jXTsOA/XK37BTukdgDXeep0cGJxVXqsHkQXUWr0j8
 vZFn9GjUzgqfWaNOub8uvkJU+d8o8Hk9vehTscwSafY6rQ5Bx3JkbT9Veg01Cy9yjAKL
 srB4NNa17iMrKWE8JftMREsh1pwFZRf7/mosjhe+UiyErOiufIaGeaqoj46nJmRlSboT
 pASn1yA4ltD7lkYbkxBebVZbJoly+ql0ji6q0VrBDenyb89oNSXG6bKc5aCZudYy8yL3
 AxZg==
X-Gm-Message-State: AOJu0YzPYc7848mrEtD/U641/Uq4EB8wA76pR1JVE2XrEqejdCEdwTV+
 kjN40iwp6d2AQRb5WHSViCxZsA0RVjS29cYrQgX8IatLgW93ElzrzJtCTMHxa9bCdI5CPsHcYC4
 G+af7wAWFK2VGeNEb5VjD7rGba38MvUcwGN6zjKlEYG65/bOr2A==
X-Google-Smtp-Source: AGHT+IGAvyVdBkNW5P7Q0aHjiLDT+GOnI8K84WG2vNvPOzXvrMFUPTIYNrmqYja72EmIjjYQP194aEH1U/xuLtIHVYwo
MIME-Version: 1.0
X-Received: by 2002:a50:9309:0:b0:568:d31e:4f94 with SMTP id
 m9-20020a509309000000b00568d31e4f94mr2308569eda.9.1710853218336; Tue, 19 Mar
 2024 06:00:18 -0700 (PDT)
Message-ID: <calendar-3b29090f-e611-4001-9e6f-ea7b8a37107e@google.com>
Date: Tue, 19 Mar 2024 13:00:18 +0000
Subject: Invitation: QEMU/KVM developers conference call @ Every 2 weeks from
 13:00 to 14:00 on Tuesday (GMT) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, afaerber@suse.de, ale@rev.ng, 
 alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>, armbru@redhat.com, 
 bbauman@redhat.com, bcain@quicinc.com, berrange@redhat.com, 
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com, clg@kaod.org,
 cw@f00f.org, Damien Hedde <dhedde@kalrayinc.com>, eblake@redhat.com,
 edgar.iglesias@gmail.com, 
 eduardo@habkost.net, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 eric.auger@redhat.com, 
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, jan.kiszka@web.de, 
 jgg@nvidia.com, jidong.xiao@gmail.com, jim.shu@sifive.com, 
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>, 
 konrad.wilk@oracle.com, Luc Michel <luc@lmichel.fr>, mburton@qti.qualcomm.com, 
 mdean@redhat.com, mimu@linux.vnet.ibm.com, paul.walmsley@sifive.com, 
 pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, 
 stefanha@gmail.com, wei.w.wang@intel.com, z.huo@139.com, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, eblot@rivosinc.com, 
 max.chou@sifive.com
Content-Type: multipart/mixed; boundary="00000000000057a51c0614030e91"
Received-SPF: pass client-ip=2a00:1450:4864:20::54a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x54a.google.com
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

--00000000000057a51c0614030e91
Content-Type: multipart/alternative; boundary="00000000000057a5190614030e8f"

--00000000000057a5190614030e8f
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

UUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwNCkV2ZXJ5IDIgd2Vla3MgZnJvbSAx
MzowMCB0byAxNDowMCBvbiBUdWVzZGF5DQpVbml0ZWQgS2luZ2RvbSBUaW1lDQoNCkxvY2F0aW9u
DQpodHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29vZ2xl
LmNvbS91cmw/cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcmc2E9
RCZ1c3Q9MTcxMTI4NTIwMDAwMDAwMCZ1c2c9QU92VmF3MVpFbDZRNUt4ZVRuZXg4WWJkZ2hZQQ0K
DQoNCg0KQXR0YWNobWVudHMNCk5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVu
Y2UgY2FsbCAgDQpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHp4
Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCg0KSWYgeW91IG5lZWQgY2Fs
bCBkZXRhaWxzLCBwbGVhc2UgY29udGFjdCBtZTogYWxleC5iZW5uZWVAbGluYXJvLm9yZw0KDQpH
dWVzdHMNCmFmYWVyYmVyQHN1c2UuZGUNCmFsZUByZXYubmcNCkFsZXggQmVubsOpZQ0KYWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tDQpBbnRvbiBKb2hhbnNzb24NCmFybWJydUByZWRoYXQuY29tDQpi
YmF1bWFuQHJlZGhhdC5jb20NCmJjYWluQHF1aWNpbmMuY29tDQpiZXJyYW5nZUByZWRoYXQuY29t
DQpDaGFvIFBlbmcNCmNqaWFAbnZpZGlhLmNvbQ0KY2xnQGthb2Qub3JnDQpjd0BmMDBmLm9yZw0K
RGFtaWVuIEhlZGRlDQplYmxha2VAcmVkaGF0LmNvbQ0KZWRnYXIuaWdsZXNpYXNAZ21haWwuY29t
DQplZHVhcmRvQGhhYmtvc3QubmV0DQpFbGVuYSBVZmltdHNldmENCmVyaWMuYXVnZXJAcmVkaGF0
LmNvbQ0KZmVsaXBlQG51dGFuaXguY29tDQppZ2d5QHRoZWlnZ3kuY29tDQppbXBAYnNkaW1wLmNv
bQ0KamFuLmtpc3prYUB3ZWIuZGUNCmpnZ0BudmlkaWEuY29tDQpqaWRvbmcueGlhb0BnbWFpbC5j
b20NCmppbS5zaHVAc2lmaXZlLmNvbQ0KampoZXJuZUBsaW51eC52bmV0LmlibS5jb20NCkpvYW8g
TWFydGlucw0Ka29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KTHVjIE1pY2hlbA0KbWJ1cnRvbkBxdGku
cXVhbGNvbW0uY29tDQptZGVhbkByZWRoYXQuY29tDQptaW11QGxpbnV4LnZuZXQuaWJtLmNvbQ0K
cGF1bC53YWxtc2xleUBzaWZpdmUuY29tDQpwYm9uemluaUByZWRoYXQuY29tDQpQZXRlciBNYXlk
ZWxsDQpSaWNoYXJkIEhlbmRlcnNvbg0KU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0Kc2hlbnRl
eUBnbWFpbC5jb20NCnN0ZWZhbmhhQGdtYWlsLmNvbQ0Kd2VpLncud2FuZ0BpbnRlbC5jb20NCnou
aHVvQDEzOS5jb20NCkxJVSBaaGl3ZWkNCnp3dS5rZXJuZWxAZ21haWwuY29tDQpQaGlsIE1hdGhp
ZXUtRGF1ZMOpDQplYmxvdEByaXZvc2luYy5jb20NCm1heC5jaG91QHNpZml2ZS5jb20NCnFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0KVmlldyBhbGwgZ3Vlc3QgaW5mbyAgDQpodHRwczovL2NhbGVuZGFy
Lmdvb2dsZS5jb20vY2FsZW5kYXIvZXZlbnQ/YWN0aW9uPVZJRVcmZWlkPU1XZDJkV0k1TkRNMWJ6
ZG9jbkpsYlRCaE1ISmhiRzVzTldsZlVqSXdNalF3TXpFNVZERXpNREF3TUNCeFpXMTFMV1JsZG1W
c1FHNXZibWR1ZFM1dmNtYyZ0b2s9TlRRalkxOXJOWEF5YkhCbmRtSndkR1JwY210MU5YTnBNREZp
YkcxdWEwQm5jbTkxY0M1allXeGxibVJoY2k1bmIyOW5iR1V1WTI5dFlURXpNVEZpWXpRd09ETTVa
VEZrWlRabVl6SXlOMk0xTURJMVkyTmtPVGN6WkRWaFpETmpNZyZjdHo9RXVyb3BlJTJGTG9uZG9u
JmhsPWVuJmVzPTANCg0KUmVwbHkgZm9yIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyBhbmQgdmlldyBt
b3JlIGRldGFpbHMgIA0KaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyL2V2ZW50
P2FjdGlvbj1WSUVXJmVpZD1NV2QyZFdJNU5ETTFiemRvY25KbGJUQmhNSEpoYkc1c05XbGZVakl3
TWpRd016RTVWREV6TURBd01DQnhaVzExTFdSbGRtVnNRRzV2Ym1kdWRTNXZjbWMmdG9rPU5UUWpZ
MTlyTlhBeWJIQm5kbUp3ZEdScGNtdDFOWE5wTURGaWJHMXVhMEJuY205MWNDNWpZV3hsYm1SaGNp
NW5iMjluYkdVdVkyOXRZVEV6TVRGaVl6UXdPRE01WlRGa1pUWm1Zekl5TjJNMU1ESTFZMk5rT1Rj
elpEVmhaRE5qTWcmY3R6PUV1cm9wZSUyRkxvbmRvbiZobD1lbiZlcz0wDQpZb3VyIGF0dGVuZGFu
Y2UgaXMgb3B0aW9uYWwuDQoNCn5+Ly9+fg0KSW52aXRhdGlvbiBmcm9tIEdvb2dsZSBDYWxlbmRh
cjogaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29tL2NhbGVuZGFyLw0KDQpZb3UgYXJlIHJlY2Vp
dmluZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFyZSBhbiBhdHRlbmRlZSBvbiB0aGUgZXZlbnQu
IFRvICANCnN0b3AgcmVjZWl2aW5nIGZ1dHVyZSB1cGRhdGVzIGZvciB0aGlzIGV2ZW50LCBkZWNs
aW5lIHRoaXMgZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9uIGNvdWxkIGFsbG93
IGFueSByZWNpcGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBvcmdhbml6ZXIsIGJl
IGFkZGVkIHRvIHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2FyZGxlc3Mgb2YgIA0K
dGhlaXIgb3duIGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBSU1ZQLg0KDQpMZWFy
biBtb3JlIGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fuc3dlci8zNzEzNSNm
b3J3YXJkaW5nDQo=
--00000000000057a5190614030e8f
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
ndar" content=3D"1gvub9435o7hrrem0a0ralnl5i_R20240319T130000"/><span style=
=3D"display: none; font-size: 1px; color: #fff; line-height: 1px; height: 0=
; max-height: 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;" ite=
mprop=3D"name">QEMU/KVM developers conference call</span><meta itemprop=3D"=
url" content=3D"https://calendar.google.com/calendar/event?action=3DVIEW&am=
p;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWR=
ldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bn=
cm91cC5jYWxlbmRhci5nb29nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTc=
zZDVhZDNjMg&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0"/><span aria-h=
idden=3D"true"><time itemprop=3D"startDate" datetime=3D"20240319T130000Z"><=
/time><time itemprop=3D"endDate" datetime=3D"20240319T140000Z"></time></spa=
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
e itemprop=3D"startDate" datetime=3D"20240319T130000Z"></time><time itempro=
p=3D"endDate" datetime=3D"20240319T140000Z"></time></span><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"paddi=
ng-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14p=
x;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoot=
hing: antialiased;margin: 0; padding: 0;">When</h2></td></tr></table><span>=
Every 2 weeks from 13:00 to 14:00 on Tuesday (United Kingdom Time)</span></=
div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; =
word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Ro=
boto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; lin=
e-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none=
;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpad=
ding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom:=
 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #=
3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: anti=
aliased;margin: 0; padding: 0;">Location</h2></td></tr></table><span itempr=
op=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span itempr=
op=3D"name" class=3D"primary-text notranslate" style=3D"font-family: Roboto=
, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-he=
ight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">h=
ttps://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.=
com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=
=3D1711285200000000&amp;usg=3DAOvVaw1ZEl6Q5KxeTnex8YbdghYA" class=3D"accent=
-text underline-on-hover" style=3D"display: inline-block;;color: #1a73e8; t=
ext-decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"map">=
View map</a></span></div></td></tr><tr><td style=3D"font-size: 0; padding: =
0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div sty=
le=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400;=
 font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; =
text-decoration: none;" class=3D"primary-text" role=3D"presentation"><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" sty=
le=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"fon=
t-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit=
-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td></tr><=
/table><div style=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;=
"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.de</a><=
/span><meta itemprop=3D"email" content=3D"afaerber@suse.de"/></span><span c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></=
span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sc=
hema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"=
primary-text underline-on-hover" style=3D"display: inline-block;;color: #3c=
4043; text-decoration: none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></sp=
an><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:alex.bennee@linaro.org">Alex Benn=C3=A9=
e</a></span><meta itemprop=3D"email" content=3D"alex.bennee@linaro.org"/></=
span><span class=3D"secondary-text" style=3D"color: #70757a; text-decoratio=
n: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:alistair.francis@=
wdc.com">alistair.francis@wdc.com</a></span><meta itemprop=3D"email" conten=
t=3D"alistair.francis@wdc.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:anjo@rev.ng">Anton Johansson</a></span><meta itemprop=3D"em=
ail" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a></span><meta itempr=
op=3D"email" content=3D"armbru@redhat.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:bbauman@redhat.com">bbauman@redhat.com</a></spa=
n><meta itemprop=3D"email" content=3D"bbauman@redhat.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:bcain@quicinc.com">bcain@quicinc=
.com</a></span><meta itemprop=3D"email" content=3D"bcain@quicinc.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a></span><meta itemprop=3D"email" content=3D"berrange=
@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:c=
hao.p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"email" co=
ntent=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:cjia@nvidia.com">cjia@nvidia.com</a></span><meta ite=
mprop=3D"email" content=3D"cjia@nvidia.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:clg@kaod.org">clg@kaod.org</a></span><meta ite=
mprop=3D"email" content=3D"clg@kaod.org"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></span><meta itemprop=
=3D"email" content=3D"cw@f00f.org"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:dhedde@kalrayinc.com">Damien Hedde</a></span><meta item=
prop=3D"email" content=3D"dhedde@kalrayinc.com"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Per=
son"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text=
 underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-d=
ecoration: none;" href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a></=
span><meta itemprop=3D"email" content=3D"eblake@redhat.com"/></span><span c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></=
span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sc=
hema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"=
primary-text underline-on-hover" style=3D"display: inline-block;;color: #3c=
4043; text-decoration: none;" href=3D"mailto:edgar.iglesias@gmail.com">edga=
r.iglesias@gmail.com</a></span><meta itemprop=3D"email" content=3D"edgar.ig=
lesias@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:eduardo@habkost.net">eduardo@habkost.net</a></span><meta itemprop=3D"ema=
il" content=3D"eduardo@habkost.net"/></span><span class=3D"secondary-text" =
style=3D"color: #70757a; text-decoration: none;"></span></div><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></span>=
<meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@redhat.com">eri=
c.auger@redhat.com</a></span><meta itemprop=3D"email" content=3D"eric.auger=
@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:f=
elipe@nutanix.com">felipe@nutanix.com</a></span><meta itemprop=3D"email" co=
ntent=3D"felipe@nutanix.com"/></span><span class=3D"secondary-text" style=
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
tion: none;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span>=
<meta itemprop=3D"email" content=3D"jan.kiszka@web.de"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a>=
</span><meta itemprop=3D"email" content=3D"jgg@nvidia.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:jidong.xiao@gmail.com">jidong.x=
iao@gmail.com</a></span><meta itemprop=3D"email" content=3D"jidong.xiao@gma=
il.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jim.shu=
@sifive.com">jim.shu@sifive.com</a></span><meta itemprop=3D"email" content=
=3D"jim.shu@sifive.com"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</a></span=
><meta itemprop=3D"email" content=3D"jjherne@linux.vnet.ibm.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:joao.m.martins@oracle.com=
">Joao Martins</a></span><meta itemprop=3D"email" content=3D"joao.m.martins=
@oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:k=
onrad.wilk@oracle.com">konrad.wilk@oracle.com</a></span><meta itemprop=3D"e=
mail" content=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-t=
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
n: none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com=
</a></span><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:mdean@redhat.com"=
>mdean@redhat.com</a></span><meta itemprop=3D"email" content=3D"mdean@redha=
t.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mimu@lin=
ux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D"email"=
 content=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:paul.walmsley@sifive.com">paul.walmsley@sifive.com</a=
></span><meta itemprop=3D"email" content=3D"paul.walmsley@sifive.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:pbonzini@redhat.com"=
>pbonzini@redhat.com</a></span><meta itemprop=3D"email" content=3D"pbonzini=
@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:p=
eter.maydell@linaro.org">Peter Maydell</a></span><meta itemprop=3D"email" c=
ontent=3D"peter.maydell@linaro.org"/></span><span class=3D"secondary-text" =
style=3D"color: #70757a; text-decoration: none;"></span></div><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:richard.henderson@linaro.org">Richard Henderson</a></s=
pan><meta itemprop=3D"email" content=3D"richard.henderson@linaro.org"/></sp=
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
ext-decoration: none;" href=3D"mailto:shentey@gmail.com">shentey@gmail.com<=
/a></span><meta itemprop=3D"email" content=3D"shentey@gmail.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmail.com">stefa=
nha@gmail.com</a></span><meta itemprop=3D"email" content=3D"stefanha@gmail.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:wei.w.wang=
@intel.com">wei.w.wang@intel.com</a></span><meta itemprop=3D"email" content=
=3D"wei.w.wang@intel.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=3D"email" =
content=3D"z.huo@139.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhiwei</a></span><meta itempro=
p=3D"email" content=3D"zhiwei_liu@linux.alibaba.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmai=
l.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:philmd@linaro.or=
g">Phil Mathieu-Daud=C3=A9</a></span><meta itemprop=3D"email" content=3D"ph=
ilmd@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:eblot@rivosinc.com">eblot@rivosinc.com</a></span><meta itemprop=3D"email"=
 content=3D"eblot@rivosinc.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:max.chou@sifive.com">max.chou@sifive.com</a></span><meta i=
temprop=3D"email" content=3D"max.chou@sifive.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu=
.org</a></span><meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div></div><a href=3D"https://calendar.google.com/calen=
dar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwM=
jQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndm=
JwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYTEzMTFiYzQwODM5Z=
TFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope%2FLondon&amp;hl=3Den=
&amp;es=3D0" style=3D"display: inline-block;;color: #1a73e8; text-decoratio=
n: none;font-weight: 700;" target=3D"_blank" class=3D"accent-text underline=
-on-hover">View all guest info</a></div></td></tr><tr><td style=3D"font-siz=
e: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:=
0px;"><div style=3D"color: #3c4043; text-decoration: none;;font-family: Rob=
oto, sans-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: e=
xactly; text-align: left;" class=3D"primary-text"><div><span style=3D"font-=
weight: 700;-webkit-font-smoothing: antialiased;">RSVP</span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"> for <a c=
lass=3D"secondary-text underline-on-hover" style=3D"display: inline-block;;=
color: #70757a; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.or=
g">qemu-devel@nongnu.org</a> for all events in this series</span></div></di=
v></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; wo=
rd-break: break-word;;padding-bottom:16px;"><div style=3D"font-family: Robo=
to, sans-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: ex=
actly; text-align: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" role=3D"presentation" style=3D"border-collapse: separate;"><tr><td s=
tyle=3D"padding-top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP =
buttons --><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"=
presentation" style=3D"border: solid 1px #dadce0; border-radius: 16px; bord=
er-collapse: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-seri=
f;;display: inline-block;;margin-right: 12px; margin-left: 0;"><tr><td alig=
n=3D"center" vertical-align=3D"middle" role=3D"presentation"><span itemprop=
=3D"potentialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><m=
eta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/Yes=
"/><span itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpA=
ctionHandler"><link itemprop=3D"method" href=3D"http://schema.org/HttpReque=
stMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.=
google.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbT=
BhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=
=3D1&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRh=
ci5nb29nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;=
ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;fon=
t-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-si=
ze: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text=
-decoration: none; text-transform: none;" class=3D"grey-button-text" itempr=
op=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"presentati=
on" valign=3D"middle" style=3D"padding: 6px 0; padding-left: 16px; padding-=
right: 12px; white-space: nowrap;"><!--[if mso]><a href=3D"https://calendar=
.google.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlb=
TBhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=
=3D1&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRh=
ci5nb29nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;=
ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" it=
emprop=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey-button-tex=
t" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sa=
ns-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-heigh=
t-rule: exactly; margin: 0; text-decoration: none; text-transform: none;">Y=
es</span><!--[if mso]></a><![endif]--></td></tr></table></a></span></span><=
/span></td><td align=3D"center" vertical-align=3D"middle" role=3D"presentat=
ion" style=3D"border-left: solid 1px #dadce0; border-right: solid 1px #dadc=
e0;"><span itemprop=3D"potentialaction" itemscope itemtype=3D"http://schema=
.org/RsvpAction"><meta itemprop=3D"attendance" content=3D"http://schema.org=
/RsvpAttendance/No"/><span itemprop=3D"handler" itemscope itemtype=3D"http:=
//schema.org/HttpActionHandler"><link itemprop=3D"method" href=3D"http://sc=
hema.org/HttpRequestMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D=
"https://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2=
dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmd=
udS5vcmc&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bn=
cm91cC5jYWxlbmRhci5nb29nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTc=
zZDVhZDNjMg&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font=
-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: =
#5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly;=
 margin: 0; text-decoration: none; text-transform: none;" class=3D"grey-but=
ton-text" itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpaddin=
g=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" ro=
le=3D"presentation" valign=3D"middle" style=3D"padding: 6px 12px; white-spa=
ce: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/e=
vent?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQ=
wMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;tok=3DNTQjY19r=
NXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYTEzMTF=
iYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope%2FLondon&a=
mp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" target=
=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D"font-weig=
ht: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f63=
68; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; marg=
in: 0; text-decoration: none; text-transform: none;">No</span><!--[if mso]>=
</a><![endif]--></td></tr></table></a></span></span></span></td><td align=
=3D"center" vertical-align=3D"middle" role=3D"presentation"><span itemprop=
=3D"potentialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><m=
eta itemprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/May=
be"/><span itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/Htt=
pActionHandler"><link itemprop=3D"method" href=3D"http://schema.org/HttpReq=
uestMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://calenda=
r.google.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJl=
bTBhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=
=3D3&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRh=
ci5nb29nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;=
ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;fon=
t-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-si=
ze: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text=
-decoration: none; text-transform: none;" class=3D"grey-button-text" itempr=
op=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"presentati=
on" valign=3D"middle" style=3D"padding: 6px 0; padding-left: 12px; padding-=
right: 16px; white-space: nowrap;"><!--[if mso]><a href=3D"https://calendar=
.google.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlb=
TBhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=
=3D3&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRh=
ci5nb29nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;=
ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" it=
emprop=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey-button-tex=
t" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sa=
ns-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-heigh=
t-rule: exactly; margin: 0; text-decoration: none; text-transform: none;">M=
aybe</span><!--[if mso]></a><![endif]--></td></tr></table></a></span></span=
></span></td></tr></table><!-- More options --><a href=3D"https://calendar.=
google.com/calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhM=
HJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNT=
QjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tY=
TEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope%2FLo=
ndon&amp;hl=3Den&amp;es=3D0" style=3D"display: inline-block;;font-weight: 4=
00;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; f=
ont-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0=
; text-decoration: none; text-transform: none;" class=3D"grey-button-text" =
target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" r=
ole=3D"presentation" style=3D"border: solid 1px #dadce0; border-radius: 16p=
x; border-collapse: separate;font-family: &#39;Google Sans&#39;, Roboto, sa=
ns-serif;"><tr><td align=3D"center" vertical-align=3D"middle" role=3D"prese=
ntation" style=3D"padding: 6px 0; padding-left: 16px; padding-right: 12px; =
white-space: nowrap;;color: #5f6367;"><!--[if mso]><a href=3D"https://calen=
dar.google.com/calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlb=
TBhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=
=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUu=
Y29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope=
%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" target=3D"_bla=
nk"><![endif]--><span class=3D"grey-button-text" style=3D"font-weight: 400;=
font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font=
-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; t=
ext-decoration: none; text-transform: none;">More options</span><!--[if mso=
]></a><![endif]--></td></tr></table></a></td></tr></table></div></td></tr><=
/table></td></tr></tbody></table></div><!--[if mso | IE]></td><![endif]--><=
!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></table><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" alig=
n=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"font-=
size: 0; padding: 0; text-align: left; word-break: break-word;;padding:4px =
12px;" class=3D"" align=3D"left"><div class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;font-family: Roboto, sans-serif;font-siz=
e: 12px; line-height: 16px; mso-line-height-rule: exactly; text-align: left=
;"><p>Invitation from <a href=3D"https://calendar.google.com/calendar/" cla=
ss=3D"accent-text underline-on-hover" style=3D"font-family: Roboto, sans-se=
rif;font-size: 12px; line-height: 16px; mso-line-height-rule: exactly;;colo=
r: #1a73e8; text-decoration: none;" target=3D"_blank">Google Calendar</a></=
p><p>You are receiving this email because you are an attendee on the event.=
 To stop receiving future updates for this event, decline this event.</p><p=
>Forwarding this invitation could allow any recipient to send a response to=
 the organizer, be added to the guest list, invite others regardless of the=
ir own invitation status, or modify your RSVP. <a class=3D"accent-text unde=
rline-on-hover" style=3D"font-family: Roboto, sans-serif;font-size: 12px; l=
ine-height: 16px; mso-line-height-rule: exactly;;color: #1a73e8; text-decor=
ation: none;" href=3D"https://support.google.com/calendar/answer/37135#forw=
arding">Learn more</a></p></div></td></tr></tbody></table></td></tr></tbody=
></table></span></span></body></html>
--00000000000057a5190614030e8f
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
DTSTART;TZID=3DAmerica/New_York:20240319T090000
DTEND;TZID=3DAmerica/New_York:20240319T100000
RRULE:FREQ=3DWEEKLY;WKST=3DMO;INTERVAL=3D2;BYDAY=3DTU
DTSTAMP:20240319T130018Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20240319T130000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dafaerber@suse.de;X-NUM-GUESTS=3D0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dale@rev.ng;X-NUM-GUESTS=3D0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dalistair.francis@wdc.com;X-NUM-GUESTS=3D0:mailto:alistair.franci=
s@wdc
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAnton Johansson;X-NUM-GUESTS=3D0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Darmbru@redhat.com;X-NUM-GUESTS=3D0:mailto:armbru@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbbauman@redhat.com;X-NUM-GUESTS=3D0:mailto:bbauman@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbcain@quicinc.com;X-NUM-GUESTS=3D0:mailto:bcain@quicinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dberrange@redhat.com;X-NUM-GUESTS=3D0:mailto:berrange@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DChao Peng;X-NUM-GUESTS=3D0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcjia@nvidia.com;X-NUM-GUESTS=3D0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dclg@kaod.org;X-NUM-GUESTS=3D0:mailto:clg@kaod.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcw@f00f.org;X-NUM-GUESTS=3D0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3DDamien Hedde;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.com
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
 TRUE;CN=3DElena Ufimtseva;X-NUM-GUESTS=3D0:mailto:elena.ufimtseva@oracle.c=
om
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deric.auger@redhat.com;X-NUM-GUESTS=3D0:mailto:eric.auger@redhat.=
com
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
 TRUE;CN=3Djan.kiszka@web.de;X-NUM-GUESTS=3D0:mailto:jan.kiszka@web.de
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
 TRUE;CN=3Djjherne@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:jjherne@linux=
.vnet
 .ibm.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DJoao Martins;X-NUM-GUESTS=3D0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dkonrad.wilk@oracle.com;X-NUM-GUESTS=3D0:mailto:konrad.wilk@oracl=
e.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DLuc Michel;X-NUM-GUESTS=3D0:mailto:luc@lmichel.fr
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmburton@qti.qualcomm.com;X-NUM-GUESTS=3D0:mailto:mburton@qti.qua=
lcomm
 .com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dmdean@redhat.com;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmimu@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:mimu@linux.vnet.=
ibm.c
 om
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
 TRUE;CN=3DShameerali Kolothum Thodi;X-NUM-GUESTS=3D0:mailto:shameerali.kol=
othum
 .thodi@huawei.com
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
 TRUE;CN=3Dz.huo@139.com;X-NUM-GUESTS=3D0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DLIU Zhiwei;X-NUM-GUESTS=3D0:mailto:zhiwei_liu@linux.alibaba.com
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
 TRUE;CN=3Dqemu-devel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.=
org
X-MICROSOFT-CDO-OWNERAPPTID:-1337962242
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

--00000000000057a5190614030e8f--

--00000000000057a51c0614030e91
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
UlQ7VFpJRD1BbWVyaWNhL05ld19Zb3JrOjIwMjQwMzE5VDA5MDAwMA0KRFRFTkQ7VFpJRD1BbWVy
aWNhL05ld19Zb3JrOjIwMjQwMzE5VDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztJ
TlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjQwMzE5VDEzMDAxOFoNCk9SR0FOSVpFUjtD
Tj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJrdTVzaTAxYmxt
bmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjFndnViOTQzNW83aHJyZW0wYTBy
YWxubDVpX1IyMDI0MDMxOVQxMzAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1hZmFlcmJlckBzdXNlLmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphZmFlcmJlckBz
dXNlLmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWFsZUByZXYubmc7WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmFsZUByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmFsZXguYmVubmVlQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzphbGlzdGFpci5mcmFuY2lzQHdkYw0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049QW50b24gSm9oYW5zc29uO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbmpvQHJldi5uZw0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1hcm1icnVAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86YXJtYnJ1QHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
YmJhdW1hbkByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpiYmF1bWFuQHJlZGhhdC5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YmNhaW5AcXVpY2luYy5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmJjYWluQHF1aWNpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPWJlcnJhbmdlQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJlcnJhbmdl
QHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Q2hhbyBQZW5nO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzpjaGFvLnAucGVuZ0BsaW51eC5pbnRlbC5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049Y2ppYUBudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpj
amlhQG52aWRpYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Y2xnQGthb2Qub3Jn
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjbGdAa2FvZC5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049Y3dAZjAwZi5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmN3QGYwMGYub3JnDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1B
Q0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049RGFtaWVuIEhlZGRlO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpkaGVkZGVAa2FscmF5aW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lYmxh
a2VAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWJsYWtlQHJlZGhhdC5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzplZGdhci5pZ2xlc2lhc0BnbWFpbA0KIC5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtS
U1ZQPVRSVQ0KIEU7Q049ZWR1YXJkb0BoYWJrb3N0Lm5ldDtYLU5VTS1HVUVTVFM9MDptYWlsdG86
ZWR1YXJkb0BoYWJrb3N0Lm5ldA0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1FbGVuYSBV
ZmltdHNldmE7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWVyaWMuYXVnZXJAcmVkaGF0LmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPWZlbGlwZUBudXRhbml4LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZmVs
aXBlQG51dGFuaXguY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWlnZ3lAdGhlaWdn
eS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmlnZ3lAdGhlaWdneS5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049aW1wQGJzZGltcC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmlt
cEBic2RpbXAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWphbi5raXN6a2FAd2Vi
LmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqYW4ua2lzemthQHdlYi5kZQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O1JTVlA9DQogVFJVRTtDTj1qZ2dAbnZpZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amdn
QG52aWRpYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amlkb25nLnhpYW9AZ21h
aWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqaWRvbmcueGlhb0BnbWFpbC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amltLnNodUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpqaW0uc2h1QHNpZml2ZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
ampoZXJuZUBsaW51eC52bmV0LmlibS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpqaGVybmVA
bGludXgudm5ldA0KIC5pYm0uY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUpvYW8g
TWFydGlucztYLU5VTS1HVUVTVFM9MDptYWlsdG86am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1rb25yYWQud2lsa0BvcmFjbGUuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzprb25yYWQud2lsa0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPUx1YyBNaWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmx1Y0BsbWljaGVs
LmZyDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1idXJ0b25AcXRpLnF1YWxjb21tLmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWJ1cnRvbkBxdGkucXVhbGNvbW0NCiAuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NF
UFRFRDtSU1ZQPVRSVUUNCiA7Q049bWRlYW5AcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWls
dG86bWRlYW5AcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1taW11QGxp
bnV4LnZuZXQuaWJtLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWltdUBsaW51eC52bmV0Lmli
bS5jDQogb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049cGF1bC53YWxtc2xleUBzaWZpdmUu
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYXVsLndhbG1zbGV5QHNpZml2ZS5jbw0KIG0NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGJvbnppbmlAcmVkaGF0LmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1QZXRlciBNYXlkZWxsO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049UmljaGFyZCBIZW5kZXJzb247
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcg0KIGcNCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049U2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86c2hhbWVlcmFsaS5rb2xvdGh1bQ0KIC50aG9kaUBodWF3ZWkuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXNoZW50ZXlAZ21haWwuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzpzaGVudGV5QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO1JTVlA9VFJVDQogRTtD
Tj1zdGVmYW5oYUBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnN0ZWZhbmhhQGdtYWls
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj13ZWkudy53YW5nQGludGVsLmNvbTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86d2VpLncud2FuZ0BpbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049ei5odW9AMTM5LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ei5odW9A
MTM5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1MSVUgWmhpd2VpO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzp6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPXp3dS5rZXJuZWxAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzp6d3Uua2VybmVsQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86cGhpbG1kQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7
Q049ZWJsb3RAcml2b3NpbmMuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxvdEByaXZvc2lu
Yy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWF4LmNob3VAc2lmaXZlLmNvbTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86bWF4LmNob3VAc2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1xZW11LWRldmVsQG5vbmdudS5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KWC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOi0xMzM3
OTYyMjQyDQpDUkVBVEVEOjIwMjMwMjIxVDE1Mzk1MFoNCkRFU0NSSVBUSU9OOklmIHlvdSBuZWVk
IGNhbGwgZGV0YWlsc1wsIHBsZWFzZSBjb250YWN0IG1lOiA8YSBocmVmPSJtYWlsdG86cQ0KIHVp
bnRlbGFAcmVkaGF0LmNvbSI+YWxleC5iZW5uZWVAbGluYXJvLm9yZzwvYT4NCkxBU1QtTU9ESUZJ
RUQ6MjAyNDAzMTlUMTMwMDA0Wg0KTE9DQVRJT046aHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxs
bWVldGluZw0KU0VRVUVOQ0U6MA0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpRRU1VL0tWTSBk
ZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFVRQ0KQVRUQUNIO0ZJTEVOQU1F
PU5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbDtGTVRUWVBFPWFw
cGxpY2ENCiB0aW9uL3ZuZC5nb29nbGUtYXBwcy5kb2N1bWVudDpodHRwczovL2RvY3MuZ29vZ2xl
LmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHoNCiB4Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJtU0pC
R1FacmVrL2VkaXQNCkJFR0lOOlZBTEFSTQ0KQUNUSU9OOkVNQUlMDQpERVNDUklQVElPTjpUaGlz
IGlzIGFuIGV2ZW50IHJlbWluZGVyDQpTVU1NQVJZOkFsYXJtIG5vdGlmaWNhdGlvbg0KQVRURU5E
RUU6bWFpbHRvOnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KVFJJR0dFUjotUDJEDQpFTkQ6VkFMQVJN
DQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=
--00000000000057a51c0614030e91--

