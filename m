Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364DDC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 09:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJz0-00049D-7T; Wed, 12 Jun 2024 05:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vWVpZgsKCmgGRKd.HKTTKKROTGXU.UXMWKSa-JKbKRTUTMTa.UXM@calendar-server.bounces.google.com>)
 id 1sHJyx-00048b-VD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:09:28 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vWVpZgsKCmgGRKd.HKTTKKROTGXU.UXMWKSa-JKbKRTUTMTa.UXM@calendar-server.bounces.google.com>)
 id 1sHJyt-0007eW-CN
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:09:26 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-421759c3556so3353835e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718183357; x=1718788157; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pD1s1w8WhtLV2PkFphT4roYfVwJruDrtiohcLLlwX6U=;
 b=OAp+PfckI5/UdmutA7tDAaP7AMw+6Ks3OOWmNRWV7r3ltG2HEO4n3PBdUhleN8KJcn
 l43vtaB1R9EiqcO8kQGzQtoav3lvCLdfhBcNyn7mR+5Wj6LOEqlxnLLr/pkqh7nJ9swP
 tQ0LwxCgXESftUdcPPoelO54cyfcvca2Xb7FJAuabAcZt51/yjiLI8hg+6yyArffD/AK
 06pdCjwJugEj2kmdbiSx8OWgIETm44DqZjjsYLNGmsIjxs2HEc1XZUxlZGody3Kl3chT
 KSCiy3nisqvTg4zW8HG+7/+UkCuwL+ObxCFtgdnkQ8CkSdYAsThEaWo9U8X+GMwNepKl
 ythQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718183357; x=1718788157; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pD1s1w8WhtLV2PkFphT4roYfVwJruDrtiohcLLlwX6U=;
 b=tWo5K7h5Hqg+sImwryKnReNnt8c+naFKmXBkngPs5OhXIjmJY+YiR/kmfELWwsMxDE
 3/EEBvlnSUxuYr0Q4o9Akr61K6tzj5Pxo47SIbYt4oFjTMn4m3Y827MTtrTFzXME13FF
 sDuxQgGiwkefor6tWmbMU36Pdakqy8SWJDozVhoxiXV+mFlJRSVhVC/1wXJ4jw91Uhh1
 xgOtX7DFpCwLZVf2vFq5zlkS5p7+gS6ict3WAqLKSaaOd92eu3OrF+M6AXNcXQUqhFZG
 G6Ao/41Cm8oHWPJFblnDSJDK7ZxOnSvpoQB6/qgjMEGbc6kftgoNPmGAtmRMBRPWW7RE
 TUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718183357; x=1718788157;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pD1s1w8WhtLV2PkFphT4roYfVwJruDrtiohcLLlwX6U=;
 b=pVMaU39X8gLQtA+GgS0S4BB+x7r+5NGsl+ubniiCQ5GQ3Zf7xvT2gwBV5cMZ0AfVHh
 MbcE92+chsvcf3V608QPPXBBpTz5WTNYpPipy3UWZSikJI2bDoH547lmx8/VADD60Nbz
 20IVW7DoC5kUeSfZGueFvCAcVnzDdeHcMjxGzT30YcT1y8l8XrWGIE3kljf7yPiqSenu
 +hBCVpe/RPHHdKz8DBvuamkSPBaCEkosPEuclWtCvfY/GUEPOVApr+Zrck4uG0jFliyJ
 phlwFr4z72VFrHn+IJkA7F4bS5LSKPO+nWPgbLvJOoQzlpSt3ESODkJ1SBQI4jcGLNFw
 cTpA==
X-Gm-Message-State: AOJu0YxMyu5eIemdWYfL+OnJLq1qiyuVeTEsT1aRNAThD3Ou6DU7Wi5s
 Xfril3kATDPm9wSvh59dRphNYMnQjeF13xN2AzgKLoruPwMqj4MUIZ6MdSMNit0QRmo27YRy3jt
 I6T3NtH3sj5gI2C9o5kKB+hPVb/yKwIDkSvJjAbjpfo0mbOXKkQ==
X-Google-Smtp-Source: AGHT+IGMq+evZAL/5KIXhSQI0pdWGl3BvNpjuv1NPROjV6+0UgS/OqMnqW835SmHZHXyVWdoEiamwm5E4g9LaLIJiWRN
MIME-Version: 1.0
X-Received: by 2002:a05:600c:470b:b0:421:805f:ab3c with SMTP id
 5b1f17b1804b1-4223c8cbc89mr51773605e9.14.1718183357214; Wed, 12 Jun 2024
 02:09:17 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-64c38c6f-e7af-4547-aab8-3481dfabdf2c@google.com>
