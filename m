Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAD0C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4ls-0003UW-LZ; Tue, 24 Jun 2025 10:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU4lY-0003M7-RA
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:36:57 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uU4lJ-0006i4-DH
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:36:51 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so3767740f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750775794; x=1751380594; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mZ9Mnfyfn7Ox1cCpTV1TKqAXYrNtbka8kM+woYiz/RE=;
 b=FXBegWfhgii2u1NTioFEMGEZAJnNlL8F4iVhCWTCdllb94JaOVuWkIGVXMbN77Z8Va
 77oxsmM8kkmc1xTK6gZRdZ4DJjONTfjyr83IKWVsDt+vxWXMks40LRTrQM9p9ZXWQ8ef
 gQy+FtlHjZT5l8Mzhq7g14WysNpRkckwBROr1HyrhUKHrLXsIRMzMQasQOjwOcrMgZxU
 3vsmFK9SZH4nZVtWVdMyd+WOUrClkygXKfDtSLBw31wt+I2U9EWlI/l+X8ytU6BnDhzg
 tLlNPuL/QBxkEEg44fvyg5+vCySvdBiDYzIgjWuZsNcs9O1eKbf7uTf4Qc7dWLUlI5jn
 TnYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750775794; x=1751380594; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mZ9Mnfyfn7Ox1cCpTV1TKqAXYrNtbka8kM+woYiz/RE=;
 b=lQYlMaynI0CwZ025no29a3FrsQEWO/49FWtGTHGkxSFjxupTR2QWZgM/pSrSjdfu92
 DyQHpOYe7L3FMqtrHk4i6TfPuxs3fe9KBfaeCjv9EdIfO0j4C0B4JbtUf3gCJXFWoR4w
 dzwj0PSeQT+ZoiMXVgTiAgZb86NpL0ex4nymqe/oeGY5UvD77FLm5vFCcMpTMbsv0wvd
 7DAVTGlGy83S0Ys48cidJ8gPr/5PplBA5Cpi11+7/hS7/GDyTkFjV/BjZxHh7razSGlS
 pOzt+RB6PyfzCNoCPaWHesrf1WtAujLcBUJA+gPP6qTOli7W9rCeuhLNBz7vjVepfOh2
 fDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775794; x=1751380594;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZ9Mnfyfn7Ox1cCpTV1TKqAXYrNtbka8kM+woYiz/RE=;
 b=hZDigDh8WnAo3uGobdNGKZYfyDLeUjOjoGnZHKq/YaHieBre0U2yFjoO/wGLjeU4Ka
 +ZcHODqh/SHv+7RBQ0QGMCQXGgK4mxZtzVEf8rvpfjcTqjKK/AUOy1euVX3yVExjLvca
 DR6et4gSbe3csqlNtTQJXq8ZhVlOsphRobgZRLurHT3rqe+/jnAjGWywfT5cjYpsMV8a
 WHFIreYTLTWg1uv26gFZCFCvWT7HtZbe0/UvCfvdwFum3PkNeFti3nUFpnU3LiAgjOwG
 v0fqXH2ujdDBRIbPSkT7llE6KYgwJWfwJMcgtMSKEH4doGXqk03Ps74t012Rm1TTF3NI
 BYlw==
X-Gm-Message-State: AOJu0YyDSHpbdLAOLkCcNQGheBrEPY9TaxHGAe1Il7THctARL1MnsNdy
 koJd5uYFlp2w3GdbA6e0PcsjNWf7KGYJPUYyH8uBnr/MLHfa2uvqUZ3Kn/uz79RV6y9AnZqyyqf
 YqPQUSj5EA52iIoSBBKA0+mL0cR9hBKUT6C/TMoyI8bqo237Y4opc1w==
X-Google-Smtp-Source: AGHT+IE4S0L1NI6nJ93q7qT3fkKgo55HT2LV/87ipDuV7GCCfj7KT9LIMO4xH2WlmCO2zd5FZtWf3g3P5VyQL7d4sUqq
MIME-Version: 1.0
X-Received: by 2002:a05:6000:1a8e:b0:3a4:eeb5:21cb with SMTP id
 ffacd0b85a97d-3a6d12e5b71mr14336665f8f.26.1750775794494; Tue, 24 Jun 2025
 07:36:34 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-e0e57ee3-60da-42cf-bd3e-877f83e0ff76@google.com>
