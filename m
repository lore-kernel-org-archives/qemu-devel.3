Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FECE8305B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAiI-0002ka-7X; Tue, 03 Feb 2026 02:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdean@redhat.com>) id 1vnAiB-0002jL-SP
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:20:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdean@redhat.com>) id 1vnAi8-0008UV-CJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770103230;
 h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=nibCgGAXy1gWZ6xut6fF4/B8YGdSL3PuhBm1uR8gpW0=;
 b=AbQur4kCXD0p8Erwsl0IbDGQ9AJYZqDG7vd7PokcJhiNkWCqVWwTCfXzXrT/7JrTD+u+XM
 5d6kEJMwQExlTqcxBr0XJ7q/pxXVzGHGeRJR4B9c8jcBMR8xtN/I8yeu0wRWZOTxfpqrTl
 twPtFRF+SGbxF0s7zYInoe17wzmdI2c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-uMBH23R-NXqxgvH5zH0uiQ-1; Tue, 03 Feb 2026 02:19:21 -0500
X-MC-Unique: uMBH23R-NXqxgvH5zH0uiQ-1
X-Mimecast-MFC-AGG-ID: uMBH23R-NXqxgvH5zH0uiQ_1770103160
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee432070aso43096485e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 23:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1770103160; x=1770707960; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nibCgGAXy1gWZ6xut6fF4/B8YGdSL3PuhBm1uR8gpW0=;
 b=buST1avFIlY47+LMKFyyTOK+nxGYsoj5+tyjq5lQFsten9ywZnPpFFjq6isoqaiK0F
 dx47CyyuKHQLHuUmsWlw4xh0lDotLca4bNufA3ve0IKMi8axeV/b9Sr21yiFd3yv27Nx
 d1LxbhqzaHzGxA4FVaxYOB3IjIGFj2bsbDzuLcAvZgQT88X8iXPTHz8NKEx6TzXQFf79
 ay/LgxNChk2wKs85KrbrjahH9HGsujAGjx1M2GWZA0e1mvJrfv9SCIkapxbTmipzDaWO
 RN7rpcZ0Juia9EKjgTJ481LmOvNYm99BJA4LLD7aNj3VPQWqjeQLUN4L4FYOuCMAymgj
 Ll1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770103160; x=1770707960; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nibCgGAXy1gWZ6xut6fF4/B8YGdSL3PuhBm1uR8gpW0=;
 b=BfokKLyx/jWsV+4ILvqM776yE75PNwIejTGUzxmbNbXNQ4LzXKUBGU6E7epn9ChLxS
 G7C7Apap8CxUTWWz3LWwhY+m7Ev9imNK/Ulrj6R9NF9S+YaCFQxTuDN5r7FR7Ul6l4om
 IH867dx2rGjQj23iIREHfHmboEdUdMk5gWd9NBtDmxqfzzUpEbQdGSlB36KsPrW/yP9S
 AJCiBo56Q9k4kNfoLJcSZ4+pkvfOKZt1CPHuDj4FA2H0MW6ykKyKVx8v1IJOxKEuKIYz
 s2xTq7F+2x2m203FkZUWhb1Fnq8neeOLGjDbi6nq7UXFONanGuhVEp//OhPXd0oUtVyf
 3QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770103160; x=1770707960;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nibCgGAXy1gWZ6xut6fF4/B8YGdSL3PuhBm1uR8gpW0=;
 b=XEKCTX1nHDFpFfTUvCZi4GL89kBb079Mp4yaIMSUvSno+swc8DGza0+fDrmT0sURty
 cl1rhBNO28lB9oK1L9Tpfdtg5gUw0Du9a74Bx7Vg/r6hZjCf0dgsrQKH91QeqjavawEb
 M4OysIAmKmat2vqRExfHBQxsY+f/IsldwlmxqXD/ZMG0/P3sI3QLms3MvZXlBKv9XZlG
 +5i3SuKwW1SDWGHudqOQQEMroLz7YzYKbS6PIaoO0f95kNpaPvZAzRApdL4qQxZsKejU
 mpDz6P8kk1YY+5922nBnKqTWaeHVi0U5KoHbytffcAQxqUd0koMRCARgz82rOZFUIJOF
 fVqA==
X-Gm-Message-State: AOJu0Yw91/NuhokDhmXw8R/rcvpT1U1d/pkDwWN02VY/0WURFL5zT6RT
 tNygjda+NIJtHsBRC0nPwsdgAeBrV3HthNRCSMicmqCVxtJw6BugizbS15o/JW588OjP8hjDhS5
 K0TphJyYtOFT1+aXriFx8yWD1OVrsN48zCWIqfJHLg0f4iLrfISXaAsdTRGgdENhCzm2rK+C2Ky
 XYjMRkJPH6+/oYHbKz3vs/FcWpjQyFQ5HZA0kDkqJdGCXROBFp+AsKRsRo/8RpJb+9IC/s2iyD7
 WRKv7QzjDROKuF2FKg=