Date: Wed, 12 Jun 2024 09:09:17 +0000
Subject: Updated invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 13:00 to 14:00 on Tuesday from Tue 19 Mar to Tue 11 Jun (GMT)
 (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>, 
 Alistair Francis <alistair.francis@wdc.com>, armbru@redhat.com,
 bcain@quicinc.com, berrange@redhat.com, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 cw@f00f.org, eblake@redhat.com, edgar.iglesias@gmail.com, eduardo@habkost.net, 
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, jgg@nvidia.com, 
 jidong.xiao@gmail.com, jim.shu@sifive.com, konrad.wilk@oracle.com, 
 mburton@qti.qualcomm.com, mdean@redhat.com, paul.walmsley@sifive.com, 
 pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, shentey@gmail.com,
 stefanha@gmail.com, wei.w.wang@intel.com, zwu.kernel@gmail.com, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, eblot@rivosinc.com, 
 max.chou@sifive.com, afaerber@suse.de, Anton Johansson <anjo@rev.ng>,
 bbauman@redhat.com, 
 Chao Peng <chao.p.peng@linux.intel.com>, Damien Hedde <dhedde@kalrayinc.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 jan.kiszka@web.de, 
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>, 
 Luc Michel <luc@lmichel.fr>, mimu@linux.vnet.ibm.com, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/mixed; boundary="000000000000aa9497061aadbcda"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3vWVpZgsKCmgGRKd.HKTTKKROTGXU.UXMWKSa-JKbKRTUTMTa.UXM@calendar-server.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000aa9497061aadbcda
Content-Type: multipart/alternative; boundary="000000000000aa9495061aadbcd8"

--000000000000aa9495061aadbcd8
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiB1cGRhdGVkDQpDaGFuZ2VkOiB0aW1lDQoNCg0KUUVNVS9LVk0g
ZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwNCkV2ZXJ5IDIgd2Vla3MgZnJvbSAxMzowMCB0byAx
NDowMCBvbiBUdWVzZGF5IGZyb20gVHVlc2RheSAxOSBNYXIgdG8gVHVlc2RheSAgDQoxMSBKdW4N
ClVuaXRlZCBLaW5nZG9tIFRpbWUNCg0KTG9jYXRpb24NCmh0dHBzOi8vbWVldC5qaXQuc2kva3Zt
Y2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29nbGUuY29tL3VybD9xPWh0dHBzJTNBJTJGJTJG
bWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZzYT1EJnVzdD0xNzE4NjE1MzQwMDAwMDAwJnVz
Zz1BT3ZWYXczZUR5aW4wbGFIUl96QkVLN0lxVFU1DQoNCg0KDQpBdHRhY2htZW50cw0KTm90ZXMg
4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsICANCmh0dHBzOi8vZG9jcy5n
b29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxMenhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1T
SkJHUVpyZWsvZWRpdA0KDQpJZiB5b3UgbmVlZCBjYWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0
IG1lOiBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnDQoNCkd1ZXN0cw0KQWxlc3NhbmRybyBEaSBGZWRl
cmljbw0KQWxleCBCZW5uw6llDQpBbGlzdGFpciBGcmFuY2lzDQphcm1icnVAcmVkaGF0LmNvbQ0K
YmNhaW5AcXVpY2luYy5jb20NCmJlcnJhbmdlQHJlZGhhdC5jb20NCmNqaWFAbnZpZGlhLmNvbQ0K
Q8OpZHJpYyBMZSBHb2F0ZXINCmN3QGYwMGYub3JnDQplYmxha2VAcmVkaGF0LmNvbQ0KZWRnYXIu
aWdsZXNpYXNAZ21haWwuY29tDQplZHVhcmRvQGhhYmtvc3QubmV0DQpmZWxpcGVAbnV0YW5peC5j
b20NCmlnZ3lAdGhlaWdneS5jb20NCmltcEBic2RpbXAuY29tDQpqZ2dAbnZpZGlhLmNvbQ0Kamlk
b25nLnhpYW9AZ21haWwuY29tDQpqaW0uc2h1QHNpZml2ZS5jb20NCmtvbnJhZC53aWxrQG9yYWNs
ZS5jb20NCm1idXJ0b25AcXRpLnF1YWxjb21tLmNvbQ0KbWRlYW5AcmVkaGF0LmNvbQ0KcGF1bC53
YWxtc2xleUBzaWZpdmUuY29tDQpwYm9uemluaUByZWRoYXQuY29tDQpQZXRlciBNYXlkZWxsDQpS
aWNoYXJkIEhlbmRlcnNvbg0Kc2hlbnRleUBnbWFpbC5jb20NCnN0ZWZhbmhhQGdtYWlsLmNvbQ0K
d2VpLncud2FuZ0BpbnRlbC5jb20NCnp3dS5rZXJuZWxAZ21haWwuY29tDQpQaGlsIE1hdGhpZXUt
RGF1ZMOpDQplYmxvdEByaXZvc2luYy5jb20NCm1heC5jaG91QHNpZml2ZS5jb20NCmFmYWVyYmVy
QHN1c2UuZGUNCkFudG9uIEpvaGFuc3Nvbg0KYmJhdW1hbkByZWRoYXQuY29tDQpDaGFvIFBlbmcN
CkRhbWllbiBIZWRkZQ0KRWxlbmEgVWZpbXRzZXZhDQplcmljLmF1Z2VyQHJlZGhhdC5jb20NCmph
bi5raXN6a2FAd2ViLmRlDQpqamhlcm5lQGxpbnV4LnZuZXQuaWJtLmNvbQ0KSm9hbyBNYXJ0aW5z
DQpMdWMgTWljaGVsDQptaW11QGxpbnV4LnZuZXQuaWJtLmNvbQ0KU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaQ0Kei5odW9AMTM5LmNvbQ0KTElVIFpoaXdlaQ0KcWVtdS1kZXZlbEBub25nbnUub3Jn
DQpWaWV3IGFsbCBndWVzdCBpbmZvICANCmh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxl
bmRhci9ldmVudD9hY3Rpb249VklFVyZlaWQ9TVdkMmRXSTVORE0xYnpkb2NuSmxiVEJoTUhKaGJH
NXNOV2xmVWpJd01qUXdNekU1VkRFek1EQXdNQ0J4WlcxMUxXUmxkbVZzUUc1dmJtZHVkUzV2Y21j
JnRvaz1OVFFqWTE5ck5YQXliSEJuZG1Kd2RHUnBjbXQxTlhOcE1ERmliRzF1YTBCbmNtOTFjQzVq
WVd4bGJtUmhjaTVuYjI5bmJHVXVZMjl0WVRFek1URmlZelF3T0RNNVpURmtaVFptWXpJeU4yTTFN
REkxWTJOa09UY3paRFZoWkROak1nJmN0ej1FdXJvcGUlMkZMb25kb24maGw9ZW4mZXM9MA0KDQpS
ZXBseSBmb3IgcWVtdS1kZXZlbEBub25nbnUub3JnIGFuZCB2aWV3IG1vcmUgZGV0YWlscyAgDQpo
dHRwczovL2NhbGVuZGFyLmdvb2dsZS5jb20vY2FsZW5kYXIvZXZlbnQ/YWN0aW9uPVZJRVcmZWlk
PU1XZDJkV0k1TkRNMWJ6ZG9jbkpsYlRCaE1ISmhiRzVzTldsZlVqSXdNalF3TXpFNVZERXpNREF3
TUNCeFpXMTFMV1JsZG1Wc1FHNXZibWR1ZFM1dmNtYyZ0b2s9TlRRalkxOXJOWEF5YkhCbmRtSndk
R1JwY210MU5YTnBNREZpYkcxdWEwQm5jbTkxY0M1allXeGxibVJoY2k1bmIyOW5iR1V1WTI5dFlU
RXpNVEZpWXpRd09ETTVaVEZrWlRabVl6SXlOMk0xTURJMVkyTmtPVGN6WkRWaFpETmpNZyZjdHo9
RXVyb3BlJTJGTG9uZG9uJmhsPWVuJmVzPTANCllvdXIgYXR0ZW5kYW5jZSBpcyBvcHRpb25hbC4N
Cg0Kfn4vL35+DQpJbnZpdGF0aW9uIGZyb20gR29vZ2xlIENhbGVuZGFyOiBodHRwczovL2NhbGVu
ZGFyLmdvb2dsZS5jb20vY2FsZW5kYXIvDQoNCllvdSBhcmUgcmVjZWl2aW5nIHRoaXMgZW1haWwg
YmVjYXVzZSB5b3UgYXJlIGFuIGF0dGVuZGVlIG9uIHRoZSBldmVudC4gVG8gIA0Kc3RvcCByZWNl
aXZpbmcgZnV0dXJlIHVwZGF0ZXMgZm9yIHRoaXMgZXZlbnQsIGRlY2xpbmUgdGhpcyBldmVudC4N
Cg0KRm9yd2FyZGluZyB0aGlzIGludml0YXRpb24gY291bGQgYWxsb3cgYW55IHJlY2lwaWVudCB0
byBzZW5kIGEgcmVzcG9uc2UgdG8gIA0KdGhlIG9yZ2FuaXplciwgYmUgYWRkZWQgdG8gdGhlIGd1
ZXN0IGxpc3QsIGludml0ZSBvdGhlcnMgcmVnYXJkbGVzcyBvZiAgDQp0aGVpciBvd24gaW52aXRh
dGlvbiBzdGF0dXMsIG9yIG1vZGlmeSB5b3VyIFJTVlAuDQoNCkxlYXJuIG1vcmUgaHR0cHM6Ly9z
dXBwb3J0Lmdvb2dsZS5jb20vY2FsZW5kYXIvYW5zd2VyLzM3MTM1I2ZvcndhcmRpbmcNCg==
--000000000000aa9495061aadbcd8
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
entRescheduled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://=
schema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar=
"/></span><meta itemprop=3D"eventId/googleCalendar" content=3D"1gvub9435o7h=
rrem0a0ralnl5i_R20240319T130000"/><span style=3D"display: none; font-size: =
1px; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max=
-width: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develo=
pers conference call</span><meta itemprop=3D"url" content=3D"https://calend=
ar.google.com/calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbT=
BhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=
=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUu=
Y29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope=
%2FLondon&amp;hl=3Den&amp;es=3D0"/><span aria-hidden=3D"true"><time itempro=
p=3D"startDate" datetime=3D"20240319T130000Z"></time><time itemprop=3D"endD=
ate" datetime=3D"20240319T140000Z"></time></span><div style=3D"display: non=
e; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-height: 0;=
 width: 0; max-width: 0; opacity: 0; overflow: hidden;">If you need call de=
tails, please contact me: alex.bennee@linaro.org</div><table border=3D"0" c=
ellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" s=
tyle=3D"width:100%;" class=3D"body-container"><tbody><tr><td style=3D"" cla=
ss=3D"" align=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"=
height:16px;"><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true">=
 &nbsp; </div><!--[if mso | IE]></td></tr></table><![endif]--><table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"c=
enter" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"background-=
color: #e6f4ea;color: #0d5327;padding: 12px 32px; border-radius: 8px;font-f=
amily: Roboto, sans-serif;font-size: 14px; line-height: 20px;text-align: le=
ft;" class=3D"info-bar-inner"><span style=3D"font-weight: 700;">This event =
has been updated</span><br/><span style=3D"display:none" itemprop=3D"about"=
 itemscope itemtype=3D"http://schema.org/Thing/Clock"><meta itemprop=3D"des=
cription" content=3D"Time updated"/></span><div style=3D""><span style=3D"f=
ont-weight: 700;">Changed:</span> time</div></td></tr></tbody></table><!--[=
if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation"><tr><td height=3D"12" style=3D"height:12px;"><![endif]-->=
<div style=3D"height:12px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso =
| IE]></td></tr></table><![endif]--><table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%=
;" class=3D""><tbody><tr><td style=3D"border: solid 1px #dadce0; border-rad=
ius: 8px; direction: rtl; font-size: 0; padding: 24px 32px; text-align: lef=
t; vertical-align: top;" class=3D"main-container-inner"><!--[if mso | IE]><=
table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation=
"><tr><![endif]--><!--[if mso | IE]><td class=3D"" style=3D"vertical-align:=
top;width:37%;" ><![endif]--><div class=3D"column-per-37 outlook-group-fix"=
 style=3D"font-size: 13px; text-align: left; direction: ltr; display: inlin=
