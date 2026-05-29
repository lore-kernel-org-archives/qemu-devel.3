Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E8ACD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqKW-0004Uc-E6; Fri, 29 May 2026 02:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1wSqKU-0004UC-TP
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1wSqKR-0000B7-Nq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780034658;
 h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=ltbXK9dRUT6cj//B1lvrtugo4K+OFpldWrsrSTpE4uc=;
 b=ZZc3VHbh7r5bVMnb36WI6BOjRl5omSzBgdC3PfuHDLlHowvFU919iB2tTj6JFqrCgB+mh7
 ouIuuf3S4f4S7niPSKawfpV0dndlyvCkLEQa9ohmcTkG5FieaKG06pa0/F4qRXFMT2juIw
 rRz0VEvtiuIY//XTlx1vq0+/Aw1Vyek=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-xoZvy7omPDqA35npaEWsbA-1; Fri, 29 May 2026 02:03:09 -0400
X-MC-Unique: xoZvy7omPDqA35npaEWsbA-1
X-Mimecast-MFC-AGG-ID: xoZvy7omPDqA35npaEWsbA_1780034588
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45eeee26201so380974f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780034588; x=1780639388; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ltbXK9dRUT6cj//B1lvrtugo4K+OFpldWrsrSTpE4uc=;
 b=uXrHmXUhoF0byAMhziFsoTfFiaQWEE5hPKaIx8wEOHKTpcYNPCGChFDtcH5LleC8YS
 2jbDkqbhmdgR3rKxN5gD0NVUsYtjgQbQjl2C2Sd+GtNE0nOAD4+7hS+ehSjffQybChe0
 6QAtbfXVf3+k1ORFFCPz4g2Cg9fvWSdX8BGNsNe8pw+AkgsYj1yiaTeeLf1EPfsFNd+2
 7E/buRdmRc1r5KvKQEFBhxmzkJTCmnEfWPIbbcFx7rzjKj2Wnh27dW9sswW2bGWoZrY3
 aDHCZVZCBaHSEbUCqOOC69VHoOLTGrM3Ydw8v0IzeN8zHjmeQ1u99UWp5FCZwrFoOruC
 SkIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780034588; x=1780639388; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ltbXK9dRUT6cj//B1lvrtugo4K+OFpldWrsrSTpE4uc=;
 b=RBZnC905s+rHZyjZB2WrXdupAI/9H3dJDo03EAfoop5d4wzSG2OEgwFEAUhXaP4Zym
 lMmihikgQCcmZE48DwN4/+IR5LPTgripmM/26luN8uZMTnfiU3p9QjS+MCJsivJ/ts6v
 4IMSGd28bIr0ZHiGQJXre2j3YjkI3urfiTdVTxkqBlvK8vyKx/WsAjEAuc8rDJTZT/iF
 g6LLCv3eeKpngI6vfEAWAvrnhnWcxGydFhrjJbA/dSxPcn6GAgQVhf3YI5mCDkqKasfC
 fSa3juL+LvNP7XQCrvMS91jtMEyzXp5SG6efSm0D4uq5RUDLAXB5SZ7atl8VSo9eimBB
 QaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780034588; x=1780639388;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltbXK9dRUT6cj//B1lvrtugo4K+OFpldWrsrSTpE4uc=;
 b=sj1qG9JRvK5gibO5q1zALKlhXcxm7jlMsGq49u/fA5SVrfd73mOHF3L3FfqvUAA+p+
 rDa6zCbaHIgvLNokvfrLAYBJ4StBc/OhqgSlBlH3yJOaEI3fvbS8NRc2XyZv/Ex1dNA4
 78NWsuEV4yJMJFIMMu/9ZKIpQJJQziOM+woXslKQ+VBtZ3+1702TZ0+XeL6a0iK3MYSN
 ur9mYGH8vlw51yllKa9+A9DZ6AkYekntpL6tv9zzbaWRKkvGAlhZO82fr10PJ36jFgid
 qmIWg7donzrdf8DpFtdPHN/pu+6EmUMqaDFLr/dxzk7Ct3iMLvcMU/RqShpJmNpbAcMQ
 sY0Q==