X-Gm-Gg: AZuq6aLB1vatX/mfrrnGPAGB/9LKCoezWcPAJaEBopk37FuHuRxDjhJyipI0jg6b8oP
 a10T0rGjOlxiT9g60TJcJ7KrIvEyv82XuGLNmfTRDWF3JpeiTp+QhLVsk2ErJgwzPo9y6C8UuUr
 KzzyExEhZNFeqadqXol6x7LyL+U2V361wJ4TexOpqmHvbIF7v4UMb59RIY6eyAn8B74yt22wGZH
 gwP2nTDLdvT1wnIHuJmqMgROq8=
X-Received: by 2002:a05:600c:3595:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-482db49252dmr192659555e9.19.1770103160260; 
 Mon, 02 Feb 2026 23:19:20 -0800 (PST)
MIME-Version: 1.0
X-Received: by 2002:a05:600c:3595:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-482db49252dmr192659285e9.19.1770103159663; Mon, 02 Feb 2026
 23:19:19 -0800 (PST)
Auto-Submitted: auto-generated
Message-ID: <calendar-85c623fd-c3df-448a-a153-2dd79121258b@google.com>
Date: Tue, 03 Feb 2026 07:19:19 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 4pm to 5pm on Tuesday (GMT+2) (qemu-devel@nongnu.org)
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="0000000000000c421e0649e64206"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mdean@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIMWL_WL_MED=-0.02, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Meirav Dean <mdean@redhat.com>
X-ACL-Warn: ,  Meirav Dean <mdean@redhat.com>
From:  Meirav Dean via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000000c421e0649e64206
Content-Type: multipart/alternative; boundary="0000000000000c421e0649e64204"

--0000000000000c421e0649e64204
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9t
IDRwbSB0byA1cG0gb24gVHVlc2RheQ0KSXNyYWVsIFRpbWUNCg0KTG9jYXRpb24NCmh0dHBzOi8v
bWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29nbGUuY29tL3VybD9x
PWh0dHBzJTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZzYT1EJnNvdXJjZT1j
YWxlbmRhciZ1c3Q9MTc3MDUzNTE0MDAwMDAwMCZ1c2c9QU92VmF3MGNnbkNYZ1E5NDFKbjJFOGNU
THZKaA0KDQoNCg0KQXR0YWNobWVudHMNCk5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNv
bmZlcmVuY2UgY2FsbCAgDQpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRx
MTFMTHp4Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCg0KSWYgeW91IG5l
ZWQgY2FsbCBkZXRhaWxzLCBwbGVhc2UgY29udGFjdCBtZTogYWxleC5iZW5uZWVAbGluYXJvLm9y
Zw0KDQpHdWVzdHMNCmFsZXguYmVubmVlQGxpbmFyby5vcmcgLSBjcmVhdG9yDQpNYXJrdXMgQXJt
YnJ1c3Rlcg0KYmNhaW5AcXVpY2luYy5jb20NCkRhbmllbCBCZXJyYW5nw6kNCmNqaWFAbnZpZGlh
LmNvbQ0KY3dAZjAwZi5vcmcNCkVyaWMgQmxha2UNCmVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbQ0K
ZWR1YXJkb0BoYWJrb3N0Lm5ldA0KZmVsaXBlQG51dGFuaXguY29tDQppZ2d5QHRoZWlnZ3kuY29t
DQppbXBAYnNkaW1wLmNvbQ0KamdnQG52aWRpYS5jb20NCmppZG9uZy54aWFvQGdtYWlsLmNvbQ0K
amltLnNodUBzaWZpdmUuY29tDQptYnVydG9uQHF0aS5xdWFsY29tbS5jb20NCk1laXJhdiBEZWFu
DQpwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20NClBhb2xvIEJvbnppbmkNCnBldGVyLm1heWRlbGxA
bGluYXJvLm9yZw0KcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZw0Kc2hlbnRleUBnbWFpbC5j
b20NCnN0ZWZhbmhhQGdtYWlsLmNvbQ0Kd2VpLncud2FuZ0BpbnRlbC5jb20NCnp3dS5rZXJuZWxA
Z21haWwuY29tDQpwaGlsbWRAbGluYXJvLm9yZw0KZWJsb3RAcml2b3NpbmMuY29tDQptYXguY2hv
dUBzaWZpdmUuY29tDQptYW5vcy5waXRzaWRpYW5ha2lzQGxpbmFyby5vcmcNClRob21hcyBIdXRo
DQpyYmNAbWV0YS5jb20NCmRlbWlvYmVub3VyQGdtYWlsLmNvbQ0KaGlAYWx5c3NhLmlzDQpkaGVk
ZGVAa2FscmF5aW5jLmNvbQ0KQWxiZXJ0byBGYXJpYQ0KQWxiZXJ0IEVzdGV2ZQ0KbWFyY2FuZHJl
Lmx1cmVhdUBnbWFpbC5jb20NCkFsaXN0YWlyIEZyYW5jaXMNCmtvbnJhZC53aWxrQG9yYWNsZS5j
b20NCkFsZXNzYW5kcm8gRGkgRmVkZXJpY28NCkPDqWRyaWMgTGUgR29hdGVyDQpBbnRvbiBKb2hh
bnNzb24NCkNoYW8gUGVuZw0KRWxlbmEgVWZpbXRzZXZhDQplcmljLmF1Z2VyQHJlZGhhdC5jb20N
Cmphbi5raXN6a2FAd2ViLmRlDQpKb2FvIE1hcnRpbnMNCkx1YyBNaWNoZWwNClNoYW1lZXJhbGkg
S29sb3RodW0gVGhvZGkNCnouaHVvQDEzOS5jb20NCkxJVSBaaGl3ZWkNCnFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KbmVsc29uLmhvQHdpbmRyaXZlci5jb20NCg0KDQp+fi8vfn4NCkludml0YXRpb24g
ZnJvbSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRh
ci8NCg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0
ZW5kZWUgb24gdGhlIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3VsZCBh
bGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5pemVy
LCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNzIG9m
ICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4NCg0K
TGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIvMzcx
MzUjZm9yd2FyZGluZw0K
--0000000000000c421e0649e64204
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
eqj4divuh46c"/><span style=3D"display: none; font-size: 1px; color: #fff; l=
ine-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity:=
 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM developers conference cal=
