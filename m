Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7115CC83F12
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 08:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZQWZ-0002qS-BY; Wed, 09 Jul 2025 04:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZQWV-0002nb-6i
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:51:27 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZQWR-0001zW-7Y
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:51:26 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-454b907e338so33126175e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752051080; x=1752655880; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jn1sfkWE5mM9Gu6vOPc5BjL4NMk80+iZVdWWFFEzJxs=;
 b=4xqiwwjDabFWg3uxZ6DrG/YQzeeTC49z2U25HgAqpXJHT6+6f+/rJv+WzCJfNUoxnA
 +4I/j0n0xjzU999YdOFNAA+J/lDmdUkBvUZ3JpGiSOhFDsuE9H0iSam5jG3FIu5kDQJ3
 kTCjLPDGH80udp1kS85pnv/zOTj1Qbq36XWJ9isTf0fBoKI/4qnIMWycagWlrH46QJPE
 ppKf5jW4b5ATdL+iS8hdHCz20TzcscVci/HNK+HpNwovZq5U/lfAW2z8R4fGcGT//4jm
 3LNNlwWz3R7z4lyNZgfFgTAX4eBWnGZukdG358DiG0jDJQmd2nk/fkVmd3JMICAMnyku
 0/lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752051080; x=1752655880; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jn1sfkWE5mM9Gu6vOPc5BjL4NMk80+iZVdWWFFEzJxs=;
 b=E/+GJt9LS70hnP3OzOygCS9Tq0s3nmCrKqnkHJzmYrR+9R+09U2z3yZatOaJEGOo6r
 Bg7zLXQSTteTyK68a2CFrY4BwxBvIk/UoClaLJBh0mNYbV03RBtWBQuK0r1Tu3g6jb/o
 0CxLsMJNqy8QBLqFhWzgD1owXwlSAsEQ+LbHuJXITy5RE0MA+16s0kIeKymfKkMO2Jeg
 BXsGHWt8Jiy7LH9jdE3N8q/tkHoTeQzR4yO5J6Xjpaq4dclBrN+CmtSvQmQSOyXSxDIZ
 fWqpFnigtOPi3hrFWxwzRRt3SjN4P+5qt2aZdRghSL7wL/lnTBdXWTKuolMGdEeCIxxt
 6XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752051080; x=1752655880;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jn1sfkWE5mM9Gu6vOPc5BjL4NMk80+iZVdWWFFEzJxs=;
 b=rx/KDyBheITnV1IPIVd9h3/+3sAm8rr+y4+vJhGfhK/wzFTalPPYEPlpcD1IVYLL2h
 m6GV3putzcTZy5EswpQ7Vn9ZG1I/25syqyKc4YgnAtJQeeCwstBZZ54suC4flhC8DfDQ
 c9++R7zJ9IhpwfzbSIFxbZiVRxRJBUbrO2At7ZxY6oHMfTLsXJq+pJc5Umm8TpC8vPu/
 H6iPA0N79PbBL0jQgHQ1Cs4P1DlT7YwyIo3HS6Ud25uSwXNn/ZO7oINru27UNktHytwN
 HK9eCaWYlKPnsZoHiX7wgtji0/0XunufufU+VmF6dUQD9Kd6cH6DtwfTnFA5lb2BMzet
 xjEQ==
X-Gm-Message-State: AOJu0YxIbXMZaj1AwgEc+L1WT5SyzR+sziTqiOCgxBMi9VqXKKgYjoOD
 8Ihq5RI6hpQl3Je+h06fVbNu1cd2U2WlzsaWwJfEaA9PlA3FDoLU9V1DZPgHEy5CwCpwvkZMq+1
 cR4SvJmK3KwK6SqSUNBxZ86kuzhZ2VhB3pWAgaU/pXcUCuTGxfRRsyA==
X-Google-Smtp-Source: AGHT+IFSLET9l91/bxAKRc056A1zzwmQBI6s/RRYoAh3Bypn8VTFnP2GpLetNCuEDz1XVDWR2pz4xn6szZeHdDtNe4xD
MIME-Version: 1.0
X-Received: by 2002:a05:600c:3e14:b0:442:f98e:f37 with SMTP id
 5b1f17b1804b1-454d53a0161mr11309485e9.21.1752051080447; Wed, 09 Jul 2025
 01:51:20 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-41e222ba-0056-4616-b55f-3e4a698e35d3@google.com>