X-Gm-Message-State: AOJu0YyYEHFNiKUABnQblL8If8z7UolLXeoIJeg6USNiSX8mROEusym9
 l0lpww5pXq9crPqhBubyV38ZbYp7MgNUuvC/u/5ArZKnAXrOOW9pWt345eCuHFKd0g1bTXXUQjH
 K4XVLsfX7M189LcjHaa3TKIp56FkiKwpjm8IVP/UA81IuT3i8f86BfRHeiQSnGTW9LYZqB4xinl
 ChPfuq28tsXsE7bKp/B38/s4BsogDD1QWCOP3u/NbTsBF72ZJENmMA6eZld21U2zCE8nFdTl5vn
 7hXuNt1VTmogYBNDFQ8P1c=
X-Gm-Gg: Acq92OEPfQjRrOtWztNcrjkyzVBT0vZ60ORw6b4Q46LSIm1qfI4upY1Zz355Y61PGeL
 jjw2jHCwsPUKlWQdiXLxaHM/nzeTAiyyERZ+IUIaj2TGw9lU4I2nQ07Zehd4992pZKD9pb8kEqJ
 2/2KA16pR0CQlGN/G9ss+InpaREUzE02vnSwg5LT1hOEQQl869v47ohH2zv9XCgUtnxUoj4CRBW
 Bp146nfgEaHHc/beNjrDHtYntXbTAqpQSM7qzm4G5kxlGsJ
X-Received: by 2002:a05:600c:4694:b0:490:48a0:b87a with SMTP id
 5b1f17b1804b1-4909c08d1fcmr26311725e9.9.1780034587780; 
 Thu, 28 May 2026 23:03:07 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 2002:a05:600c:4694:b0:490:48a0:b87a with SMTP id
 5b1f17b1804b1-4909c08d1fcmr26310365e9.9.1780034587094; Thu, 28 May 2026
 23:03:07 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-ff97bc65-6b81-47a3-a1ed-bf225210153f@google.com>
Date: Fri, 29 May 2026 06:03:07 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 16:00 to 17:00 on Tuesday from Tue May 12 to Tue Jun 9 (CEST)
 (qemu-devel@nongnu.org)
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="00000000000040aef70652ee99d1"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIMWL_WL_MED=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Cedric Le Goater <clegoate@redhat.com>
X-ACL-Warn: ,  Cedric Le Goater <clegoate@redhat.com>
From:  Cedric Le Goater via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000040aef70652ee99d1
Content-Type: multipart/alternative; boundary="00000000000040aef60652ee99cf"