Date: Tue, 24 Jun 2025 14:36:34 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ Tue 14 Oct
 2025 14:00 - 15:00 (BST) (qemu-devel@nongnu.org)
From: alex.bennee@linaro.org
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="00000000000050099c063852417f"
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

--00000000000050099c063852417f
Content-Type: multipart/alternative; boundary="00000000000050099b063852417d"

--00000000000050099b063852417d
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KVHVlc2RheSAxNCBPY3QgMjAy
NSDii4UgMTQ6MDAg4oCTIDE1OjAwDQpVbml0ZWQgS2luZ2RvbSBUaW1lDQoNCkxvY2F0aW9uDQpo
dHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nCQ0KaHR0cHM6Ly93d3cuZ29vZ2xlLmNv
bS91cmw/cT1odHRwcyUzQSUyRiUyRm1lZXQuaml0LnNpJTJGa3ZtY2FsbG1lZXRpbmcmc2E9RCZ1
c3Q9MTc1MTIwNzc2MDAwMDAwMCZ1c2c9QU92VmF3Mzg0eTlnNnREdWtFR1l0MkZpWFlUTw0KDQoN
Cg0KQXR0YWNobWVudHMNCk5vdGVzIOKAkyBRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2Ug
Y2FsbCAgDQpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFMTHp4Q2Nj
ZnFmTk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCg0KSWYgeW91IG5lZWQgY2FsbCBk
ZXRhaWxzLCBwbGVhc2UgY29udGFjdCBtZTogYWxleC5iZW5uZWVAbGluYXJvLm9yZw0KDQpHdWVz
dHMNCmFsZXguYmVubmVlQGxpbmFyby5vcmcNCmFybWJydUByZWRoYXQuY29tDQpiY2FpbkBxdWlj
aW5jLmNvbQ0KYmVycmFuZ2VAcmVkaGF0LmNvbQ0KY2ppYUBudmlkaWEuY29tDQpjd0BmMDBmLm9y
Zw0KZWJsYWtlQHJlZGhhdC5jb20NCmVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbQ0KZWR1YXJkb0Bo
YWJrb3N0Lm5ldA0KZmVsaXBlQG51dGFuaXguY29tDQppZ2d5QHRoZWlnZ3kuY29tDQppbXBAYnNk
aW1wLmNvbQ0KamdnQG52aWRpYS5jb20NCmppZG9uZy54aWFvQGdtYWlsLmNvbQ0KamltLnNodUBz
aWZpdmUuY29tDQptYnVydG9uQHF0aS5xdWFsY29tbS5jb20NCm1kZWFuQHJlZGhhdC5jb20NCnBh
dWwud2FsbXNsZXlAc2lmaXZlLmNvbQ0KcGJvbnppbmlAcmVkaGF0LmNvbQ0KcGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnDQpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnDQpzaGVudGV5QGdtYWls
LmNvbQ0Kc3RlZmFuaGFAZ21haWwuY29tDQp3ZWkudy53YW5nQGludGVsLmNvbQ0Kend1Lmtlcm5l
bEBnbWFpbC5jb20NCnBoaWxtZEBsaW5hcm8ub3JnDQplYmxvdEByaXZvc2luYy5jb20NCm1heC5j
aG91QHNpZml2ZS5jb20NCm1hbm9zLnBpdHNpZGlhbmFraXNAbGluYXJvLm9yZw0KdGh1dGhAcmVk
aGF0LmNvbQ0KcmJjQG1ldGEuY29tDQpkZW1pb2Jlbm91ckBnbWFpbC5jb20NCmhpQGFseXNzYS5p
cw0KYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tDQprb25yYWQud2lsa0BvcmFjbGUuY29tDQphbGVA
cmV2Lm5nDQpjbGdAa2FvZC5vcmcNCmFuam9AcmV2Lm5nDQpjaGFvLnAucGVuZ0BsaW51eC5pbnRl
bC5jb20NCmRoZWRkZUBrYWxyYXlpbmMuY29tDQplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQ0K
ZXJpYy5hdWdlckByZWRoYXQuY29tDQpqYW4ua2lzemthQHdlYi5kZQ0Kam9hby5tLm1hcnRpbnNA
b3JhY2xlLmNvbQ0KbHVjQGxtaWNoZWwuZnINCm1pbXVAbGludXgudm5ldC5pYm0uY29tDQpzaGFt
ZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20NCnouaHVvQDEzOS5jb20NCnpoaXdlaV9s
aXVAbGludXguYWxpYmFiYS5jb20NCnFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KbmVsc29uLmhvQHdp
bmRyaXZlci5jb20NCg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJvbSBHb29nbGUgQ2FsZW5kYXI6
IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8NCg0KWW91IGFyZSByZWNlaXZp
bmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5kZWUgb24gdGhlIGV2ZW50Lg0K
DQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRv
IHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5pemVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vl
c3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNzIG9mICANCnRoZWlyIG93biBpbnZpdGF0
aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4NCg0KTGVhcm4gbW9yZSBodHRwczovL3N1
cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--00000000000050099b063852417d
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
em0a0ralnl5i_20251014T130000Z"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develope=
rs conference call</span><span aria-hidden=3D"true"><time itemprop=3D"start=
Date" datetime=3D"20251014T130000Z"></time><time itemprop=3D"endDate" datet=
ime=3D"20251014T140000Z"></time></span><table border=3D"0" cellpadding=3D"0=
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
pan aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D"20251014T=
130000Z"></time><time itemprop=3D"endDate" datetime=3D"20251014T140000Z"></=
time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D=
"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-=
text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-w=
eight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">When=
</h2></td></tr></table><span>Tuesday 14 Oct 2025 =E2=8B=85 14:00 =E2=80=93 =
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
Fkvmcallmeeting&amp;sa=3DD&amp;ust=3D1751207760000000&amp;usg=3DAOvVaw384y9=
g6tDukEGYt2FiXYTO" class=3D"accent-text underline-on-hover" style=3D"displa=
y: inline-block;;color: #1a73e8; text-decoration: none;font-weight: 700;" t=
arget=3D"_blank" itemprop=3D"map">View map</a></span></div></td></tr><tr><t=
d style=3D"font-size: 0; padding: 0; text-align: left; word-break: break-wo=
rd;;padding-bottom:24px;"><div style=3D"font-family: Roboto, sans-serif;fon=
t-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; lett=
er-spacing: 0.2px;color: #3c4043; text-decoration: none;" class=3D"primary-=
text" role=3D"presentation"><table border=3D"0" cellpadding=3D"0" cellspaci=
ng=3D"0" role=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 c=
lass=3D"primary-text" style=3D"font-size: 14px;color: #3c4043; text-decorat=
ion: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; p=
adding: 0;">Guests</h2></td></tr></table><div style=3D"padding-bottom: 4px;=
 text-align: left;;color: #3c4042;"><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:alex.=