e-block; vertical-align: top; width: 100%;overflow: hidden; word-wrap: brea=
k-word;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pr=
esentation" width=3D"100%"><tbody><tr><td style=3D"vertical-align:top;paddi=
ng:0;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation" width=3D"100%"><tr><td style=3D"font-size: 0; padding: 0; text-al=
ign: left; word-break: break-word;;padding-bottom:0px;"><div style=3D"font-=
family: Roboto, sans-serif;font-size: 14px; line-height: 20px; mso-line-hei=
ght-rule: exactly; text-align: left;" class=3D"primary-text" role=3D"presen=
tation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pre=
sentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text=
" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weigh=
t: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Attachme=
nts</h2></td></tr></table></div></td></tr><tr><td style=3D"font-size: 0; pa=
dding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;pad=
ding-left: 1px; padding-right: 1px;"><table border=3D"0" cellpadding=3D"0" =
cellspacing=3D"0" role=3D"presentation" class=3D"attachment-chip" style=3D"=
border: solid 1px #dadce0; border-radius: 16px; border-collapse: separate; =
padding: 4px 0 4px 0;"><tr><td style=3D"padding: 3px 10px; height: 14px; wi=
dth: 14px;"><img src=3D"https://drive-thirdparty.googleusercontent.com/16/t=
ype/application/vnd.google-apps.document" width=3D"14" height=3D"14" alt=3D=
"" style=3D"display: inline-block; vertical-align: middle;"></td><td align=
=3D"left" style=3D"padding: 0; padding-left: 0; padding-right: 10px; max-wi=
dth: 160px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;=
"><div style=3D"overflow: hidden; height: 20px;"><a href=3D"https://docs.go=
ogle.com/document/d/1-Ltq11LLzxCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit" targ=
et=3D"_blank" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;,=
 Roboto, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso=