--00000000000040aef60652ee99cf
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9t
IDE2OjAwIHRvIDE3OjAwIG9uIFR1ZXNkYXkgZnJvbSBUdWVzZGF5IE1heSAxMiB0byBUdWVzZGF5
ICANCkp1biA5DQpDZW50cmFsIEV1cm9wZWFuIFRpbWUgLSBQYXJpcw0KDQpMb2NhdGlvbg0KaHR0
cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZwkNCmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20v
dXJsP3E9aHR0cHMlM0ElMkYlMkZtZWV0LmppdC5zaSUyRmt2bWNhbGxtZWV0aW5nJnNhPUQmc291
cmNlPWNhbGVuZGFyJnVzdD0xNzgwNDY2NTgwMDAwMDAwJnVzZz1BT3ZWYXcwYl9yU1c3bGVFR09E
Mk1FQ2FBTTVCDQoNCg0KDQpBdHRhY2htZW50cw0KTm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3Bl
cnMgY29uZmVyZW5jZSBjYWxsICANCmh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2Qv
MS1MdHExMUxMenhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1TSkJHUVpyZWsvZWRpdA0KDQpJZiB5
b3UgbmVlZCBjYWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBhbGV4LmJlbm5lZUBsaW5h
cm8ub3JnDQoNCkd1ZXN0cw0KYWxleC5iZW5uZWVAbGluYXJvLm9yZyAtIGNyZWF0b3INCk1hcmt1
cyBBcm1icnVzdGVyDQpiY2FpbkBxdWljaW5jLmNvbQ0KRGFuaWVsIEJlcnJhbmfDqQ0KY2ppYUBu
dmlkaWEuY29tDQpjd0BmMDBmLm9yZw0KRXJpYyBCbGFrZQ0KZWRnYXIuaWdsZXNpYXNAZ21haWwu
Y29tDQplZHVhcmRvQGhhYmtvc3QubmV0DQpmZWxpcGVAbnV0YW5peC5jb20NCmlnZ3lAdGhlaWdn
eS5jb20NCmltcEBic2RpbXAuY29tDQpqZ2dAbnZpZGlhLmNvbQ0Kamlkb25nLnhpYW9AZ21haWwu
Y29tDQpqaW0uc2h1QHNpZml2ZS5jb20NCm1idXJ0b25AcXRpLnF1YWxjb21tLmNvbQ0KcGF1bC53
YWxtc2xleUBzaWZpdmUuY29tDQpQYW9sbyBCb256aW5pDQpwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmcNCnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcNCnNoZW50ZXlAZ21haWwuY29tDQpzdGVm
YW5oYUBnbWFpbC5jb20NCndlaS53LndhbmdAaW50ZWwuY29tDQp6d3Uua2VybmVsQGdtYWlsLmNv
bQ0KcGhpbG1kQGxpbmFyby5vcmcNCmVibG90QHJpdm9zaW5jLmNvbQ0KbWF4LmNob3VAc2lmaXZl
LmNvbQ0KbWFub3MucGl0c2lkaWFuYWtpc0BsaW5hcm8ub3JnDQpUaG9tYXMgSHV0aA0KcmJjQG1l
dGEuY29tDQpkZW1pb2Jlbm91ckBnbWFpbC5jb20NCmhpQGFseXNzYS5pcw0KZGhlZGRlQGthbHJh
eWluYy5jb20NCkFsYmVydG8gRmFyaWENCkFsYmVydCBFc3RldmUNCm1hcmNhbmRyZS5sdXJlYXVA
Z21haWwuY29tDQptYXR0aGlldUBtaW5pby5pbw0KamFjb2Iub3Vyc2xhbmRAZ21haWwuY29tDQpo
ZWxnZS5kZWxsZXJAZ29vZ2xlbWFpbC5jb20NCkNlZHJpYyBMZSBHb2F0ZXINCkFsaXN0YWlyIEZy
YW5jaXMNCmtvbnJhZC53aWxrQG9yYWNsZS5jb20NCkFsZXNzYW5kcm8gRGkgRmVkZXJpY28NCkFu
dG9uIEpvaGFuc3Nvbg0KQ2hhbyBQZW5nDQpFbGVuYSBVZmltdHNldmENCmVyaWMuYXVnZXJAcmVk
aGF0LmNvbQ0KamFuLmtpc3prYUB3ZWIuZGUNCkpvYW8gTWFydGlucw0KTHVjIE1pY2hlbA0KU2hh
bWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0Kei5odW9AMTM5LmNvbQ0KTElVIFpoaXdlaQ0KcWVtdS1k
ZXZlbEBub25nbnUub3JnDQpuZWxzb24uaG9Ad2luZHJpdmVyLmNvbQ0KDQoNCn5+Ly9+fg0KSW52
aXRhdGlvbiBmcm9tIEdvb2dsZSBDYWxlbmRhcjogaHR0cHM6Ly9jYWxlbmRhci5nb29nbGUuY29t
L2NhbGVuZGFyLw0KDQpZb3UgYXJlIHJlY2VpdmluZyB0aGlzIGVtYWlsIGJlY2F1c2UgeW91IGFy
ZSBhbiBhdHRlbmRlZSBvbiB0aGUgZXZlbnQuDQoNCkZvcndhcmRpbmcgdGhpcyBpbnZpdGF0aW9u
IGNvdWxkIGFsbG93IGFueSByZWNpcGllbnQgdG8gc2VuZCBhIHJlc3BvbnNlIHRvICANCnRoZSBv
cmdhbml6ZXIsIGJlIGFkZGVkIHRvIHRoZSBndWVzdCBsaXN0LCBpbnZpdGUgb3RoZXJzIHJlZ2Fy
ZGxlc3Mgb2YgIA0KdGhlaXIgb3duIGludml0YXRpb24gc3RhdHVzLCBvciBtb2RpZnkgeW91ciBS
U1ZQLg0KDQpMZWFybiBtb3JlIGh0dHBzOi8vc3VwcG9ydC5nb29nbGUuY29tL2NhbGVuZGFyL2Fu
c3dlci8zNzEzNSNmb3J3YXJkaW5nDQo=
--00000000000040aef60652ee99cf
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
</h2></td></tr></table><span>Every 2 weeks from 16:00 to 17:00 on Tuesday f=
rom Tuesday May 12 to Tuesday Jun 9 (Central European Time - Paris)</span><=
/div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left;=
 word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: R=
oboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; li=
ne-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: non=
e;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom=
: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: =
#3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: ant=
ialiased;margin: 0; padding: 0;">Location</h2></td></tr></table><span itemp=
rop=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span itemp=
rop=3D"name" class=3D"primary-text notranslate" style=3D"font-family: Robot=
o, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-h=
eight: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">=
https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google=
.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;sour=
ce=3Dcalendar&amp;ust=3D1780466580000000&amp;usg=3DAOvVaw0b_rSW7leEGOD2MECa=
AM5B" class=3D"accent-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #1a73e8; text-decoration: none;font-weight: 700;" target=3D"_bla=
nk" itemprop=3D"map">View map</a></span></div></td></tr><tr><td style=3D"fo=
nt-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-b=
ottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: norm=
al; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0=
.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D=
"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"prima=
ry-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;fon=
t-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">G=
uests</h2></td></tr></table><div style=3D"padding-bottom: 4px; text-align: =
left;;color: #3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:alex.bennee@linar=
o.org">alex.bennee@linaro.org</a></span><meta itemprop=3D"email" content=3D=
"alex.bennee@linaro.org"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"> - creator</span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:armbru@redhat.com">Markus Armbruster</a></span><meta it=
emprop=3D"email" content=3D"armbru@redhat.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:bcain@quicinc.com">bcain@quicinc.com</a></s=
pan><meta itemprop=3D"email" content=3D"bcain@quicinc.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:berrange@redhat.com">Daniel Ber=
rang=C3=A9</a></span><meta itemprop=3D"email" content=3D"berrange@redhat.co=
m"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.=
com">cjia@nvidia.com</a></span><meta itemprop=3D"email" content=3D"cjia@nvi=
dia.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; te=
xt-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsco=
pe itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"n=
otranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: =
inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00=
f.org">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.or=
g"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redha=
t.com">Eric Blake</a></span><meta itemprop=3D"email" content=3D"eblake@redh=
at.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.i=
glesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"ema=
il" content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</a></spa=
n><meta itemprop=3D"email" content=3D"eduardo@habkost.net"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">felipe@nuta=
nix.com</a></span><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@theiggy.com=
">iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"iggy@theig=
gy.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:imp@bsd=
imp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=3D"imp@b=
sdimp.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jgg@=
nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"email" content=3D"jg=
g@nvidia.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
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
ext-decoration: none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti=
.qualcomm.com</a></span><meta itemprop=3D"email" content=3D"mburton@qti.qua=
lcomm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:paul=
.walmsley@sifive.com">paul.walmsley@sifive.com</a></span><meta itemprop=3D"=
email" content=3D"paul.walmsley@sifive.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:pbonzini@redhat.com">Paolo Bonzini</a></span><=
meta itemprop=3D"email" content=3D"pbonzini@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:peter.maydell@linaro.org">peter.ma=
ydell@linaro.org</a></span><meta itemprop=3D"email" content=3D"peter.maydel=
l@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:r=
ichard.henderson@linaro.org">richard.henderson@linaro.org</a></span><meta i=
temprop=3D"email" content=3D"richard.henderson@linaro.org"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:shentey@gmail.com">shentey@gmai=
l.com</a></span><meta itemprop=3D"email" content=3D"shentey@gmail.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmail.co=
m">stefanha@gmail.com</a></span><meta itemprop=3D"email" content=3D"stefanh=
a@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:w=
ei.w.wang@intel.com">wei.w.wang@intel.com</a></span><meta itemprop=3D"email=
" content=3D"wei.w.wang@intel.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span><m=
eta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:philmd@linaro.org">philmd@linaro.o=
rg</a></span><meta itemprop=3D"email" content=3D"philmd@linaro.org"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:eblot@rivosinc.com">eb=
lot@rivosinc.com</a></span><meta itemprop=3D"email" content=3D"eblot@rivosi=
nc.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:max.cho=
u@sifive.com">max.chou@sifive.com</a></span><meta itemprop=3D"email" conten=
t=3D"max.chou@sifive.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis@linaro.org</=
a></span><meta itemprop=3D"email" content=3D"manos.pitsidianakis@linaro.org=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:thuth@redhat.=
com">Thomas Huth</a></span><meta itemprop=3D"email" content=3D"thuth@redhat=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:rbc@meta.=
com">rbc@meta.com</a></span><meta itemprop=3D"email" content=3D"rbc@meta.co=
m"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:demiobenour@=
gmail.com">demiobenour@gmail.com</a></span><meta itemprop=3D"email" content=
=3D"demiobenour@gmail.com"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D=
"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=
=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover=
" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" h=
ref=3D"mailto:hi@alyssa.is">hi@alyssa.is</a></span><meta itemprop=3D"email"=
 content=3D"hi@alyssa.is"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:dhedde@kalrayinc.com">dhedde@kalrayinc.com</a></span><meta itemp=