Date: Wed, 09 Jul 2025 08:51:20 +0000
Subject: Synced invitation: QEMU/KVM developers conference call @ Every 2
 weeks from 14:00 to 15:00 on Tuesday (BST) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000475da206397b2e16"
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

--000000000000475da206397b2e16
Content-Type: multipart/alternative; boundary="000000000000475da106397b2e14"

--000000000000475da106397b2e14
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBlbWFpbCBrZWVwcyB0aGUgZXZlbnQgdXAgdG8gZGF0ZSBpbiB5b3VyIGNhbGVuZGFyLg0K
DQpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2FsbA0KRXZlcnkgMiB3ZWVrcyBmcm9t
IDE0OjAwIHRvIDE1OjAwIG9uIFR1ZXNkYXkNClVuaXRlZCBLaW5nZG9tIFRpbWUNCg0KTG9jYXRp
b24NCmh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2FsbG1lZXRpbmcJDQpodHRwczovL3d3dy5nb29n
bGUuY29tL3VybD9xPWh0dHBzJTNBJTJGJTJGbWVldC5qaXQuc2klMkZrdm1jYWxsbWVldGluZyZz
YT1EJnVzdD0xNzUyNDgzMDYwMDAwMDAwJnVzZz1BT3ZWYXcyZmRUaG9XYXRfWFFMNlg0Sk5fLU5i
DQoNCg0KDQpBdHRhY2htZW50cw0KTm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVy
ZW5jZSBjYWxsICANCmh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxM
enhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1TSkJHUVpyZWsvZWRpdA0KDQpJZiB5b3UgbmVlZCBj
YWxsIGRldGFpbHMsIHBsZWFzZSBjb250YWN0IG1lOiBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnDQoN
Ckd1ZXN0cw0KQWxleCBCZW5uw6llIC0gY3JlYXRvcg0KYXJtYnJ1QHJlZGhhdC5jb20NCmJjYWlu
QHF1aWNpbmMuY29tDQpiZXJyYW5nZUByZWRoYXQuY29tDQpjamlhQG52aWRpYS5jb20NCmN3QGYw
MGYub3JnDQplYmxha2VAcmVkaGF0LmNvbQ0KZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tDQplZHVh
cmRvQGhhYmtvc3QubmV0DQpmZWxpcGVAbnV0YW5peC5jb20NCmlnZ3lAdGhlaWdneS5jb20NCmlt
cEBic2RpbXAuY29tDQpqZ2dAbnZpZGlhLmNvbQ0Kamlkb25nLnhpYW9AZ21haWwuY29tDQpqaW0u
c2h1QHNpZml2ZS5jb20NCm1idXJ0b25AcXRpLnF1YWxjb21tLmNvbQ0KbWRlYW5AcmVkaGF0LmNv
bQ0KcGF1bC53YWxtc2xleUBzaWZpdmUuY29tDQpwYm9uemluaUByZWRoYXQuY29tDQpQZXRlciBN
YXlkZWxsDQpSaWNoYXJkIEhlbmRlcnNvbg0Kc2hlbnRleUBnbWFpbC5jb20NCnN0ZWZhbmhhQGdt
YWlsLmNvbQ0Kd2VpLncud2FuZ0BpbnRlbC5jb20NCnp3dS5rZXJuZWxAZ21haWwuY29tDQpQaGls
IE1hdGhpZXUtRGF1ZMOpDQplYmxvdEByaXZvc2luYy5jb20NCm1heC5jaG91QHNpZml2ZS5jb20N
Ck1hbm9zIFBpdHNpZGlhbmFraXMNCnRodXRoQHJlZGhhdC5jb20NCnJiY0BtZXRhLmNvbQ0KQWxp
c3RhaXIgRnJhbmNpcw0Ka29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KQWxlc3NhbmRybyBEaSBGZWRl
cmljbw0KQ8OpZHJpYyBMZSBHb2F0ZXINCkFudG9uIEpvaGFuc3Nvbg0KQ2hhbyBQZW5nDQpEYW1p
ZW4gSGVkZGUNCkVsZW5hIFVmaW10c2V2YQ0KZXJpYy5hdWdlckByZWRoYXQuY29tDQpqYW4ua2lz
emthQHdlYi5kZQ0KSm9hbyBNYXJ0aW5zDQpMdWMgTWljaGVsDQptaW11QGxpbnV4LnZuZXQuaWJt
LmNvbQ0KU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0Kei5odW9AMTM5LmNvbQ0KTElVIFpoaXdl
aQ0KcWVtdS1kZXZlbEBub25nbnUub3JnDQpuZWxzb24uaG9Ad2luZHJpdmVyLmNvbQ0KZGVtaW9i
ZW5vdXJAZ21haWwuY29tDQpoaUBhbHlzc2EuaXMNCg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJv
bSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8N
Cg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5k
ZWUgb24gdGhlIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRhdGlvbiBjb3VsZCBhbGxv
dyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0aGUgb3JnYW5pemVyLCBi
ZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyByZWdhcmRsZXNzIG9mICAN
CnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlvdXIgUlNWUC4NCg0KTGVh
cm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRhci9hbnN3ZXIvMzcxMzUj
Zm9yd2FyZGluZw0K
--000000000000475da106397b2e14
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
46204rq8mc53"/><span style=3D"display: none; font-size: 1px; color: #fff; l=
ine-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity:=
 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM developers conference cal=