l</span><span aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D=
"20260106T140000Z"></time><time itemprop=3D"endDate" datetime=3D"20260106T1=
50000Z"></time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"=
0" role=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D"bo=
dy-container"><tbody><tr><td style=3D"" class=3D"" align=3D"left"><!--[if m=
so | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pr=
esentation"><tr><td height=3D"16" style=3D"height:16px;"><![endif]--><div s=
tyle=3D"height:16px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]>=
</td></tr></table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspa=
cing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" cla=
ss=3D""><tbody><tr><td style=3D"background-color: #fef7e0;color: #340f03;pa=
dding: 12px 32px; border-radius: 8px;font-family: Roboto, sans-serif;font-s=
ize: 14px; line-height: 20px;text-align: left;" class=3D"info-bar-inner"><s=
pan style=3D"font-weight: 700;">This email keeps the event up to date in yo=
ur calendar.</span><br><b>Set up inbox filters to hide this and similar cal=
endar sync emails.</b><br><a style=3D"text-decoration: underline !important=
; color: #340f03 !important;" href=3D"https://support.google.com/calendar?p=
=3Dfilter_invitations" target=3D"_blank">Learn more about calendar sync ema=
ils and setting up filters</a></td></tr></tbody></table><!--[if mso | IE]><=
table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation=
"><tr><td height=3D"12" style=3D"height:12px;"><![endif]--><div style=3D"he=
ight:12px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]></td></tr>=
</table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"=
 role=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><t=
body><tr><td style=3D"border: solid 1px #dadce0; border-radius: 8px; direct=
ion: rtl; font-size: 0; padding: 24px 32px; text-align: left; vertical-alig=
n: top;" class=3D"main-container-inner"><!--[if mso | IE]><table border=3D"=
0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><![endif]-=
-><!--[if mso | IE]><td class=3D"" style=3D"vertical-align:top;width:37%;" =
><![endif]--><div class=3D"column-per-37 outlook-group-fix" style=3D"font-s=
ize: 13px; text-align: left; direction: ltr; display: inline-block; vertica=
l-align: top; width: 100%;overflow: hidden; word-wrap: break-word;"><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" widt=
h=3D"100%"><tbody><tr><td style=3D"vertical-align:top;padding:0;"><table bo=
rder=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=
=3D"100%"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word=
-break: break-word;;padding-bottom:0px;"><div style=3D"font-family: Roboto,=
 sans-serif;font-size: 14px; line-height: 20px; mso-line-height-rule: exact=
ly; text-align: left;" class=3D"primary-text" role=3D"presentation"><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" styl=
e=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font=
-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-=
font-smoothing: antialiased;margin: 0; padding: 0;">Attachments</h2></td></=
tr></table></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-=
align: left; word-break: break-word;;padding-bottom:24px;padding-left: 1px;=
 padding-right: 1px;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"=