rop=3D"email" content=3D"dhedde@kalrayinc.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:afaria@redhat.com">Alberto Faria</a></span>=
<meta itemprop=3D"email" content=3D"afaria@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:aesteve@redhat.com">Albert Esteve<=
/a></span><meta itemprop=3D"email" content=3D"aesteve@redhat.com"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:marcandre.lureau@gmail.c=
om">marcandre.lureau@gmail.com</a></span><meta itemprop=3D"email" content=
=3D"marcandre.lureau@gmail.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:matthieu@minio.io">matthieu@minio.io</a></span><meta itemp=
rop=3D"email" content=3D"matthieu@minio.io"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:jacob.oursland@gmail.com">jacob.oursland@gmail=
.com</a></span><meta itemprop=3D"email" content=3D"jacob.oursland@gmail.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:helge.deller@=
googlemail.com">helge.deller@googlemail.com</a></span><meta itemprop=3D"ema=
il" content=3D"helge.deller@googlemail.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:clg@redhat.com">Cedric Le Goater</a></span><me=
ta itemprop=3D"email" content=3D"clg@redhat.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:alistair.francis@wdc.com">Alistair Franci=
s</a></span><meta itemprop=3D"email" content=3D"alistair.francis@wdc.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@orac=
le.com">konrad.wilk@oracle.com</a></span><meta itemprop=3D"email" content=
=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:ale@rev.ng">Alessandro Di Federico</a></span><meta itemprop=
=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:anjo@rev.ng">Anton Johansson</a></span><meta itemprop=3D=
"email" content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:chao.p.peng@linux.intel.com">Chao Peng</a></span><meta ite=
mprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/></span><span class=
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
--00000000000040aef60652ee99cf
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
RRULE:FREQ=3DWEEKLY;WKST=3DMO;UNTIL=3D20260608T235959Z;INTERVAL=3D2;BYDAY=
=3DTU
DTSTAMP:20260529T060306Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:3tmn51v3ap1pkbeqj4divuh46c_R20260512T140000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dalex.bennee@linaro.org;X-NUM-GUESTS=3D0:mailto:alex.bennee@linaro.or=
g
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DMarkus Armbruster;X-NUM-GUESTS=3D0:mailto:armbru@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dbcain@quicinc.com;X-NUM-GUESTS=3D0:mailto:bcain@quicinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:berrange@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcjia@nvidia.com;X-NUM-GUESTS=3D0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dcw@f00f.org;X-NUM-GUESTS=3D0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DEric Blake;X-NUM-GUESTS=3D0:mailto:eblake@redhat.com
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
 TRUE;CN=3DPaolo Bonzini;X-NUM-GUESTS=3D0:mailto:pbonzini@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dpeter.maydell@linaro.org;X-NUM-GUESTS=3D0:mailto:peter.maydell@l=
inaro
 .org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Drichard.henderson@linaro.org;X-NUM-GUESTS=3D0:mailto:richard.hen=