-line-height-rule: exactly; margin: 0; text-decoration: none; text-transfor=
m: none;;font-family: Roboto, sans-serif;; display: inline-block; height: 2=
0px; max-width: 160px; line-height: 20px; overflow: hidden; text-overflow: =
ellipsis; vertical-align: middle; white-space: normal;" class=3D"grey-butto=
n-text" title=3D"Notes =E2=80=93 QEMU/KVM developers conference call">Notes=
 =E2=80=93 QEMU/KVM devel...</a></div></td></tr></table></td></tr></table><=
/td></tr></tbody></table></div><!--[if mso | IE]></td><![endif]--><!--[if m=
so | IE]><td class=3D"" style=3D"vertical-align:top;width:63%;padding-right=
:32px;" ><![endif]--><div class=3D"column-per-63 outlook-group-fix" style=
=3D"font-size: 13px; text-align: left; direction: ltr; display: inline-bloc=
k; vertical-align: top; width: 100%;overflow: hidden; word-wrap: break-word=
;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presenta=
tion" width=3D"100%" class=3D"main-column-table-ltr" style=3D"padding-right=
: 32px; padding-left: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main=
-column-td" style=3D"padding:0; vertical-align:top;"><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" styl=
e=3D"table-layout: fixed;"><tr><td style=3D"font-size: 0; padding: 0; text-=
align: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"fo=
nt-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-si=
ze: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-dec=
oration: none;" class=3D"primary-text" role=3D"presentation"><span>If you n=
eed call details, please contact me: <a href=3D"mailto:quintela@redhat.com"=
 target=3D"_blank">alex.bennee@linaro.org</a></span><meta itemprop=3D"descr=
iption" content=3D"If you need call details, please contact me: alex.bennee=
@linaro.org"/></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; te=
xt-align: left; word-break: break-word;;padding-bottom:24px;"><div style=3D=
"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font=
-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-=
decoration: none;" class=3D"primary-text" role=3D"presentation"><span aria-=
hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20240319T130000Z">=
</time><time itemprop=3D"endDate" datetime=3D"20240319T140000Z"></time></sp=
an><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presenta=
tion" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" sty=
le=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 70=
0;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">When</h2></td=
><td style=3D"width: 8px;"></td><td style=3D"padding-top: 2px; padding-bott=
om: 3px;"><div style=3D"background-color: #1e8e3e; border-radius: 10px; pad=
ding: 1px 5px; line-height: 13px;"><span style=3D"color: white; font-size: =
11px; font-weight: 700; letter-spacing: 0.8px; text-transform: uppercase; v=
ertical-align: top;">CHANGED</span></div></td></tr></table><span>Every 2 we=
eks from 13:00 to 14:00 on Tuesday from Tuesday 19 Mar to Tuesday 11 Jun (U=
nited Kingdom Time)<br/><span style=3D"text-decoration: line-through;"><del=
><span style=3D"display: none; font-size: 1px; color: #fff; line-height: 1p=
x; height: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; overflow: =
hidden;font-size: 0; display: block;">Old: </span>Every 2 weeks from 13:00 =
to 14:00 on Tuesday (United Kingdom Time)</del></span></span></div></td></t=
r><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: =
break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-s=
erif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20=
px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"=
primary-text" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><=
td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text=
-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;marg=
in: 0; padding: 0;">Location</h2></td></tr></table><span itemprop=3D"locati=
on" itemscope itemtype=3D"http://schema.org/Place"><span itemprop=3D"name" =
class=3D"primary-text notranslate" style=3D"font-family: Roboto, sans-serif=
;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; =
letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">https://meet.=
jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.com/url?q=3D=
https%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D17186153400=
00000&amp;usg=3DAOvVaw3eDyin0laHR_zBEK7IqTU5" class=3D"accent-text underlin=
e-on-hover" style=3D"display: inline-block;;color: #1a73e8; text-decoration=
: none;font-weight: 700;" target=3D"_blank" itemprop=3D"map">View map</a></=
span></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align:=
 left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-fam=