l</span><span aria-hidden=3D"true"><time itemprop=3D"startDate" datetime=3D=
"20250624T130000Z"></time><time itemprop=3D"endDate" datetime=3D"20250624T1=
40000Z"></time></span><table border=3D"0" cellpadding=3D"0" cellspacing=3D"=
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
><time itemprop=3D"startDate" datetime=3D"20250624T130000Z"></time><time it=
emprop=3D"endDate" datetime=3D"20250624T140000Z"></time></span><table borde=
r=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"=
padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size=
: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-=
smoothing: antialiased;margin: 0; padding: 0;">When</h2></td></tr></table><=
span>Every 2 weeks from 14:00 to 15:00 on Tuesday (United Kingdom Time)</sp=
an></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-align: l=
eft; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-famil=
y: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px=
; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration:=
 none;" class=3D"primary-text" role=3D"presentation"><table border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" role=3D"presentation" style=3D"padding-bo=
ttom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"font-size: 14px;col=
or: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing:=
 antialiased;margin: 0; padding: 0;">Location</h2></td></tr></table><span i=
temprop=3D"location" itemscope itemtype=3D"http://schema.org/Place"><span i=
temprop=3D"name" class=3D"primary-text notranslate" style=3D"font-family: R=
oboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; li=
ne-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: non=
e;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=3D"https://www.go=
ogle.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=3DD&amp;=
ust=3D1752483060000000&amp;usg=3DAOvVaw2fdThoWat_XQL6X4JN_-Nb" class=3D"acc=
ent-text underline-on-hover" style=3D"display: inline-block;;color: #1a73e8=
; text-decoration: none;font-weight: 700;" target=3D"_blank" itemprop=3D"ma=
p">View map</a></span></div></td></tr><tr><td style=3D"font-size: 0; paddin=
g: 0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div =
style=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 4=
00; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c404=
3; text-decoration: none;" class=3D"primary-text" role=3D"presentation"><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"=
font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-web=
kit-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2></td></t=
r></table><div style=3D"padding-bottom: 4px; text-align: left;;color: #3c40=
42;"><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.o=
rg/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primar=
y-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; =
text-decoration: none;" href=3D"mailto:alex.bennee@linaro.org">Alex Benn=C3=
=A9e</a></span><meta itemprop=3D"email" content=3D"alex.bennee@linaro.org"/=
></span><span class=3D"secondary-text" style=3D"color: #70757a; text-decora=
tion: none;"> - creator</span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:armbr=
u@redhat.com">armbru@redhat.com</a></span><meta itemprop=3D"email" content=
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
043; text-decoration: none;" href=3D"mailto:cw@f00f.org">cw@f00f.org</a></s=
pan><meta itemprop=3D"email" content=3D"cw@f00f.org"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:eblake@redhat.com">eblake@redhat.com<=
/a></span><meta itemprop=3D"email" content=3D"eblake@redhat.com"/></span><s=
pan class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none=
;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http=
://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a clas=
s=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color=
: #3c4043; text-decoration: none;" href=3D"mailto:edgar.iglesias@gmail.com"=
>edgar.iglesias@gmail.com</a></span><meta itemprop=3D"email" content=3D"edg=
ar.iglesias@gmail.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:eduardo@habkost.net">eduardo@habkost.net</a></span><meta itemprop=
=3D"email" content=3D"eduardo@habkost.net"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:felipe@nutanix.com">felipe@nutanix.com</a></spa=
n><meta itemprop=3D"email" content=3D"felipe@nutanix.com"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sche=
ma.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"pr=
imary-text underline-on-hover" style=3D"display: inline-block;;color: #3c40=
43; text-decoration: none;" href=3D"mailto:iggy@theiggy.com">iggy@theiggy.c=
om</a></span><meta itemprop=3D"email" content=3D"iggy@theiggy.com"/></span>=
<span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: no=
ne;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"ht=
tp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cl=
ass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;col=
or: #3c4043; text-decoration: none;" href=3D"mailto:imp@bsdimp.com">imp@bsd=
imp.com</a></span><meta itemprop=3D"email" content=3D"imp@bsdimp.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:jgg@nvidia.com">jgg@=
nvidia.com</a></span><meta itemprop=3D"email" content=3D"jgg@nvidia.com"/><=
/span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorati=
on: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:jidong.xiao@gmail=
.com">jidong.xiao@gmail.com</a></span><meta itemprop=3D"email" content=3D"j=
idong.xiao@gmail.com"/></span><span class=3D"secondary-text" style=3D"color=
: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atte=
ndee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"nam=
e" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:jim.shu@sifive.com">jim.shu@sifive.com</a></span><meta itemprop=3D"e=
mail" content=3D"jim.shu@sifive.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a=
></span><meta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></sp=
an><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration:=
 none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D=