derso
 n@linaro.org
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
 TRUE;CN=3Dphilmd@linaro.org;X-NUM-GUESTS=3D0:mailto:philmd@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deblot@rivosinc.com;X-NUM-GUESTS=3D0:mailto:eblot@rivosinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmax.chou@sifive.com;X-NUM-GUESTS=3D0:mailto:max.chou@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dmanos.pitsidianakis@linaro.org;X-NUM-GUESTS=3D0:mailto:manos.pit=
sidia
 nakis@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DThomas Huth;X-NUM-GUESTS=3D0:mailto:thuth@redhat.com
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
 ;CN=3DAlberto Faria;X-NUM-GUESTS=3D0:mailto:afaria@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlbert Esteve;X-NUM-GUESTS=3D0:mailto:aesteve@redhat.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;RS=
VP=3DTRU
 E;CN=3Dhelge.deller@googlemail.com;X-NUM-GUESTS=3D0:mailto:helge.deller@go=
oglem
 ail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DCedric Le Goater;X-NUM-GUESTS=3D0:mailto:clg@redhat.com
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
LAST-MODIFIED:20260529T060257Z
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
END:VEVENT
END:VCALENDAR

--00000000000040aef60652ee99cf--

--00000000000040aef70652ee99d1
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjYwNTEyVDE0MDAwMFoNCkRURU5EOjIwMjYwNTEy
VDE1MDAwMFoNClJSVUxFOkZSRVE9V0VFS0xZO1dLU1Q9TU87VU5USUw9MjAyNjA2MDhUMjM1OTU5
WjtJTlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjYwNTI5VDA2MDMwNloNCk9SR0FOSVpF
UjtDTj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJrdTVzaTAx
YmxtbmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjN0bW41MXYzYXAxcGtiZXFq
NGRpdnVoNDZjX1IyMDI2MDUxMlQxNDAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7UlNWUD1UUlVF
DQogO0NOPWFsZXguYmVubmVlQGxpbmFyby5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsZXgu
YmVubmVlQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049TWFya3VzIEFy
bWJydXN0ZXI7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFybWJydUByZWRoYXQuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPWJjYWluQHF1aWNpbmMuY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpiY2FpbkBxdWljaW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86YmVycmFuZ2VAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1jamlhQG52aWRpYS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNqaWFAbnZpZGlh
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jd0BmMDBmLm9yZztYLU5VTS1HVUVT
VFM9MDptYWlsdG86Y3dAZjAwZi5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049RXJp
YyBCbGFrZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWJsYWtlQHJlZGhhdC5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzplZGdhci5pZ2xlc2lhc0BnbWFpbA0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049ZWR1YXJkb0BoYWJrb3N0Lm5ldDtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWR1
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
Q049bWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYnVydG9u
QHF0aS5xdWFsY29tbQ0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGF1bC53
YWxtc2xleUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYXVsLndhbG1zbGV5QHNp
Zml2ZQ0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049UGFvbG8gQm9uemluaTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOnBldGVyLm1heWRlbGxAbGluYXJvDQogLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpy
aWNoYXJkLmhlbmRlcnNvDQogbkBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPXNoZW50ZXlAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzaGVudGV5QGdtYWls
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1zdGVmYW5oYUBnbWFpbC5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOnN0ZWZhbmhhQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj13ZWkudy53YW5nQGludGVsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86d2Vp
Lncud2FuZ0BpbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049end1Lmtlcm5l
bEBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXBoaWxtZEBsaW5hcm8ub3JnO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpwaGlsbWRAbGluYXJvLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1lYmxvdEByaXZvc2luYy5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVibG90QHJpdm9zaW5j
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYXguY2hvdUBzaWZpdmUuY29tO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzptYXguY2hvdUBzaWZpdmUuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPW1hbm9zLnBpdHNpZGlhbmFraXNAbGluYXJvLm9yZztYLU5VTS1HVUVTVFM9
MDptYWlsdG86bWFub3MucGl0c2lkaWENCiBuYWtpc0BsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPVRob21hcyBIdXRoO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp0aHV0aEBy
ZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXJiY0BtZXRhLmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86cmJjQG1ldGEuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUxFVEVEO1JTVlA9VFJVRTsNCiBDTj1k
ZW1pb2Jlbm91ckBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmRlbWlvYmVub3VyQGdt
YWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1oaUBhbHlzc2EuaXM7WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOmhpQGFseXNzYS5pcw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1kaGVkZGVAa2FscmF5aW5jLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZGhlZGRlQGthbHJh
eWluYy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPURFQ0xJTkVEO1JTVlA9VFJVRQ0KIDtDTj1BbGJlcnRvIEZhcmlhO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzphZmFyaWFAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1BbGJlcnQgRXN0ZXZlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphZXN0ZXZlQHJlZGhhdC5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPUFDQ0VQVEVEO1JTVlA9VFJVRQ0KIDtDTj1tYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86bWFyY2FuZHJlLmx1cmVhdUBnbWFpbA0KIC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQ
VEVEO1JTVlA9VFJVRQ0KIDtDTj1tYXR0aGlldUBtaW5pby5pbztYLU5VTS1HVUVTVFM9MDptYWls
dG86bWF0dGhpZXVAbWluaW8uaW8NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO1JTVlA9VFJVRQ0KIDtDTj1qYWNvYi5vdXJz
bGFuZEBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmphY29iLm91cnNsYW5kQGdtYWls
LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9VEVOVEFUSVZFO1JTVlA9VFJVDQogRTtDTj1oZWxnZS5kZWxsZXJAZ29vZ2xlbWFpbC5j
b207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmhlbGdlLmRlbGxlckBnb29nbGVtDQogYWlsLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1DZWRyaWMgTGUgR29hdGVyO1gtTlVNLUdVRVNU
Uz0wOm1haWx0bzpjbGdAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1B
bGlzdGFpciBGcmFuY2lzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbGlzdGFpci5mcmFuY2lzQHdk
Yy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049a29ucmFkLndpbGtAb3JhY2xlLmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86a29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1BbGVzc2FuZHJvIERpIEZlZGVyaWNvO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzphbGVAcmV2Lm5nDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUFudG9uIEpv
aGFuc3NvbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86YW5qb0ByZXYubmcNCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049Q2hhbyBQZW5nO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjaGFvLnAucGVu
Z0BsaW51eC5pbnRlbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
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
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPVNoYW1lZXJhbGkgS29sb3Ro
dW0gVGhvZGk7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnNoYW1lZXJhbGkua29sb3RodW0NCiAudGhv
ZGlAaHVhd2VpLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj16Lmh1b0AxMzkuY29t
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6Lmh1b0AxMzkuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPUxJVSBaaGl3ZWk7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnpoaXdlaV9saXVAbGlu
dXguYWxpYmFiYS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cWVtdS1kZXZlbEBu
b25nbnUub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmcNCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bmVsc29uLmhvQHdpbmRyaXZlci5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOm5lbHNvbi5ob0B3aW5kcml2ZXIuYw0KIG9tDQpYLU1JQ1JPU09GVC1D
RE8tT1dORVJBUFBUSUQ6MTEwNTg5MzM0DQpDUkVBVEVEOjIwMjMwMjIxVDE1Mzk1MFoNCkRFU0NS
SVBUSU9OOklmIHlvdSBuZWVkIGNhbGwgZGV0YWlsc1wsIHBsZWFzZSBjb250YWN0IG1lOiA8YSBo
cmVmPSJtYWlsdG86cQ0KIHVpbnRlbGFAcmVkaGF0LmNvbSI+YWxleC5iZW5uZWVAbGluYXJvLm9y
ZzwvYT4NCkxBU1QtTU9ESUZJRUQ6MjAyNjA1MjlUMDYwMjU3Wg0KTE9DQVRJT046aHR0cHM6Ly9t
ZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZw0KU0VRVUVOQ0U6Mg0KU1RBVFVTOkNPTkZJUk1FRA0K
U1VNTUFSWTpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFV
RQ0KQVRUQUNIO0ZJTEVOQU1FPU5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVu
Y2UgY2FsbDtGTVRUWVBFPWFwcGxpY2ENCiB0aW9uL3ZuZC5nb29nbGUtYXBwcy5kb2N1bWVudDpo
dHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHoNCiB4Q2NjZnFmTk5L
Y01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVIN
Cg==
--00000000000040aef70652ee99d1--