ily: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14=
px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoratio=
n: none;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-=
bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;c=
olor: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothin=
g: antialiased;margin: 0; padding: 0;">Guests</h2></td></tr></table><div st=
yle=3D"padding-bottom: 4px; text-align: left;;color: #3c4042;"><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:ale@rev.ng">Alessandro Di Federico</a></span><meta it=
emprop=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"secondary-te=
xt" style=3D"color: #70757a; text-decoration: none;"></span></div><div><spa=
n itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><sp=
an itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underli=
ne-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoratio=
n: none;" href=3D"mailto:alex.bennee@linaro.org">Alex Benn=C3=A9e</a></span=
><meta itemprop=3D"email" content=3D"alex.bennee@linaro.org"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:alistair.francis@wdc.com">Ali=
stair Francis</a></span><meta itemprop=3D"email" content=3D"alistair.franci=
s@wdc.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:armb=
ru@redhat.com">armbru@redhat.com</a></span><meta itemprop=3D"email" content=
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
ation: none;" href=3D"mailto:afaerber@suse.de">afaerber@suse.de</a></span><=
meta itemprop=3D"email" content=3D"afaerber@suse.de"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:anjo@rev.ng">Anton Johansson</a></spa=
n><meta itemprop=3D"email" content=3D"anjo@rev.ng"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:bbauman@redhat.com">bbauman@redhat.com<=
/a></span><meta itemprop=3D"email" content=3D"bbauman@redhat.com"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:chao.p.peng@linux.intel.=
com">Chao Peng</a></span><meta itemprop=3D"email" content=3D"chao.p.peng@li=
nux.intel.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
dhedde@kalrayinc.com">Damien Hedde</a></span><meta itemprop=3D"email" conte=
nt=3D"dhedde@kalrayinc.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva</a></span><meta =
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
lto:jjherne@linux.vnet.ibm.com">jjherne@linux.vnet.ibm.com</a></span><meta =
itemprop=3D"email" content=3D"jjherne@linux.vnet.ibm.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:joao.m.martins@oracle.com">Joao =
Martins</a></span><meta itemprop=3D"email" content=3D"joao.m.martins@oracle=
.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:luc@lmich=
el.fr">Luc Michel</a></span><meta itemprop=3D"email" content=3D"luc@lmichel=
.fr"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mimu@linux=
.vnet.ibm.com">mimu@linux.vnet.ibm.com</a></span><meta itemprop=3D"email" c=
ontent=3D"mimu@linux.vnet.ibm.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:shameerali.kolothum.thodi@huawei.com">Shameerali Koloth=
um Thodi</a></span><meta itemprop=3D"email" content=3D"shameerali.kolothum.=
thodi@huawei.com"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:z.huo@139.com">z.huo@139.com</a></span><meta itemprop=3D"email" content=
=3D"z.huo@139.com"/></span><span class=3D"secondary-text" style=3D"color: #=
70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attende=
e" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" =
class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D=
"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mai=
lto:zhiwei_liu@linux.alibaba.com">LIU Zhiwei</a></span><meta itemprop=3D"em=
ail" content=3D"zhiwei_liu@linux.alibaba.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org=
</a></span><meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div></div><a href=3D"https://calendar.google.com/calendar/=
event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwM=
zE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAybHBndmJwdG=
Rpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYTEzMTFiYzQwODM5ZTFkZ=
TZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp=
;es=3D0" style=3D"display: inline-block;;color: #1a73e8; text-decoration: n=
one;font-weight: 700;" target=3D"_blank" class=3D"accent-text underline-on-=
hover">View all guest info</a></div></td></tr><tr><td style=3D"font-size: 0=
; padding: 0; text-align: left; word-break: break-word;;padding-bottom:0px;=
"><div style=3D"color: #3c4043; text-decoration: none;;font-family: Roboto,=
 sans-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exact=
ly; text-align: left;" class=3D"primary-text"><div><span style=3D"font-weig=
ht: 700;-webkit-font-smoothing: antialiased;">RSVP</span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"> for <a class=
=3D"secondary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #70757a; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org">q=
emu-devel@nongnu.org</a> for all events in this series</span></div></div></=
td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-b=
reak: break-word;;padding-bottom:16px;"><div style=3D"font-family: Roboto, =
sans-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exactl=
y; text-align: left;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"=
0" role=3D"presentation" style=3D"border-collapse: separate;"><tr><td style=
=3D"padding-top: 8px; padding-left: 0; padding-right: 12px;"><!-- RSVP butt=
ons --><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-c=
ollapse: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;;d=
isplay: inline-block;;margin-right: 12px; margin-left: 0;"><tr><td align=3D=
"center" vertical-align=3D"middle" role=3D"presentation"><span itemprop=3D"=
potentialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta =
itemprop=3D"attendance" content=3D"http://schema.org/RsvpAttendance/Yes"/><=
span itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActio=
nHandler"><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMe=
thod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.goog=
le.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMH=
JhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&a=
mp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb2=
9nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3D=
Europe%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-fami=
ly: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14=
px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decor=
ation: none; text-transform: none;" class=3D"grey-button-text" itemprop=3D"=
url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0" role=3D"presentation"><tr><td align=3D"center" role=3D"presentation" va=
lign=3D"middle" style=3D"padding: 6px 0; padding-left: 16px; padding-right:=
 12px; white-space: nowrap;"><!--[if mso]><a href=3D"https://calendar.googl=