"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a=
 class=3D"primary-text underline-on-hover" style=3D"display: inline-block;;=
color: #3c4043; text-decoration: none;" href=3D"mailto:mdean@redhat.com">md=
ean@redhat.com</a></span><meta itemprop=3D"email" content=3D"mdean@redhat.c=
om"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-de=
coration: none;"></span></div><div><span itemprop=3D"attendee" itemscope it=
emtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notran=
slate"><a class=3D"primary-text underline-on-hover" style=3D"display: inlin=
e-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:paul.walmsl=
ey@sifive.com">paul.walmsley@sifive.com</a></span><meta itemprop=3D"email" =
content=3D"paul.walmsley@sifive.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a></span><m=
eta itemprop=3D"email" content=3D"pbonzini@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:peter.maydell@linaro.org">Peter Ma=
ydell</a></span><meta itemprop=3D"email" content=3D"peter.maydell@linaro.or=
g"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:richard.hend=
erson@linaro.org">Richard Henderson</a></span><meta itemprop=3D"email" cont=
ent=3D"richard.henderson@linaro.org"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:shentey@gmail.com">shentey@gmail.com</a></span><meta =
itemprop=3D"email" content=3D"shentey@gmail.com"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a=
></span><meta itemprop=3D"email" content=3D"stefanha@gmail.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:wei.w.wang@intel.com">wei.=
w.wang@intel.com</a></span><meta itemprop=3D"email" content=3D"wei.w.wang@i=
ntel.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:zwu.k=
ernel@gmail.com">zwu.kernel@gmail.com</a></span><meta itemprop=3D"email" co=
ntent=3D"zwu.kernel@gmail.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:philmd@linaro.org">Phil Mathieu-Daud=C3=A9</a></span><meta =
itemprop=3D"email" content=3D"philmd@linaro.org"/></span><span class=3D"sec=
ondary-text" style=3D"color: #70757a; text-decoration: none;"></span></div>=
<div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pe=
rson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-tex=
t underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-=
decoration: none;" href=3D"mailto:eblot@rivosinc.com">eblot@rivosinc.com</a=
></span><meta itemprop=3D"email" content=3D"eblot@rivosinc.com"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:max.chou@sifive.com">max.c=
hou@sifive.com</a></span><meta itemprop=3D"email" content=3D"max.chou@sifiv=
e.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text=
-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope=
 itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"not=