0" role=3D"presentation" class=3D"attachment-chip" style=3D"border: solid 1=
px #dadce0; border-radius: 16px; border-collapse: separate; padding: 4px 0 =
4px 0;"><tr><td style=3D"padding: 3px 10px; height: 14px; width: 14px;"><im=
g src=3D"https://drive-thirdparty.googleusercontent.com/16/type/application=
/vnd.google-apps.document" width=3D"14" height=3D"14" alt=3D"" style=3D"dis=
play: inline-block; vertical-align: middle;"></td><td align=3D"left" style=
=3D"padding: 0; padding-left: 0; padding-right: 10px; max-width: 160px; ove=
rflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><div style=3D=
"overflow: hidden; height: 20px;"><a href=3D"https://docs.google.com/docume=
nt/d/1-Ltq11LLzxCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit" target=3D"_blank" s=
tyle=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto, sans-s=
erif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-height-ru=
le: exactly; margin: 0; text-decoration: none; text-transform: none;;font-f=
amily: Roboto, sans-serif;; display: inline-block; height: 20px; max-width:=
 160px; line-height: 20px; overflow: hidden; text-overflow: ellipsis; verti=
cal-align: middle; white-space: normal;" class=3D"grey-button-text" title=
=3D"Notes =E2=80=93 QEMU/KVM developers conference call">Notes =E2=80=93 QE=
MU/KVM devel...</a></div></td></tr></table></td></tr></table></td></tr></tb=
ody></table></div><!--[if mso | IE]></td><![endif]--><!--[if mso | IE]><td =
class=3D"" style=3D"vertical-align:top;width:63%;padding-right:32px;" ><![e=
ndif]--><div class=3D"column-per-63 outlook-group-fix" style=3D"font-size: =
13px; text-align: left; direction: ltr; display: inline-block; vertical-ali=
gn: top; width: 100%;overflow: hidden; word-wrap: break-word;"><table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"=
100%" class=3D"main-column-table-ltr" style=3D"padding-right: 32px; padding=
-left: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main-column-td" sty=
le=3D"padding:0; vertical-align:top;"><table border=3D"0" cellpadding=3D"0"=
 cellspacing=3D"0" role=3D"presentation" width=3D"100%" style=3D"table-layo=
ut: fixed;"><tr><td style=3D"font-size: 0; padding: 0; text-align: left; wo=
rd-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: Robo=
to, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-=
height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;"=
 class=3D"primary-text" role=3D"presentation"><span>If you need call detail=
s, please contact me: <a href=3D"mailto:quintela@redhat.com" target=3D"_bla=
nk">alex.bennee@linaro.org</a></span><meta itemprop=3D"description" content=
=3D"If you need call details, please contact me: alex.bennee@linaro.org"/><=
/div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left;=
 word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family: R=
oboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; li=
ne-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: non=
e;" class=3D"primary-text" role=3D"presentation"><span aria-hidden=3D"true"=
><time itemprop=3D"startDate" datetime=3D"20260106T140000Z"></time><time it=
emprop=3D"endDate" datetime=3D"20260106T150000Z"></time></span><table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"=
padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size=
: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-=
smoothing: antialiased;margin: 0; padding: 0;">When</h2></td></tr></table><=
span>Every 2 weeks from 4pm to 5pm on Tuesday (Israel Time)</span></div></t=
d></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-br=
eak: break-word;;padding-bottom:24px;"><div style=3D"font-family: Roboto, s=
ans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-heigh=
t: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" clas=
s=3D"primary-text" role=3D"presentation"><table border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;">=
<tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;color: #3c4043;=
 text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased=
;margin: 0; padding: 0;">Location</h2></td></tr></table><span itemprop=3D"l=
ocation" itemscope itemtype=3D"http://schema.org/Place"><span itemprop=3D"n=
ame" class=3D"primary-text notranslate" style=3D"font-family: Roboto, sans-=
serif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 2=
0px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;">https://=
meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.google.com/url=
?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;source=3Dcal=
endar&amp;ust=3D1770535140000000&amp;usg=3DAOvVaw0cgnCXgQ941Jn2E8cTLvJh" cl=
ass=3D"accent-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #1a73e8; text-decoration: none;font-weight: 700;" target=3D"_blank" item=
prop=3D"map">View map</a></span></div></td></tr><tr><td style=3D"font-size:=
 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24=
px;"><div style=3D"font-family: Roboto, sans-serif;font-style: normal; font=
-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;col=
or: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D"present=
ation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pres=
entation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text"=
 style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight=