e.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJ=
hbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D1&am=
p;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29=
nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DE=
urope%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=
=3D"url" target=3D"_blank"><![endif]--><span class=3D"grey-button-text" sty=
le=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-ser=
if;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule=
: exactly; margin: 0; text-decoration: none; text-transform: none;">Yes</sp=
an><!--[if mso]></a><![endif]--></td></tr></table></a></span></span></span>=
</td><td align=3D"center" vertical-align=3D"middle" role=3D"presentation" s=
tyle=3D"border-left: solid 1px #dadce0; border-right: solid 1px #dadce0;"><=
span itemprop=3D"potentialaction" itemscope itemtype=3D"http://schema.org/R=
svpAction"><meta itemprop=3D"attendance" content=3D"http://schema.org/RsvpA=
ttendance/No"/><span itemprop=3D"handler" itemscope itemtype=3D"http://sche=
ma.org/HttpActionHandler"><link itemprop=3D"method" href=3D"http://schema.o=
rg/HttpRequestMethod/GET"/><span style=3D"color: #5f6367;"><a href=3D"https=
://calendar.google.com/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5ND=
M1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vc=
mc&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC=
5jYWxlbmRhci5nb29nbGUuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZ=
DNjMg&amp;ctz=3DEurope%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weigh=
t: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f636=
8; font-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margi=
n: 0; text-decoration: none; text-transform: none;" class=3D"grey-button-te=
xt" itemprop=3D"url" target=3D"_blank"><table border=3D"0" cellpadding=3D"0=
" cellspacing=3D"0" role=3D"presentation"><tr><td align=3D"center" role=3D"=
presentation" valign=3D"middle" style=3D"padding: 6px 12px; white-space: no=
wrap;"><!--[if mso]><a href=3D"https://calendar.google.com/calendar/event?a=
ction=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwMzE5V=
DEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D2&amp;tok=3DNTQjY19rNXAybH=
BndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYTEzMTFiYzQwO=
DM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope%2FLondon&amp;hl=
=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"url" target=3D"_bl=
ank"><![endif]--><span class=3D"grey-button-text" style=3D"font-weight: 400=
;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; fon=
t-size: 14px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; =
text-decoration: none; text-transform: none;">No</span><!--[if mso]></a><![=
endif]--></td></tr></table></a></span></span></span></td><td align=3D"cente=
r" vertical-align=3D"middle" role=3D"presentation"><span itemprop=3D"potent=
ialaction" itemscope itemtype=3D"http://schema.org/RsvpAction"><meta itempr=
op=3D"attendance" content=3D"http://schema.org/RsvpAttendance/Maybe"/><span=
 itemprop=3D"handler" itemscope itemtype=3D"http://schema.org/HttpActionHan=
dler"><link itemprop=3D"method" href=3D"http://schema.org/HttpRequestMethod=
/GET"/><span style=3D"color: #5f6367;"><a href=3D"https://calendar.google.c=
om/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG=
5sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;t=
ok=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbG=
UuY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEuro=
pe%2FLondon&amp;hl=3Den&amp;es=3D0" style=3D"font-weight: 400;font-family: =
&#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px; =
line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decoratio=
n: none; text-transform: none;" class=3D"grey-button-text" itemprop=3D"url"=
 target=3D"_blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" =
role=3D"presentation"><tr><td align=3D"center" role=3D"presentation" valign=
=3D"middle" style=3D"padding: 6px 0; padding-left: 12px; padding-right: 16p=
x; white-space: nowrap;"><!--[if mso]><a href=3D"https://calendar.google.co=
m/calendar/event?action=3DRESPOND&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5=
sNWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;rst=3D3&amp;to=
k=3DNTQjY19rNXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGU=
uY29tYTEzMTFiYzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurop=
e%2FLondon&amp;hl=3Den&amp;es=3D0" class=3D"grey-button-text" itemprop=3D"u=
rl" target=3D"_blank"><![endif]--><span class=3D"grey-button-text" style=3D=
"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;co=
lor: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-rule: exa=
ctly; margin: 0; text-decoration: none; text-transform: none;">Maybe</span>=
<!--[if mso]></a><![endif]--></td></tr></table></a></span></span></span></t=
d></tr></table><!-- More options --><a href=3D"https://calendar.google.com/=
calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlf=
UjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rNXAyb=
HBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYTEzMTFiYzQw=
ODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope%2FLondon&amp;hl=
=3Den&amp;es=3D0" style=3D"display: inline-block;;font-weight: 400;font-fam=
ily: &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 1=
4px; line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-deco=
ration: none; text-transform: none;" class=3D"grey-button-text" target=3D"_=
blank"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation" style=3D"border: solid 1px #dadce0; border-radius: 16px; border-c=
ollapse: separate;font-family: &#39;Google Sans&#39;, Roboto, sans-serif;">=
<tr><td align=3D"center" vertical-align=3D"middle" role=3D"presentation" st=
yle=3D"padding: 6px 0; padding-left: 16px; padding-right: 12px; white-space=
: nowrap;;color: #5f6367;"><!--[if mso]><a href=3D"https://calendar.google.=
com/calendar/event?action=3DVIEW&amp;eid=3DMWd2dWI5NDM1bzdocnJlbTBhMHJhbG5s=
NWlfUjIwMjQwMzE5VDEzMDAwMCBxZW11LWRldmVsQG5vbmdudS5vcmc&amp;tok=3DNTQjY19rN=
XAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29tYTEzMTFi=
YzQwODM5ZTFkZTZmYzIyN2M1MDI1Y2NkOTczZDVhZDNjMg&amp;ctz=3DEurope%2FLondon&am=
p;hl=3Den&amp;es=3D0" class=3D"grey-button-text" target=3D"_blank"><![endif=
]--><span class=3D"grey-button-text" style=3D"font-weight: 400;font-family:=
 &#39;Google Sans&#39;, Roboto, sans-serif;color: #5f6368; font-size: 14px;=
 line-height: 120%; mso-line-height-rule: exactly; margin: 0; text-decorati=