ranslate"><a class=3D"primary-text underline-on-hover" style=3D"display: in=
line-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:manos.pi=
tsidianakis@linaro.org">Manos Pitsidianakis</a></span><meta itemprop=3D"ema=
il" content=3D"manos.pitsidianakis@linaro.org"/></span><span class=3D"secon=
dary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><d=
iv><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Pers=
on"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text =
underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-de=
coration: none;" href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a></spa=
n><meta itemprop=3D"email" content=3D"thuth@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:rbc@meta.com">rbc@meta.com</a></sp=
an><meta itemprop=3D"email" content=3D"rbc@meta.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:alistair.francis@wdc.com">Alistair Fr=
ancis</a></span><meta itemprop=3D"email" content=3D"alistair.francis@wdc.co=
m"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@=
oracle.com">konrad.wilk@oracle.com</a></span><meta itemprop=3D"email" conte=
nt=3D"konrad.wilk@oracle.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:ale@rev.ng">Alessandro Di Federico</a></span><meta itemprop=
=3D"email" content=3D"ale@rev.ng"/></span><span class=3D"secondary-text" st=
yle=3D"color: #70757a; text-decoration: none;"></span></div><div><span item=
prop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span ite=
mprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-=
hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: non=
e;" href=3D"mailto:clg@kaod.org">C=C3=A9dric Le Goater</a></span><meta item=
prop=3D"email" content=3D"clg@kaod.org"/></span><span class=3D"secondary-te=
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
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:demiobenour@gmail.com">demiobenour@gmail.com</a></spa=
n><meta itemprop=3D"email" content=3D"demiobenour@gmail.com"/></span><span =
class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"><=
/span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://s=
chema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D=
"primary-text underline-on-hover" style=3D"display: inline-block;;color: #3=
c4043; text-decoration: none;" href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a=
></span><meta itemprop=3D"email" content=3D"hi@alyssa.is"/></span><span cla=
ss=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></sp=
an></div></div></div></td></tr></table></td></tr></tbody></table></div><!--=
[if mso | IE]></td><![endif]--><!--[if mso | IE]></tr></table><![endif]--><=
/td></tr></tbody></table><table border=3D"0" cellpadding=3D"0" cellspacing=
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
--000000000000475da106397b2e14
Content-Type: text/calendar; charset="UTF-8"; method=REQUEST
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VEVENT
DTSTART:20250624T130000Z
DTEND:20250624T140000Z
RRULE:FREQ=3DWEEKLY;WKST=3DMO;UNTIL=3D20250707T235959Z;INTERVAL=3D2;BYDAY=
=3DTU
DTSTAMP:20250709T085120Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:5o8knt1c26rbmq46204rq8mc53@google.com
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
 TRUE;CN=3Dmdean@redhat.com;X-NUM-GUESTS=3D0:mailto:mdean@redhat.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;RSVP=3D
 TRUE;CN=3Deblot@rivosinc.com;X-NUM-GUESTS=3D0:mailto:eblot@rivosinc.com
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
 TRUE;CN=3DDamien Hedde;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.com
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
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;RSV=
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
X-MICROSOFT-CDO-OWNERAPPTID:-1619406376
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20250709T085113Z
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

--000000000000475da106397b2e14--