: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h=
2></td></tr></table><div style=3D"padding-bottom: 4px; text-align: left;;co=
lor: #3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:alex.bennee@linaro.org">al=
ex.bennee@linaro.org</a></span><meta itemprop=3D"email" content=3D"alex.ben=
nee@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"> - creator</span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:armbru@redhat.com">Markus Armbruster</a></span><meta itemprop=3D=
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
-decoration: none;" href=3D"mailto:berrange@redhat.com">Daniel Berrang=C3=
=A9</a></span><meta itemprop=3D"email" content=3D"berrange@redhat.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia.com">=
cjia@nvidia.com</a></span><meta itemprop=3D"email" content=3D"cjia@nvidia.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f00f.org=
">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.org"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redhat.com=
">Eric Blake</a></span><meta itemprop=3D"email" content=3D"eblake@redhat.co=
m"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:edgar.iglesi=
as@gmail.com">edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email" c=
ontent=3D"edgar.iglesias@gmail.com"/></span><span class=3D"secondary-text" =
style=3D"color: #70757a; text-decoration: none;"></span></div><div><span it=
emprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span i=
temprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-o=
n-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: n=
one;" href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</a></span><me=
ta itemprop=3D"email" content=3D"eduardo@habkost.net"/></span><span class=
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
ext-decoration: none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti=
.qualcomm.com</a></span><meta itemprop=3D"email" content=3D"mburton@qti.qua=
lcomm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:mdea=
n@redhat.com">Meirav Dean</a></span><meta itemprop=3D"email" content=3D"mde=
an@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #7075=
7a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" i=
temscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" clas=
s=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"dis=
play: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:=
paul.walmsley@sifive.com">paul.walmsley@sifive.com</a></span><meta itemprop=
=3D"email" content=3D"paul.walmsley@sifive.com"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Per=
son"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text=
 underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-d=
ecoration: none;" href=3D"mailto:pbonzini@redhat.com">Paolo Bonzini</a></sp=
an><meta itemprop=3D"email" content=3D"pbonzini@redhat.com"/></span><span c=
lass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></=
span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sc=
hema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"=
primary-text underline-on-hover" style=3D"display: inline-block;;color: #3c=
4043; text-decoration: none;" href=3D"mailto:peter.maydell@linaro.org">pete=
r.maydell@linaro.org</a></span><meta itemprop=3D"email" content=3D"peter.ma=
ydell@linaro.org"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a></span><me=
ta itemprop=3D"email" content=3D"richard.henderson@linaro.org"/></span><spa=
n class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"=
></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:/=
/schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:shentey@gmail.com">shentey=
@gmail.com</a></span><meta itemprop=3D"email" content=3D"shentey@gmail.com"=
/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decor=
ation: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemt=
ype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransla=
te"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-b=
lock;;color: #3c4043; text-decoration: none;" href=3D"mailto:stefanha@gmail=
.com">stefanha@gmail.com</a></span><meta itemprop=3D"email" content=3D"stef=
anha@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span><meta itemprop=3D"ema=
il" content=3D"wei.w.wang@intel.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kernel@gmail.com</a></span>=
<meta itemprop=3D"email" content=3D"zwu.kernel@gmail.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a></span><meta itemprop=3D"email" content=3D"philmd@linaro.org"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:eblot@rivosinc.com">=
eblot@rivosinc.com</a></span><meta itemprop=3D"email" content=3D"eblot@rivo=
sinc.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:max.c=
hou@sifive.com">max.chou@sifive.com</a></span><meta itemprop=3D"email" cont=
ent=3D"max.chou@sifive.com"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis@linaro.o=
rg</a></span><meta itemprop=3D"email" content=3D"manos.pitsidianakis@linaro=
.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:thuth@red=
hat.com">Thomas Huth</a></span><meta itemprop=3D"email" content=3D"thuth@re=
dhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:rbc@m=
eta.com">rbc@meta.com</a></span><meta itemprop=3D"email" content=3D"rbc@met=
a.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:demioben=
our@gmail.com">demiobenour@gmail.com</a></span><meta itemprop=3D"email" con=
tent=3D"demiobenour@gmail.com"/></span><span class=3D"secondary-text" style=
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
t-decoration: none;" href=3D"mailto:afaria@redhat.com">Alberto Faria</a></s=
pan><meta itemprop=3D"email" content=3D"afaria@redhat.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:aesteve@redhat.com">Albert Este=
ve</a></span><meta itemprop=3D"email" content=3D"aesteve@redhat.com"/></spa=
n><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"=
http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;c=
olor: #3c4043; text-decoration: none;" href=3D"mailto:marcandre.lureau@gmai=
l.com">marcandre.lureau@gmail.com</a></span><meta itemprop=3D"email" conten=
t=3D"marcandre.lureau@gmail.com"/></span><span class=3D"secondary-text" sty=
le=3D"color: #70757a; text-decoration: none;"></span></div><div><span itemp=
rop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span item=
prop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-h=
over" style=3D"display: inline-block;;color: #3c4043; text-decoration: none=
;" href=3D"mailto:alistair.francis@wdc.com">Alistair Francis</a></span><met=
a itemprop=3D"email" content=3D"alistair.francis@wdc.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:konrad.wilk@oracle.com">konrad.w=
ilk@oracle.com</a></span><meta itemprop=3D"email" content=3D"konrad.wilk@or=
acle.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:ale@r=
ev.ng">Alessandro Di Federico</a></span><meta itemprop=3D"email" content=3D=
"ale@rev.ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a=
; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" ite=
mscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:c=
lg@kaod.org">C=C3=A9dric Le Goater</a></span><meta itemprop=3D"email" conte=
nt=3D"clg@kaod.org"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:anjo@rev.ng">Anton Johansson</a></span><meta itemprop=3D"email" cont=
ent=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:chao.p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"e=
mail" content=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Elena Ufimtseva<=
/a></span><meta itemprop=3D"email" content=3D"elena.ufimtseva@oracle.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:eric.auger@redha=
t.com">eric.auger@redhat.com</a></span><meta itemprop=3D"email" content=3D"=
eric.auger@redhat.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta itemprop=3D"em=
ail" content=3D"jan.kiszka@web.de"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:joao.m.martins@oracle.com">Joao Martins</a></span><meta=
 itemprop=3D"email" content=3D"joao.m.martins@oracle.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:luc@lmichel.fr">Luc Michel</a></=