on: none; text-transform: none;">More options</span><!--[if mso]></a><![end=
if]--></td></tr></table></a></td></tr></table></div></td></tr></table></td>=
</tr></tbody></table></div><!--[if mso | IE]></td><![endif]--><!--[if mso |=
 IE]></tr></table><![endif]--></td></tr></tbody></table><table border=3D"0"=
 cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center"=
 style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"font-size: 0; pad=
ding: 0; text-align: left; word-break: break-word;;padding:4px 12px;" class=
=3D"" align=3D"left"><div class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;font-family: Roboto, sans-serif;font-size: 12px; lin=
e-height: 16px; mso-line-height-rule: exactly; text-align: left;"><p>Invita=
tion from <a href=3D"https://calendar.google.com/calendar/" class=3D"accent=
-text underline-on-hover" style=3D"font-family: Roboto, sans-serif;font-siz=
e: 12px; line-height: 16px; mso-line-height-rule: exactly;;color: #1a73e8; =
text-decoration: none;" target=3D"_blank">Google Calendar</a></p><p>You are=
 receiving this email because you are an attendee on the event. To stop rec=
eiving future updates for this event, decline this event.</p><p>Forwarding =
this invitation could allow any recipient to send a response to the organiz=
er, be added to the guest list, invite others regardless of their own invit=
ation status, or modify your RSVP. <a class=3D"accent-text underline-on-hov=
er" style=3D"font-family: Roboto, sans-serif;font-size: 12px; line-height: =
16px; mso-line-height-rule: exactly;;color: #1a73e8; text-decoration: none;=
" href=3D"https://support.google.com/calendar/answer/37135#forwarding">Lear=
n more</a></p></div></td></tr></tbody></table></td></tr></tbody></table></s=
pan></span></body></html>
--000000000000aa9495061aadbcd8
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
RRULE:FREQ=3DWEEKLY;WKST=3DMO;UNTIL=3D20240611T035959Z;INTERVAL=3D2;BYDAY=
=3DTU
DTSTAMP:20240612T090916Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20240319T130000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlessandro Di Federico;X-NUM-GUESTS=3D0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;X-NUM-GUESTS=3D0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlistair Francis;X-NUM-GUESTS=3D0:mailto:alistair.francis@wdc.co=
m
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
 TRUE;X-NUM-GUESTS=3D0:mailto:clg@kaod.org
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
X-MICROSOFT-CDO-OWNERAPPTID:-1337962242
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20240612T090905Z
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

--000000000000aa9495061aadbcd8--