--000000000000475da206397b2e16
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6UkVRVUVT
VA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUOjIwMjUwNjI0VDEzMDAwMFoNCkRURU5EOjIwMjUwNjI0
VDE0MDAwMFoNClJSVUxFOkZSRVE9V0VFS0xZO1dLU1Q9TU87VU5USUw9MjAyNTA3MDdUMjM1OTU5
WjtJTlRFUlZBTD0yO0JZREFZPVRVDQpEVFNUQU1QOjIwMjUwNzA5VDA4NTEyMFoNCk9SR0FOSVpF
UjtDTj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJrdTVzaTAx
YmxtbmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjVvOGtudDFjMjZyYm1xNDYy
MDRycThtYzUzQGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmFsZXguYmVubmVlQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0K
IFRSVUU7Q049YXJtYnJ1QHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFybWJydUBy
ZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWJjYWluQHF1aWNpbmMuY29t
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpiY2FpbkBxdWljaW5jLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1iZXJyYW5nZUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpi
ZXJyYW5nZUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWNqaWFAbnZp
ZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2ppYUBudmlkaWEuY29tDQpBVFRFTkRFRTtD
VVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJ
T047UlNWUD0NCiBUUlVFO0NOPWN3QGYwMGYub3JnO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjd0Bm
MDBmLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1lYmxha2VAcmVkaGF0LmNvbTtY
LU5VTS1HVUVTVFM9MDptYWlsdG86ZWJsYWtlQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1J
TkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQ
PQ0KIFRSVUU7Q049ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzplZGdhci5pZ2xlc2lhc0BnbWFpbA0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7
Q049ZWR1YXJkb0BoYWJrb3N0Lm5ldDtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWR1YXJkb0BoYWJr
b3N0Lm5ldA0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7
UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1mZWxpcGVAbnV0YW5peC5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmZlbGlwZUBudXRhbml4LmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JT
VlA9DQogVFJVRTtDTj1pZ2d5QHRoZWlnZ3kuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzppZ2d5
QHRoZWlnZ3kuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ
UEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPWltcEBic2RpbXAuY29t
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzppbXBAYnNkaW1wLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1qZ2dAbnZpZGlhLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86amdnQG52aWRp
YS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amlkb25nLnhpYW9AZ21haWwuY29t
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqaWRvbmcueGlhb0BnbWFpbC5jb20NCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtSU1ZQPQ0KIFRSVUU7Q049amltLnNodUBzaWZpdmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpqaW0uc2h1QHNpZml2ZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWJ1cnRv
bkBxdGkucXVhbGNvbW0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYnVydG9uQHF0aS5xdWFs
Y29tbQ0KIC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ
QU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWRlYW5AcmVkaGF0LmNv
bTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWRlYW5AcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9REVDTElORUQ7UlNWUD1U
UlVFDQogO0NOPXBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTtYLU5VTS1HVUVTVFM9MDtYLVJFU1BP
TlNFLUNPTU1FTlQ9IkRlY2xpbmVkIGJlDQogY2F1c2UgaXQmIzM5XDtzIG91dHNpZGUgb2Ygd29y
a2luZyBob3VycyI6bWFpbHRvOnBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O1JTVlA9DQogVFJVRTtDTj1wYm9uemluaUByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpwYm9uemluaUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPVBldGVy
IE1heWRlbGw7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1SaWNoYXJkIEhlbmRlcnNvbjtYLU5VTS1HVUVT
VFM9MDptYWlsdG86cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yDQogZw0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O1JTVlA9DQogVFJVRTtDTj1zaGVudGV5QGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
c2hlbnRleUBnbWFpbC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049c3RlZmFuaGFA
Z21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzdGVmYW5oYUBnbWFpbC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049d2VpLncud2FuZ0BpbnRlbC5jb207WC1OVU0tR1VFU1RT
PTA6bWFpbHRvOndlaS53LndhbmdAaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVB
TDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVF
O0NOPXp3dS5rZXJuZWxAZ21haWwuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6d3Uua2VybmVs
QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtYLU5VTS1HVUVTVFM9MDptYWls
dG86cGhpbG1kQGxpbmFyby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZWJsb3RA
cml2b3NpbmMuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxvdEByaXZvc2luYy5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049bWF4LmNob3VAc2lmaXZlLmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86bWF4LmNob3VAc2lmaXZlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV
QUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJV
RTtDTj1NYW5vcyBQaXRzaWRpYW5ha2lzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYW5vcy5waXRz
aWRpYW5ha2lzQGxpbmFyDQogby5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049dGh1
dGhAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86dGh1dGhAcmVkaGF0LmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1yYmNAbWV0YS5jb207WC1OVU0tR1VFU1RTPTA6bWFp
bHRvOnJiY0BtZXRhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1BbGlzdGFpciBG
cmFuY2lzO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbGlzdGFpci5mcmFuY2lzQHdkYy5jb20NCkFU
VEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5F
RURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049a29ucmFkLndpbGtAb3JhY2xlLmNvbTtYLU5VTS1H
VUVTVFM9MDptYWlsdG86a29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1BbGVzc2FuZHJvIERpIEZlZGVyaWNvO1gtTlVNLUdVRVNUUz0wOm1haWx0bzph
bGVAcmV2Lm5nDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO
VDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzpjbGdAa2FvZC5vcmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049QW50b24gSm9oYW5z
c29uO1gtTlVNLUdVRVNUUz0wOm1haWx0bzphbmpvQHJldi5uZw0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9
DQogVFJVRTtDTj1DaGFvIFBlbmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNoYW8ucC5wZW5nQGxp
bnV4LmludGVsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1EYW1pZW4gSGVkZGU7
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmRoZWRkZUBrYWxyYXlpbmMuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
UlNWUD0NCiBUUlVFO0NOPUVsZW5hIFVmaW10c2V2YTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWxl
bmEudWZpbXRzZXZhQG9yYWNsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049ZXJp
Yy5hdWdlckByZWRoYXQuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzplcmljLmF1Z2VyQHJlZGhh
dC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BB
UlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049amFuLmtpc3prYUB3ZWIuZGU7WC1O
VU0tR1VFU1RTPTA6bWFpbHRvOmphbi5raXN6a2FAd2ViLmRlDQpBVFRFTkRFRTtDVVRZUEU9SU5E
SVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0N
CiBUUlVFO0NOPUpvYW8gTWFydGlucztYLU5VTS1HVUVTVFM9MDptYWlsdG86am9hby5tLm1hcnRp
bnNAb3JhY2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElD
SVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1MdWMgTWljaGVsO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpsdWNAbG1pY2hlbC5mcg0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1taW11QGxpbnV4LnZuZXQuaWJtLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86bWlt
dUBsaW51eC52bmV0LmlibS5jDQogb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9
UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049U2hh
bWVlcmFsaSBLb2xvdGh1bSBUaG9kaTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c2hhbWVlcmFsaS5r
b2xvdGh1bQ0KIC50aG9kaUBodWF3ZWkuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NO
PXouaHVvQDEzOS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnouaHVvQDEzOS5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtSU1ZQPQ0KIFRSVUU7Q049TElVIFpoaXdlaTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
emhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9REVDTElORUQ7UlNWUD1UUlVFDQogO0NOPXFl
bXUtZGV2ZWxAbm9uZ251Lm9yZztYLU5VTS1HVUVTVFM9MDptYWlsdG86cWVtdS1kZXZlbEBub25n
bnUub3JnDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047UlNWUD0NCiBUUlVFO0NOPW5lbHNvbi5ob0B3aW5kcml2ZXIu
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpuZWxzb24uaG9Ad2luZHJpdmVyLmMNCiBvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9DQogVFJVRTtDTj1kZW1pb2Jlbm91ckBnbWFpbC5jb207WC1OVU0tR1VF
U1RTPTA6bWFpbHRvOmRlbWlvYmVub3VyQGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElW
SURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9DQog
VFJVRTtDTj1oaUBhbHlzc2EuaXM7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmhpQGFseXNzYS5pcw0K
WC1NSUNST1NPRlQtQ0RPLU9XTkVSQVBQVElEOi0xNjE5NDA2Mzc2DQpDUkVBVEVEOjIwMjMwMjIx
VDE1Mzk1MFoNCkRFU0NSSVBUSU9OOklmIHlvdSBuZWVkIGNhbGwgZGV0YWlsc1wsIHBsZWFzZSBj
b250YWN0IG1lOiA8YSBocmVmPSJtYWlsdG86cQ0KIHVpbnRlbGFAcmVkaGF0LmNvbSI+YWxleC5i
ZW5uZWVAbGluYXJvLm9yZzwvYT4NCkxBU1QtTU9ESUZJRUQ6MjAyNTA3MDlUMDg1MTEzWg0KTE9D
QVRJT046aHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZw0KU0VRVUVOQ0U6MQ0KU1RB
VFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpRRU1VL0tWTSBkZXZlbG9wZXJzIGNvbmZlcmVuY2UgY2Fs
bA0KVFJBTlNQOk9QQVFVRQ0KQVRUQUNIO0ZJTEVOQU1FPU5vdGVzIOKAkyBRRU1VL0tWTSBkZXZl
bG9wZXJzIGNvbmZlcmVuY2UgY2FsbDtGTVRUWVBFPWFwcGxpY2ENCiB0aW9uL3ZuZC5nb29nbGUt
YXBwcy5kb2N1bWVudDpodHRwczovL2RvY3MuZ29vZ2xlLmNvbS9kb2N1bWVudC9kLzEtTHRxMTFM
THoNCiB4Q2NjZnFmTk5LY01HNzRITVVKZjZEVVJtU0pCR1FacmVrL2VkaXQNCkJFR0lOOlZBTEFS
TQ0KQUNUSU9OOkVNQUlMDQpERVNDUklQVElPTjpUaGlzIGlzIGFuIGV2ZW50IHJlbWluZGVyDQpT
VU1NQVJZOkFsYXJtIG5vdGlmaWNhdGlvbg0KQVRURU5ERUU6bWFpbHRvOnFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KVFJJR0dFUjotUDJEDQpFTkQ6VkFMQVJNDQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVO
REFSDQo=
--000000000000475da206397b2e16--