span><meta itemprop=3D"email" content=3D"luc@lmichel.fr"/></span><span clas=
s=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></spa=
n></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schem=
a.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pri=
mary-text underline-on-hover" style=3D"display: inline-block;;color: #3c404=
3; text-decoration: none;" href=3D"mailto:shameerali.kolothum.thodi@huawei.=
com">Shameerali Kolothum Thodi</a></span><meta itemprop=3D"email" content=
=3D"shameerali.kolothum.thodi@huawei.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span><meta ite=
mprop=3D"email" content=3D"z.huo@139.com"/></span><span class=3D"secondary-=
text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><s=
pan itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><=
span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text under=
line-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorat=
ion: none;" href=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhiwei</a></sp=
an><meta itemprop=3D"email" content=3D"zhiwei_liu@linux.alibaba.com"/></spa=
n><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: =
none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"=
http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a =
class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;c=
olor: #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel@nongnu.org=
">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" content=3D"qemu-=
devel@nongnu.org"/></span><span class=3D"secondary-text" style=3D"color: #7=
0757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee=
" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" c=
lass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"=
display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mail=
to:nelson.ho@windriver.com">nelson.ho@windriver.com</a></span><meta itempro=
p=3D"email" content=3D"nelson.ho@windriver.com"/></span><span class=3D"seco=
ndary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><=
/div></div></td></tr></table></td></tr></tbody></table></div><!--[if mso | =
IE]></td><![endif]--><!--[if mso | IE]></tr></table><![endif]--></td></tr><=
/tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" align=3D"center" style=3D"width:100%;" class=3D""><tbody>=
<tr><td style=3D"font-size: 0; padding: 0; text-align: left; word-break: br=
eak-word;;padding:4px 12px;" class=3D"" align=3D"left"><div class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;font-family: Robot=
o, sans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: exa=
ctly; text-align: left;"><p>Invitation from <a href=3D"https://calendar.goo=
gle.com/calendar/" class=3D"accent-text underline-on-hover" style=3D"font-f=
amily: Roboto, sans-serif;font-size: 12px; line-height: 16px; mso-line-heig=
ht-rule: exactly;;color: #1a73e8; text-decoration: none;" target=3D"_blank"=
>Google Calendar</a></p><p>You are receiving this email because you are an =
attendee on the event.</p><p>Forwarding this invitation could allow any rec=
ipient to send a response to the organizer, be added to the guest list, inv=
ite others regardless of their own invitation status, or modify your RSVP. =
<a class=3D"accent-text underline-on-hover" style=3D"font-family: Roboto, s=
ans-serif;font-size: 12px; line-height: 16px; mso-line-height-rule: exactly=
;;color: #1a73e8; text-decoration: none;" href=3D"https://support.google.co=
m/calendar/answer/37135#forwarding">Learn more</a></p></div></td></tr></tbo=
dy></table></td></tr></tbody></table></span></span></body></html>
--0000000000000c421e0649e64204
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VEVENT
DTSTART:20260106T140000Z
DTEND:20260106T150000Z
RRULE:FREQ=3DWEEKLY;WKST=3DMO;UNTIL=3D20260202T235959Z;INTERVAL=3D2;BYDAY=
=3DTU
DTSTAMP:20260203T071919Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:3tmn51v3ap1pkbeqj4divuh46c@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Dalex.bennee@linaro.org;X-NUM-GUESTS=3D0:mailto:alex.bennee@linar=
o.org
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
 TRUE;CN=3DMeirav Dean;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
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
 ;CN=3DAlberto Faria;X-NUM-GUESTS=3D0:mailto:afaria@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3DAlbert Esteve;X-NUM-GUESTS=3D0:mailto:aesteve@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;RSV=