bennee@linaro.org">alex.bennee@linaro.org</a></span><meta itemprop=3D"email=
" content=3D"alex.bennee@linaro.org"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a></span><meta =
itemprop=3D"email" content=3D"armbru@redhat.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:bcain@quicinc.com">bcain@quicinc.com</a><=
/span><meta itemprop=3D"email" content=3D"bcain@quicinc.com"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:berrange@redhat.com">berrange=
@redhat.com</a></span><meta itemprop=3D"email" content=3D"berrange@redhat.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia@nvidia=
.com">cjia@nvidia.com</a></span><meta itemprop=3D"email" content=3D"cjia@nv=
idia.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cw@f0=
0f.org">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f00f.o=
rg"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@redh=
at.com">eblake@redhat.com</a></span><meta itemprop=3D"email" content=3D"ebl=
ake@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta itempro=
p=3D"email" content=3D"edgar.iglesias@gmail.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:eduardo@habkost.net">eduardo@habkost.net<=
/a></span><meta itemprop=3D"email" content=3D"eduardo@habkost.net"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix.com">fel=
ipe@nutanix.com</a></span><meta itemprop=3D"email" content=3D"felipe@nutani=
x.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:iggy@the=
iggy.com">iggy@theiggy.com</a></span><meta itemprop=3D"email" content=3D"ig=
gy@theiggy.com"/></span><span class=3D"secondary-text" style=3D"color: #707=
57a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" =
itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cla=
ss=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"di=
splay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto=
:imp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" content=
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
: #3c4043; text-decoration: none;" href=3D"mailto:mburton@qti.qualcomm.com"=
>mburton@qti.qualcomm.com</a></span><meta itemprop=3D"email" content=3D"mbu=
rton@qti.qualcomm.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:mdean@redhat.com">mdean@redhat.com</a></span><meta itemprop=3D"emai=
l" content=3D"mdean@redhat.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:paul.walmsley@sifive.com">paul.walmsley@sifive.com</a></sp=
an><meta itemprop=3D"email" content=3D"paul.walmsley@sifive.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:pbonzini@redhat.com">pbon=
zini@redhat.com</a></span><meta itemprop=3D"email" content=3D"pbonzini@redh=
at.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:peter.m=
aydell@linaro.org">peter.maydell@linaro.org</a></span><meta itemprop=3D"ema=
il" content=3D"peter.maydell@linaro.org"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:richard.henderson@linaro.org">richard.henderson@l=
inaro.org</a></span><meta itemprop=3D"email" content=3D"richard.henderson@l=
inaro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:shen=
tey@gmail.com">shentey@gmail.com</a></span><meta itemprop=3D"email" content=
=3D"shentey@gmail.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:stefanha@gmail.com">stefanha@gmail.com</a></span><meta itemprop=3D"=
email" content=3D"stefanha@gmail.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a></span=
><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail.com">zwu.kerne=
l@gmail.com</a></span><meta itemprop=3D"email" content=3D"zwu.kernel@gmail.=
com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-d=
ecoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope i=
temtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notra=
nslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inli=
ne-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a></span><meta itemprop=3D"email" content=3D"ph=
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
-decoration: none;" href=3D"mailto:manos.pitsidianakis@linaro.org">manos.pi=
tsidianakis@linaro.org</a></span><meta itemprop=3D"email" content=3D"manos.=
pitsidianakis@linaro.org"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a></span><meta itemprop=3D"e=
mail" content=3D"thuth@redhat.com"/></span><span class=3D"secondary-text" s=
tyle=3D"color: #70757a; text-decoration: none;"></span></div><div><span ite=
mprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span it=
emprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on=
-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: no=
ne;" href=3D"mailto:rbc@meta.com">rbc@meta.com</a></span><meta itemprop=3D"=
email" content=3D"rbc@meta.com"/></span><span class=3D"secondary-text" styl=
e=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempr=
op=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemp=
rop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-ho=
ver" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;=
" href=3D"mailto:demiobenour@gmail.com">demiobenour@gmail.com</a></span><me=
ta itemprop=3D"email" content=3D"demiobenour@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a></sp=
an><meta itemprop=3D"email" content=3D"hi@alyssa.is"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:alistair.francis@wdc.com">alistair.fr=
ancis@wdc.com</a></span><meta itemprop=3D"email" content=3D"alistair.franci=
s@wdc.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:konr=
ad.wilk@oracle.com">konrad.wilk@oracle.com</a></span><meta itemprop=3D"emai=
l" content=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:ale@rev.ng">ale@rev.ng</a></span><meta itemprop=3D"e=
mail" content=3D"ale@rev.ng"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:clg@kaod.org">clg@kaod.org</a></span><meta itemprop=3D"emai=
l" content=3D"clg@kaod.org"/></span><span class=3D"secondary-text" style=3D=
"color: #70757a; text-decoration: none;"></span></div><div><span itemprop=
=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempro=
p=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hove=
r" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;" =
href=3D"mailto:anjo@rev.ng">anjo@rev.ng</a></span><meta itemprop=3D"email" =
content=3D"anjo@rev.ng"/></span><span class=3D"secondary-text" style=3D"col=
or: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"at=
tendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"n=
ame" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" sty=
le=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:chao.p.peng@linux.intel.com">chao.p.peng@linux.intel.com</a></sp=
an><meta itemprop=3D"email" content=3D"chao.p.peng@linux.intel.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:dhedde@kalrayinc.com">=
dhedde@kalrayinc.com</a></span><meta itemprop=3D"email" content=3D"dhedde@k=
alrayinc.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:e=
lena.ufimtseva@oracle.com">elena.ufimtseva@oracle.com</a></span><meta itemp=
rop=3D"email" content=3D"elena.ufimtseva@oracle.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:eric.auger@redhat.com">eric.auger@red=
hat.com</a></span><meta itemprop=3D"email" content=3D"eric.auger@redhat.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:jan.kiszka@we=
b.de">jan.kiszka@web.de</a></span><meta itemprop=3D"email" content=3D"jan.k=
iszka@web.de"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:j=
oao.m.martins@oracle.com">joao.m.martins@oracle.com</a></span><meta itempro=
p=3D"email" content=3D"joao.m.martins@oracle.com"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:luc@lmichel.fr">luc@lmichel.fr</a></span=
><meta itemprop=3D"email" content=3D"luc@lmichel.fr"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.v=
net.ibm.com</a></span><meta itemprop=3D"email" content=3D"mimu@linux.vnet.i=
bm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:shameer=
ali.kolothum.thodi@huawei.com">shameerali.kolothum.thodi@huawei.com</a></sp=
an><meta itemprop=3D"email" content=3D"shameerali.kolothum.thodi@huawei.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:z.huo@139.com=
">z.huo@139.com</a></span><meta itemprop=3D"email" content=3D"z.huo@139.com=
"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-deco=
ration: none;"></span></div><div><span itemprop=3D"attendee" itemscope item=
type=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notransl=
ate"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-=
block;;color: #3c4043; text-decoration: none;" href=3D"mailto:zhiwei_liu@li=
nux.alibaba.com">zhiwei_liu@linux.alibaba.com</a></span><meta itemprop=3D"e=
mail" content=3D"zhiwei_liu@linux.alibaba.com"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.or=
g</a></span><meta itemprop=3D"email" content=3D"qemu-devel@nongnu.org"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:nelson.ho@windriv=
er.com">nelson.ho@windriver.com</a></span><meta itemprop=3D"email" content=
=3D"nelson.ho@windriver.com"/></span><span class=3D"secondary-text" style=
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
--00000000000050099b063852417d
Content-Type: text/calendar; charset="UTF-8"; method=CANCEL
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:CANCEL
BEGIN:VEVENT
DTSTART:20251014T130000Z
DTEND:20251014T140000Z
DTSTAMP:20250624T143634Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i@google.com
RECURRENCE-ID;TZID=3DAmerica/New_York:20251014T090000
CREATED:20230221T153950Z
LAST-MODIFIED:20250624T143608Z
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