--000000000000aa9497061aadbcda
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
aWNhL05ld19Zb3JrOjIwMjQwMzE5VDEwMDAwMA0KUlJVTEU6RlJFUT1XRUVLTFk7V0tTVD1NTztV
TlRJTD0yMDI0MDYxMVQwMzU5NTlaO0lOVEVSVkFMPTI7QllEQVk9VFUNCkRUU1RBTVA6MjAyNDA2
MTJUMDkwOTE2Wg0KT1JHQU5JWkVSO0NOPVFFTVUgUHJvamVjdCBDYWxlbmRhcjptYWlsdG86Y19r
NXAybHBndmJwdGRpcmt1NXNpMDFibG1ua0Bncm91DQogcC5jYWxlbmRhci5nb29nbGUuY29tDQpV
SUQ6MWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfUjIwMjQwMzE5VDEzMDAwMEBnb29nbGUuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUFsZXNzYW5kcm8gRGkgRmVkZXJpY287WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmFsZUByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsZXguYmVubmVlQGxpbmFyby5vcmcNCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049QWxpc3RhaXIgRnJhbmNpcztYLU5VTS1HVUVTVFM9MDptYWlsdG86
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWFy
bWJydUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphcm1icnVAcmVkaGF0LmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1iY2FpbkBxdWljaW5jLmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86YmNhaW5AcXVpY2luYy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049YmVycmFuZ2VAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YmVycmFuZ2VAcmVk
aGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1jamlhQG52aWRpYS5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmNqaWFAbnZpZGlhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2xnQGthb2Qub3JnDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPWN3QGYwMGYub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjd0BmMDBmLm9y
Zw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lYmxha2VAcmVkaGF0LmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86ZWJsYWtlQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklE
VUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRS
VUU7Q049ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplZGdh
ci5pZ2xlc2lhc0BnbWFpbA0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049ZWR1YXJk
b0BoYWJrb3N0Lm5ldDtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWR1YXJkb0BoYWJrb3N0Lm5ldA0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1mZWxpcGVAbnV0YW5peC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmZlbGlwZUBudXRhbml4LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1pZ2d5QHRoZWlnZ3kuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzppZ2d5QHRoZWlnZ3ku
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWltcEBic2RpbXAuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzppbXBAYnNkaW1wLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj1qZ2dAbnZpZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amdnQG52aWRpYS5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amlkb25nLnhpYW9AZ21haWwuY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzpqaWRvbmcueGlhb0BnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049amltLnNodUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqaW0uc2h1
QHNpZml2ZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049a29ucmFkLndpbGtAb3Jh
Y2xlLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86a29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYnVydG9uQHF0aS5xdWFsY29tbS5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOm1idXJ0b25AcXRpLnF1YWxjb21tDQogLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7UlNW
UD1UUlVFDQogO0NOPW1kZWFuQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1kZWFu
QHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049cGF1bC53YWxtc2xleUBzaWZp
dmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYXVsLndhbG1zbGV5QHNpZml2ZS5jbw0KIG0N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGJvbnppbmlAcmVkaGF0LmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1QZXRlciBNYXlkZWxsO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049UmljaGFyZCBIZW5kZXJz
b247WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcg0KIGcN
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PVRFTlRBVElWRTtSU1ZQPVRSVQ0KIEU7Q049c2hlbnRleUBnbWFpbC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnNoZW50ZXlAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJVkU7UlNWUD1UUlUNCiBFO0NOPXN0
ZWZhbmhhQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c3RlZmFuaGFAZ21haWwuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXdlaS53LndhbmdAaW50ZWwuY29tO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzp3ZWkudy53YW5nQGludGVsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj16d3Uua2VybmVsQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86end1
Lmtlcm5lbEBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnBoaWxtZEBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJVkU7UlNWUD1UUlUNCiBFO0NOPWVi
bG90QHJpdm9zaW5jLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWJsb3RAcml2b3NpbmMuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1heC5jaG91QHNpZml2ZS5jb207WC1OVU0t
R1VFU1RTPTA6bWFpbHRvOm1heC5jaG91QHNpZml2ZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049YWZhZXJiZXJAc3VzZS5kZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YWZhZXJiZXJA
c3VzZS5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1BbnRvbiBKb2hhbnNzb247WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmFuam9AcmV2Lm5nDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPWJiYXVtYW5AcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YmJhdW1hbkByZWRo
YXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUNoYW8gUGVuZztYLU5VTS1HVUVT
VFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRS
VUUNCiA7Q049RGFtaWVuIEhlZGRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpkaGVkZGVAa2FscmF5
aW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1FbGVuYSBVZmltdHNldmE7WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPWVyaWMuYXVnZXJAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PWphbi5raXN6a2FAd2ViLmRlO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqYW4ua2lzemthQHdlYi5k
ZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qamhlcm5lQGxpbnV4LnZuZXQuaWJtLmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ampoZXJuZUBsaW51eC52bmV0DQogLmlibS5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049Sm9hbyBNYXJ0aW5zO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPUx1YyBNaWNoZWw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmx1Y0BsbWljaGVsLmZyDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1pbXVAbGludXgudm5ldC5pYm0uY29tO1gtTlVNLUdV
RVNUUz0wOm1haWx0bzptaW11QGxpbnV4LnZuZXQuaWJtLmMNCiBvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1TaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpzaGFtZWVyYWxpLmtvbG90aHVtDQogLnRob2RpQGh1YXdlaS5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049ei5odW9AMTM5LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ei5o
dW9AMTM5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1MSVUgWmhpd2VpO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzp6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPXFlbXUtZGV2ZWxAbm9uZ251Lm9yZztYLU5VTS1HVUVTVFM9MDpt
YWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpYLU1JQ1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6
LTEzMzc5NjIyNDINCkNSRUFURUQ6MjAyMzAyMjFUMTUzOTUwWg0KREVTQ1JJUFRJT046SWYgeW91
IG5lZWQgY2FsbCBkZXRhaWxzXCwgcGxlYXNlIGNvbnRhY3QgbWU6IDxhIGhyZWY9Im1haWx0bzpx
DQogdWludGVsYUByZWRoYXQuY29tIj5hbGV4LmJlbm5lZUBsaW5hcm8ub3JnPC9hPg0KTEFTVC1N
T0RJRklFRDoyMDI0MDYxMlQwOTA5MDVaDQpMT0NBVElPTjpodHRwczovL21lZXQuaml0LnNpL2t2
bWNhbGxtZWV0aW5nDQpTRVFVRU5DRTowDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOlFFTVUv
S1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsDQpUUkFOU1A6T1BBUVVFDQpBVFRBQ0g7RklM
RU5BTUU9Tm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsO0ZNVFRZ
UEU9YXBwbGljYQ0KIHRpb24vdm5kLmdvb2dsZS1hcHBzLmRvY3VtZW50Omh0dHBzOi8vZG9jcy5n
b29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxMeg0KIHhDY2NmcWZOTktjTUc3NEhNVUpmNkRV
Um1TSkJHUVpyZWsvZWRpdA0KQkVHSU46VkFMQVJNDQpBQ1RJT046RU1BSUwNCkRFU0NSSVBUSU9O
OlRoaXMgaXMgYW4gZXZlbnQgcmVtaW5kZXINClNVTU1BUlk6QWxhcm0gbm90aWZpY2F0aW9uDQpB
VFRFTkRFRTptYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpUUklHR0VSOi1QMkQNCkVORDpW
QUxBUk0NCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--000000000000aa9497061aadbcda--