P=3DTRUE
 ;CN=3Dmarcandre.lureau@gmail.com;X-NUM-GUESTS=3D0:mailto:marcandre.lureau@=
gmail
 .com
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
X-MICROSOFT-CDO-OWNERAPPTID:-1878555320
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20260203T071910Z
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

--0000000000000c421e0649e64204--

--0000000000000c421e0649e64206
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjYwMTA2VDE0MDAwMFoNCkRURU5EOjIwMjYwMTA2
VDE1MDAwMFoNClJSVUxFOkZSRVE9V0VFS0xZO1dLU1Q9TU87VU5USUw9MjAyNjAyMDJUMjM1OTU5
WjtJTlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjYwMjAzVDA3MTkxOVoNCk9SR0FOSVpF
UjtDTj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJrdTVzaTAx
YmxtbmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjN0bW41MXYzYXAxcGtiZXFq
NGRpdnVoNDZjQGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049YWxleC5i
ZW5uZWVAbGluYXJvLm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86YWxleC5iZW5uZWVAbGluYXJv
Lm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1NYXJrdXMgQXJtYnJ1c3RlcjtYLU5V
TS1HVUVTVFM9MDptYWlsdG86YXJtYnJ1QHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049YmNhaW5AcXVpY2luYy5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJjYWluQHF1
aWNpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpiZXJyYW5nZUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWNqaWFA
bnZpZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2ppYUBudmlkaWEuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPWN3QGYwMGYub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpj
d0BmMDBmLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1FcmljIEJsYWtlO1gtTlVN
LUdVRVNUUz0wOm1haWx0bzplYmxha2VAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1lZGdhci5pZ2xlc2lhc0BnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmVk
Z2FyLmlnbGVzaWFzQGdtYWlsDQogLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1l
ZHVhcmRvQGhhYmtvc3QubmV0O1gtTlVNLUdVRVNUUz0wOm1haWx0bzplZHVhcmRvQGhhYmtvc3Qu
bmV0DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWZlbGlwZUBudXRhbml4LmNvbTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86ZmVsaXBlQG51dGFuaXguY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPWlnZ3lAdGhlaWdneS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmlnZ3lAdGhl
aWdneS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aW1wQGJzZGltcC5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmltcEBic2RpbXAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ
RFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBU
UlVFO0NOPWpnZ0BudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqZ2dAbnZpZGlhLmNv
bQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU
QVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1qaWRvbmcueGlhb0BnbWFpbC5jb207WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1qaW0uc2h1QHNpZml2ZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpp
bS5zaHVAc2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1tYnVydG9uQHF0
aS5xdWFsY29tbS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1idXJ0b25AcXRpLnF1YWxjb21t
DQogLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1NZWlyYXYgRGVhbjtYLU5VTS1H
VUVTVFM9MDptYWlsdG86bWRlYW5AcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1wYXVsLndhbG1zbGV5QHNpZml2ZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBhdWwu
d2FsbXNsZXlAc2lmaXZlDQogLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1S
RVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1QYW9s
byBCb256aW5pO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpwYm9uemluaUByZWRoYXQuY29tDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXBldGVyLm1heWRlbGxAbGluYXJvLm9yZztYLU5VTS1H
VUVTVFM9MDptYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8NCiAub3JnDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOnJpY2hhcmQuaGVuZGVyc28NCiBuQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049c2hlbnRleUBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnNo
ZW50ZXlAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXN0ZWZhbmhhQGdt
YWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c3RlZmFuaGFAZ21haWwuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD0NCiBUUlVFO0NOPXdlaS53LndhbmdAaW50ZWwuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzp3ZWkudy53YW5nQGludGVsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtD
Tj16d3Uua2VybmVsQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86end1Lmtlcm5lbEBn
bWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5U
O1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cGhpbG1kQGxpbmFyby5vcmc7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBoaWxtZEBsaW5hcm8ub3JnDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNW
UD0NCiBUUlVFO0NOPWVibG90QHJpdm9zaW5jLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWJs
b3RAcml2b3NpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU
SUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW1heC5jaG91QHNp
Zml2ZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1heC5jaG91QHNpZml2ZS5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWFub3MucGl0c2lkaWFuYWtpc0BsaW5hcm8ub3JnO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzptYW5vcy5waXRzaWRpYQ0KIG5ha2lzQGxpbmFyby5vcmcNCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049VGhvbWFzIEh1dGg7WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOnRodXRoQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049cmJjQG1l
dGEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpyYmNAbWV0YS5jb20NCkFUVEVOREVFO0NVVFlQ
RT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtS
U1ZQPQ0KIFRSVUU7Q049ZGVtaW9iZW5vdXJAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpkZW1pb2Jlbm91ckBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049aGlA
YWx5c3NhLmlzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpoaUBhbHlzc2EuaXMNCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049ZGhlZGRlQGthbHJheWluYy5jb207WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOmRoZWRkZUBrYWxyYXlpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ERUNMSU5FRDtSU1ZQPVRSVUUNCiA7Q049QWxiZXJ0
byBGYXJpYTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YWZhcmlhQHJlZGhhdC5jb20NCkFUVEVOREVF
O0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFD
VElPTjtSU1ZQPQ0KIFRSVUU7Q049QWxiZXJ0IEVzdGV2ZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
YWVzdGV2ZUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtSU1ZQPVRSVUUNCiA7Q049bWFyY2FuZHJlLmx1
cmVhdUBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVAZ21h
aWwNCiAuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUFsaXN0YWlyIEZyYW5jaXM7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbQ0KQVRURU5ERUU7
Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNU
SU9OO1JTVlA9DQogVFJVRTtDTj1rb25yYWQud2lsa0BvcmFjbGUuY29tO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzprb25yYWQud2lsa0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPUFsZXNzYW5kcm8gRGkgRmVkZXJpY287WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsZUByZXYu
bmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNsZ0Br
YW9kLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1BbnRvbiBKb2hhbnNzb247WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmFuam9AcmV2Lm5nDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPUNoYW8gUGVuZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50
ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUVsZW5hIFVmaW10c2V2YTtYLU5V
TS1HVUVTVFM9MDptYWlsdG86ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049ZXJpYy5hdWdlckByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzplcmljLmF1Z2VyQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP
TEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049
amFuLmtpc3prYUB3ZWIuZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmphbi5raXN6a2FAd2ViLmRl
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPUpvYW8gTWFydGlucztYLU5VTS1HVUVTVFM9
MDptYWlsdG86am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1MdWMgTWljaGVsO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpsdWNAbG1pY2hlbC5mcg0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1TaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpzaGFtZWVyYWxpLmtvbG90aHVtDQogLnRob2RpQGh1YXdlaS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ei5odW9AMTM5LmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86ei5odW9AMTM5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1M
SVUgWmhpd2VpO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEu
Y29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU
U1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPXFlbXUtZGV2ZWxAbm9uZ251Lm9yZztY
LU5VTS1HVUVTVFM9MDptYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPW5lbHNvbi5ob0B3aW5kcml2ZXIuY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzpuZWxzb24uaG9Ad2luZHJpdmVyLmMNCiBvbQ0KWC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQ
VElEOi0xODc4NTU1MzIwDQpDUkVBVEVEOjIwMjMwMjIxVDE1Mzk1MFoNCkRFU0NSSVBUSU9OOklm
IHlvdSBuZWVkIGNhbGwgZGV0YWlsc1wsIHBsZWFzZSBjb250YWN0IG1lOiA8YSBocmVmPSJtYWls
dG86cQ0KIHVpbnRlbGFAcmVkaGF0LmNvbSI+YWxleC5iZW5uZWVAbGluYXJvLm9yZzwvYT4NCkxB
U1QtTU9ESUZJRUQ6MjAyNjAyMDNUMDcxOTEwWg0KTE9DQVRJT046aHR0cHM6Ly9tZWV0LmppdC5z
aS9rdm1jYWxsbWVldGluZw0KU0VRVUVOQ0U6Mg0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpR
RU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KVFJBTlNQOk9QQVFVRQ0KQVRUQUNI
O0ZJTEVOQU1FPU5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbDtG
TVRUWVBFPWFwcGxpY2ENCiB0aW9uL3ZuZC5nb29nbGUtYXBwcy5kb2N1bWVudDpodHRwczovL2Rv
Y3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHoNCiB4Q2NjZnFmTk5LY01HNzRITVVK
ZjZEVVJtU0pCR1FacmVrL2VkaXQNCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--0000000000000c421e0649e64206--