--00000000000050099b063852417d--

--00000000000050099c063852417f
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6Q0FOQ0VM
DQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ6MjAyNTEwMTRUMTMwMDAwWg0KRFRFTkQ6MjAyNTEwMTRU
MTQwMDAwWg0KRFRTVEFNUDoyMDI1MDYyNFQxNDM2MzRaDQpPUkdBTklaRVI7Q049UUVNVSBQcm9q
ZWN0IENhbGVuZGFyOm1haWx0bzpjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGdyb3UNCiBw
LmNhbGVuZGFyLmdvb2dsZS5jb20NClVJRDoxZ3Z1Yjk0MzVvN2hycmVtMGEwcmFsbmw1aUBnb29n
bGUuY29tDQpSRUNVUlJFTkNFLUlEO1RaSUQ9QW1lcmljYS9OZXdfWW9yazoyMDI1MTAxNFQwOTAw
MDANCkNSRUFURUQ6MjAyMzAyMjFUMTUzOTUwWg0KTEFTVC1NT0RJRklFRDoyMDI1MDYyNFQxNDM2
MDhaDQpTRVFVRU5DRToxDQpTVEFUVVM6Q0FOQ0VMTEVEDQpTVU1NQVJZOlFFTVUvS1ZNIGRldmVs
b3BlcnMgY29uZmVyZW5jZSBjYWxsDQpUUkFOU1A6T1BBUVVFDQpBVFRBQ0g7RklMRU5BTUU9Tm90
ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsO0ZNVFRZUEU9YXBwbGlj
YQ0KIHRpb24vdm5kLmdvb2dsZS1hcHBzLmRvY3VtZW50Omh0dHBzOi8vZG9jcy5nb29nbGUuY29t
L2RvY3VtZW50L2QvMS1MdHExMUxMeg0KIHhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1TSkJHUVpy
ZWsvZWRpdA0KQkVHSU46VkFMQVJNDQpBQ1RJT046RU1BSUwNCkRFU0NSSVBUSU9OOlRoaXMgaXMg
YW4gZXZlbnQgcmVtaW5kZXINClNVTU1BUlk6QWxhcm0gbm90aWZpY2F0aW9uDQpBVFRFTkRFRTpt
YWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpUUklHR0VSOi1QMkQNCkVORDpWQUxBUk0NCkVO
RDpWRVZFTlQNCkVORDpWQ0FMRU5EQVINCg==
--00000000000050099c063852417f--

