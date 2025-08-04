Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E0EC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 16:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiyTj-0002ue-EN; Mon, 04 Aug 2025 12:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pb@fourieraudio.com>)
 id 1uiwdK-0000Wu-49
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:57:50 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pb@fourieraudio.com>)
 id 1uiwdH-0005Z4-FV
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:57:49 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61580eb7995so9957605a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fourieraudio.com; s=google; t=1754319465; x=1754924265; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=We4hQUS21AFyuPIrCN7EmL6r0qLcw5fScCKFAbaOTuc=;
 b=PLRfEuZu5iIP5k1ZpXZv4FjX25ECz1m0Aqn54fNhQ3dk6u0E0NzFIx0GwL2UU+T00l
 dEWjGu6lFbw85v6GLshPjj8GSnXLPO91GxbPpyCKaj4hX5gFi1bUY5f6LCuHh9IkSQAO
 5iVnPvezc/9BgHAxSGmUXWwR0a32EC4rcPEpvfb1Ch3q2WW5SQ8UGCQDHWMh//aLox6Z
 i94JkAq93hycPmrAx5G0ICcUXyjb4QDb5x071+h+AlVno2EcFqSICJPMfE4r4F89HZeL
 zPPMQlqUIpKYIhJZ61/V4NfJr/GqZu/Vqk9qERwXfYwpb7Db44GIy2yDIrPt+06u//gX
 05/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754319465; x=1754924265;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=We4hQUS21AFyuPIrCN7EmL6r0qLcw5fScCKFAbaOTuc=;
 b=g7sYIpyDTxyZCVjBGuouufxYnZNFihIVgjkiznxOpf9HCoSjtFyHjJJpSbvbEYEYrL
 VtjLBtINMiSCGEyl6IPiz3FXWC3UNC91z75c/087y0OhmLa86MjpjA1JWUZWjlmZ8DHr
 tPlmNfB5Y5yaUAVl0CrX8vVMJoo//MKwno3QXwm9a56iuvX5aqJSnuPitRVaS0Nus72k
 UT4y7egg5pDTPSCWzB9eoUVBoMRcCszVLBZSiIknZXEKEspuXXRwO3g+eOCHbz/fG53q
 EKG2MfFbD55VZY+Kj77H7d49zx4xLKOFgY4bahdDZ6frLkRTSltNyQQGVO+nmmvGfomk
 JGDA==
X-Gm-Message-State: AOJu0YxgW5chdaa3T+wwOD0yXYd9qb9wj9a2TWadnQBgSoIdYfuskt/9
 boZzY/TFAUf33Pev0qLoZYEuyGlym/Rdt/urCSFzH1Xu+05qA7BS2NVKUOfmMbTajml1Ic8reEc
 X98V+Z7AqV06e03AYA0fRtW25HUW/JIOdWYzFBVELgAsGX+HEcPVmoX4=
X-Gm-Gg: ASbGncsWT95izlbOpQXT/cCCC1+Cjho92U276/062nq00qcG8+NqKdLnbDJ2xge+l//
 bUeZne9ZWWN3GFXf+v2b7CWfGkg7HejYgaUnWi/RA5i/Y3Vtua3UOZEf4r2gAohJ69+DznbmjI6
 dgxwy3nFuftS5aBe/Kd8l/cS8R45NZrM2r+oTo5A4LxhbPSUhAoaShNPW+FGadXZXR7eqc5oNXo
 QyOrRb72Lw3IVnZez3J0BiuZNH8rpIIefiPYjdkSHPr0J4=
X-Google-Smtp-Source: AGHT+IHpn3AHvs/+8l1EnoWSY3Es1ofq8atXNq6zAqkpCyroGIyPKDtKqDSOSqqgW2eyO/a7QNcPKb970X/NUgLHiBU=
X-Received: by 2002:a05:6402:27c9:b0:615:48f3:44a2 with SMTP id
 4fb4d7f45d1cf-615ae8dfff8mr14560877a12.10.1754319464618; Mon, 04 Aug 2025
 07:57:44 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 4 Aug 2025 15:57:33 +0100
X-Gm-Features: Ac12FXx_3_6MiIxFeWulG5XRS6e1lQbBYgdUfoX4RoUQSdiVpAnl3zhbuJQyCbg
Message-ID: <CAB+FeODh6Zhh2pRJPgps4=kzic9TU0=k62OOqdkQuq51vrMgMQ@mail.gmail.com>
Subject: kvm_log_clear_one_slot: Assertion `mem->dirty_bmap' failed
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com, bonzini@gnu.org
Content-Type: multipart/mixed; boundary="000000000000831e8a063b8b54b9"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=pb@fourieraudio.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 04 Aug 2025 12:54:49 -0400
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
Reply-to:  Pete Bridgman <pb@fourieraudio.com>
From:  Pete Bridgman via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000831e8a063b8b54b9
Content-Type: multipart/alternative; boundary="000000000000831e88063b8b54b7"

--000000000000831e88063b8b54b7
Content-Type: text/plain; charset="UTF-8"

Good afternoon,

We're seeing a rare assertion failure in production on

    qemu-system-x86_64: ../../accel/kvm/kvm-all.c:909:
kvm_log_clear_one_slot: Assertion `mem->dirty_bmap' failed.

We have seen this very occasionally in logs from devices running QEMU 7.2
on Linux 5.19
with a Windows 10 guest, seemingly spontaneously; there are no migrations
involved which
afaict has been implicated when this assertion has been hit previously
(https://bugzilla.redhat.com/show_bug.cgi?id=1772774).

We would love to be able to reproduce this (ideally on a more recent QEMU
version) so that
we can determine whether a later QEMU version has resolved the issue, and
if not file a bug
/ work on a patch, but have thus far been unable to reproduce it on demand,
with only very
occasional logs from customer devices showing this issue.

Would anyone have any ideas about what conditions might make it more likely
to reproduce,
or any pointers on what might be going wrong here - or alternatively any
thoughts about
whether a later version might be expected to resolve this?

In the following bugzilla comment:
https://bugzilla.redhat.com/show_bug.cgi?id=1772774#c11
it was mentioned that perhaps this assertion failure could be downgraded to
an early exit as
it would likely be safe to continue operation in this case. Would anyone
have any thoughts on
this? Would we be unwise to make that change (even if in just our own fork?)

I have attached our QEMU command line for reference; many thanks in advance
for any insight
or guidance. I've CCd people who were involved in a bugfix for this
assertion failure previously
(9b3a31c7) on the advice of folks in IRC, hope you don't mind.

Kind regards

Pete

Peter Bridgman (he/him)

Co-Founder & CEO

+44 (0) 7917 448150
pb@fourieraudio.com
www.fourieraudio.com

Fourier Audio Ltd is registered in England and Wales (No. 13122782)
registered at 8 Denmark Street, London, WC2H 8LS. The content of this email
is confidential and intended for the recipient specified in the message. It
is strictly forbidden to share any part of this message with any third
party, without a written consent of the sender. If you received this
message by mistake, please reply to this message and follow with its
deletion, so that we can ensure such a mistake does not occur in the future.

--000000000000831e88063b8b54b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good afternoon,<br><br>We&#39;re seeing a rare assertion f=
ailure in production on<br><br>=C2=A0=C2=A0=C2=A0 qemu-system-x86_64: ../..=
/accel/kvm/kvm-all.c:909: kvm_log_clear_one_slot: Assertion `mem-&gt;dirty_=
bmap&#39; failed.<br><br><div>We have seen this very occasionally in logs f=
rom devices running QEMU 7.2 on Linux 5.19</div><div>with a Windows 10 gues=
t, seemingly spontaneously; there are no migrations involved which</div><di=
v>afaict has been implicated when this assertion has been hit previously</d=
iv><div>(<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1772774">=
https://bugzilla.redhat.com/show_bug.cgi?id=3D1772774</a>).</div><br><div>W=
e would love to be able to reproduce this (ideally on a more recent QEMU ve=
rsion) so that</div><div>we can determine whether a later QEMU version has =
resolved the issue, and if not file a bug</div><div>/ work on a patch, but =
have thus far been unable to reproduce it on demand, with only very</div><d=
iv>occasional logs from customer devices showing this issue.</div><br><div>=
Would anyone have any ideas about what conditions might make it more likely=
 to reproduce,</div><div>or any pointers on what might be going wrong here =
- or alternatively any thoughts about</div><div>whether a later version mig=
ht be expected to resolve this?</div><br>In the following bugzilla comment:=
<br><a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1772774#c11">h=
ttps://bugzilla.redhat.com/show_bug.cgi?id=3D1772774#c11</a><br><div>it was=
 mentioned that perhaps this assertion failure could be downgraded to an ea=
rly exit as</div><div>it would likely be safe to continue operation in this=
 case. Would anyone have any thoughts on</div><div>this? Would we be unwise=
 to make that change (even if in just our own fork?)</div><br><div>I have a=
ttached our QEMU command line for reference; many thanks in advance for any=
 insight</div><div>or guidance. I&#39;ve CCd people who were involved in a =
bugfix for this assertion failure previously</div><div>(9b3a31c7) on the ad=
vice of folks in IRC, hope you don&#39;t mind.</div><br>Kind regards<br><br=
>Pete<br><br>Peter Bridgman (he/him)<br><br>Co-Founder &amp; CEO<br><br>+44=
 (0) 7917 448150<br><a href=3D"mailto:pb@fourieraudio.com">pb@fourieraudio.=
com</a><br><a href=3D"http://www.fourieraudio.com">www.fourieraudio.com</a>=
<br><br>Fourier Audio Ltd is registered in England and Wales (No. 13122782)=
 registered at 8 Denmark Street, London, WC2H 8LS. The content of this emai=
l is confidential and intended for the recipient specified in the message. =
It is strictly forbidden to share any part of this message with any third p=
arty, without a written consent of the sender. If you received this message=
 by mistake, please reply to this message and follow with its deletion, so =
that we can ensure such a mistake does not occur in the future.</div>

--000000000000831e88063b8b54b7--

--000000000000831e8a063b8b54b9
Content-Type: text/plain; charset="US-ASCII"; name="dirty-bmap-cmdline.txt"
Content-Disposition: attachment; filename="dirty-bmap-cmdline.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mdx76o8q0>
X-Attachment-Id: f_mdx76o8q0

L3Vzci9iaW4vcWVtdS1zeXN0ZW0teDg2XzY0IFwKLW5hbWUgZ3Vlc3Q9ZG9wcGxlci13aW4tYmFz
ZSxkZWJ1Zy10aHJlYWRzPW9uIFwKLVMgXAotb2JqZWN0ICd7InFvbS10eXBlIjoic2VjcmV0Iiwi
aWQiOiJtYXN0ZXJLZXkwIiwiZm9ybWF0IjoicmF3IiwiZmlsZSI6Ii92YXIvbGliL2xpYnZpcnQv
cWVtdS9kb21haW4tNC1kb3BwbGVyLXdpbi1iYXNlL21hc3Rlci1rZXkuYWVzIn0nIFwKLW1hY2hp
bmUgcGMtcTM1LTUuMix1c2I9b2ZmLHZtcG9ydD1vZmYsZHVtcC1ndWVzdC1jb3JlPW9mZixtZW1v
cnktYmFja2VuZD1wYy5yYW0gXAotYWNjZWwga3ZtIFwKLWNwdSBob3N0LG1pZ3JhdGFibGU9b2Zm
LGh2LXRpbWU9b24sa3ZtY2xvY2s9b2ZmLGt2bS1wdi1lb2k9b24sa3ZtLXB2LXVuaGFsdD1vbixo
di1yZWxheGVkPW9uLGh2LXZhcGljPW9uLGh2LXNwaW5sb2Nrcz0weDFmZmYsaHYtdnBpbmRleD1v
bixodi1ydW50aW1lPW9uLGh2LXN5bmljPW9uLGh2LXN0aW1lcj1vbixodi1zdGltZXItZGlyZWN0
PW9uLGh2LWZyZXF1ZW5jaWVzPW9uLGh2LXRsYmZsdXNoPW9uLGh2LWlwaT1vbixodi1hdmljPW9u
LGh2LWNyYXNoLGt2bS1oaW50LWRlZGljYXRlZD1vbixrdm0tcG9sbC1jb250cm9sPW9uLGhvc3Qt
Y2FjaGUtaW5mbz1vbixsMy1jYWNoZT1vZmYgXAotbSAyNDU3NiBcCi1vYmplY3QgJ3sicW9tLXR5
cGUiOiJtZW1vcnktYmFja2VuZC1tZW1mZCIsImlkIjoicGMucmFtIiwiaHVnZXRsYiI6dHJ1ZSwi
aHVnZXRsYnNpemUiOjEwNzM3NDE4MjQsIngtdXNlLWNhbm9uaWNhbC1wYXRoLWZvci1yYW1ibG9j
ay1pZCI6ZmFsc2UsInByZWFsbG9jIjp0cnVlLCJzaXplIjoyNTc2OTgwMzc3Nn0nIFwKLW92ZXJj
b21taXQgbWVtLWxvY2s9b24gXAotc21wIDEwLHNvY2tldHM9MSxkaWVzPTEsY29yZXM9MTAsdGhy
ZWFkcz0xIFwKLW9iamVjdCAneyJxb20tdHlwZSI6ImlvdGhyZWFkIiwiaWQiOiJpb3RocmVhZDEi
fScgXAotb2JqZWN0ICd7InFvbS10eXBlIjoiaW90aHJlYWQiLCJpZCI6ImlvdGhyZWFkMiJ9JyBc
Ci1vYmplY3QgJ3sicW9tLXR5cGUiOiJpb3RocmVhZCIsImlkIjoiaW90aHJlYWQzIn0nIFwKLW9i
amVjdCAneyJxb20tdHlwZSI6ImlvdGhyZWFkIiwiaWQiOiJpb3RocmVhZDQifScgXAotdXVpZCBi
NWNjMjAxZC01OGNiLTRlM2ItYjJlNy1kNTQwZTI1NDFlODUgXAotc21iaW9zICd0eXBlPTEsbWFu
dWZhY3R1cmVyPUZvdXJpZXIgQXVkaW8scHJvZHVjdD1Eb3BwbGVyLHZlcnNpb249MCxzZXJpYWw9
VEYtUkQtMCxza3U9RlRFLTAnIFwKLXNtYmlvcyAndHlwZT0yLG1hbnVmYWN0dXJlcj1Gb3VyaWVy
IEF1ZGlvJyBcCi1zbWJpb3MgJ3R5cGU9MyxtYW51ZmFjdHVyZXI9Rm91cmllciBBdWRpbycgXAot
bm8tdXNlci1jb25maWcgXAotbm9kZWZhdWx0cyBcCi1jaGFyZGV2IHNvY2tldCxpZD1jaGFybW9u
aXRvcixmZD0zMyxzZXJ2ZXI9b24sd2FpdD1vZmYgXAotbW9uIGNoYXJkZXY9Y2hhcm1vbml0b3Is
aWQ9bW9uaXRvcixtb2RlPWNvbnRyb2wgXAotcnRjIGJhc2U9dXRjIFwKLW5vLWhwZXQgXAotZ2xv
YmFsIGt2bS1waXQubG9zdF90aWNrX3BvbGljeT1kZWxheSBcCi1uby1zaHV0ZG93biBcCi1nbG9i
YWwgSUNIOS1MUEMuZGlzYWJsZV9zMz0xIFwKLWdsb2JhbCBJQ0g5LUxQQy5kaXNhYmxlX3M0PTEg
XAotYm9vdCBtZW51PW9mZixzdHJpY3Q9b24gXAotZGV2aWNlICd7ImRyaXZlciI6InBjaWUtcm9v
dC1wb3J0IiwicG9ydCI6MTYsImNoYXNzaXMiOjEsImlkIjoicGNpLjEiLCJidXMiOiJwY2llLjAi
LCJtdWx0aWZ1bmN0aW9uIjp0cnVlLCJhZGRyIjoiMHgyIn0nIFwKLWRldmljZSAneyJkcml2ZXIi
OiJwY2llLXJvb3QtcG9ydCIsInBvcnQiOjE3LCJjaGFzc2lzIjoyLCJpZCI6InBjaS4yIiwiYnVz
IjoicGNpZS4wIiwiYWRkciI6IjB4Mi4weDEifScgXAotZGV2aWNlICd7ImRyaXZlciI6InBjaWUt
cm9vdC1wb3J0IiwicG9ydCI6MTgsImNoYXNzaXMiOjMsImlkIjoicGNpLjMiLCJidXMiOiJwY2ll
LjAiLCJhZGRyIjoiMHgyLjB4MiJ9JyBcCi1kZXZpY2UgJ3siZHJpdmVyIjoicGNpZS1yb290LXBv
cnQiLCJwb3J0IjoxOSwiY2hhc3NpcyI6NCwiaWQiOiJwY2kuNCIsImJ1cyI6InBjaWUuMCIsImFk
ZHIiOiIweDIuMHgzIn0nIFwKLWRldmljZSAneyJkcml2ZXIiOiJwY2llLXJvb3QtcG9ydCIsInBv
cnQiOjIwLCJjaGFzc2lzIjo1LCJpZCI6InBjaS41IiwiYnVzIjoicGNpZS4wIiwiYWRkciI6IjB4
Mi4weDQifScgXAotZGV2aWNlICd7ImRyaXZlciI6InBjaWUtcm9vdC1wb3J0IiwicG9ydCI6MjEs
ImNoYXNzaXMiOjYsImlkIjoicGNpLjYiLCJidXMiOiJwY2llLjAiLCJhZGRyIjoiMHgyLjB4NSJ9
JyBcCi1kZXZpY2UgJ3siZHJpdmVyIjoicGNpZS1wY2ktYnJpZGdlIiwiaWQiOiJwY2kuNyIsImJ1
cyI6InBjaS42IiwiYWRkciI6IjB4MCJ9JyBcCi1kZXZpY2UgJ3siZHJpdmVyIjoicWVtdS14aGNp
IiwicDIiOjE1LCJwMyI6MTUsImlkIjoidXNiIiwiYnVzIjoicGNpLjIiLCJhZGRyIjoiMHgwIn0n
IFwKLWRldmljZSAneyJkcml2ZXIiOiJ2aXJ0aW8tc2VyaWFsLXBjaSIsImlkIjoidmlydGlvLXNl
cmlhbDAiLCJidXMiOiJwY2kuMyIsImFkZHIiOiIweDAifScgXAotYmxvY2tkZXYgJ3siZHJpdmVy
IjoiZmlsZSIsImZpbGVuYW1lIjoiL29wdC9mYS93aW4vaW1hZ2UvYmFzZS5xY293MiIsIm5vZGUt
bmFtZSI6ImxpYnZpcnQtNC1zdG9yYWdlIiwiYXV0by1yZWFkLW9ubHkiOnRydWUsImRpc2NhcmQi
OiJ1bm1hcCJ9JyBcCi1ibG9ja2RldiAneyJub2RlLW5hbWUiOiJsaWJ2aXJ0LTQtZm9ybWF0Iiwi
cmVhZC1vbmx5Ijp0cnVlLCJkcml2ZXIiOiJxY293MiIsImZpbGUiOiJsaWJ2aXJ0LTQtc3RvcmFn
ZSIsImJhY2tpbmciOm51bGx9JyBcCi1ibG9ja2RldiAneyJkcml2ZXIiOiJmaWxlIiwiZmlsZW5h
bWUiOiIvdmFyL29wdC9mYS9pbWFnZS9jdXJyZW50LnFjb3cyIiwibm9kZS1uYW1lIjoibGlidmly
dC0zLXN0b3JhZ2UiLCJhdXRvLXJlYWQtb25seSI6dHJ1ZSwiZGlzY2FyZCI6InVubWFwIn0nIFwK
LWJsb2NrZGV2ICd7Im5vZGUtbmFtZSI6ImxpYnZpcnQtMy1mb3JtYXQiLCJyZWFkLW9ubHkiOnRy
dWUsImRyaXZlciI6InFjb3cyIiwiZmlsZSI6ImxpYnZpcnQtMy1zdG9yYWdlIiwiYmFja2luZyI6
ImxpYnZpcnQtNC1mb3JtYXQifScgXAotYmxvY2tkZXYgJ3siZHJpdmVyIjoiZmlsZSIsImZpbGVu
YW1lIjoiL3Zhci9vcHQvZmEvaW1hZ2UvdXNlci5xY293MiIsIm5vZGUtbmFtZSI6ImxpYnZpcnQt
Mi1zdG9yYWdlIiwiYXV0by1yZWFkLW9ubHkiOnRydWUsImRpc2NhcmQiOiJ1bm1hcCJ9JyBcCi1i
bG9ja2RldiAneyJub2RlLW5hbWUiOiJsaWJ2aXJ0LTItZm9ybWF0IiwicmVhZC1vbmx5IjpmYWxz
ZSwiZHJpdmVyIjoicWNvdzIiLCJmaWxlIjoibGlidmlydC0yLXN0b3JhZ2UiLCJiYWNraW5nIjoi
bGlidmlydC0zLWZvcm1hdCJ9JyBcCi1kZXZpY2UgJ3siZHJpdmVyIjoiaWRlLWhkIiwiYnVzIjoi
aWRlLjAiLCJkcml2ZSI6ImxpYnZpcnQtMi1mb3JtYXQiLCJpZCI6InNhdGEwLTAtMCIsImJvb3Rp
bmRleCI6MX0nIFwKLWJsb2NrZGV2ICd7ImRyaXZlciI6ImZpbGUiLCJmaWxlbmFtZSI6Ii9vcHQv
ZmEvd2luYmluL3dpbmJpbi1jdXJyZW50LnFjb3cyIiwibm9kZS1uYW1lIjoibGlidmlydC0xLXN0
b3JhZ2UiLCJhdXRvLXJlYWQtb25seSI6dHJ1ZSwiZGlzY2FyZCI6InVubWFwIn0nIFwKLWJsb2Nr
ZGV2ICd7Im5vZGUtbmFtZSI6ImxpYnZpcnQtMS1mb3JtYXQiLCJyZWFkLW9ubHkiOmZhbHNlLCJk
cml2ZXIiOiJxY293MiIsImZpbGUiOiJsaWJ2aXJ0LTEtc3RvcmFnZSIsImJhY2tpbmciOm51bGx9
JyBcCi1kZXZpY2UgJ3siZHJpdmVyIjoiaWRlLWhkIiwiYnVzIjoiaWRlLjEiLCJkcml2ZSI6Imxp
YnZpcnQtMS1mb3JtYXQiLCJpZCI6InNhdGEwLTAtMSJ9JyBcCi1uZXRkZXYgJ3sidHlwZSI6InRh
cCIsImZkIjoiMzQiLCJ2aG9zdCI6dHJ1ZSwidmhvc3RmZCI6IjM4IiwiaWQiOiJob3N0bmV0MCJ9
JyBcCi1kZXZpY2UgJ3siZHJpdmVyIjoidmlydGlvLW5ldC1wY2kiLCJuZXRkZXYiOiJob3N0bmV0
MCIsImlkIjoibmV0MCIsIm1hYyI6IjUyOjU0OjAwOjdhOmU4OjE3IiwiYnVzIjoicGNpLjEiLCJh
ZGRyIjoiMHgwIn0nIFwKLWNoYXJkZXYgcHR5LGlkPWNoYXJzZXJpYWwwIFwKLWRldmljZSAneyJk
cml2ZXIiOiJpc2Etc2VyaWFsIiwiY2hhcmRldiI6ImNoYXJzZXJpYWwwIiwiaWQiOiJzZXJpYWww
IiwiaW5kZXgiOjB9JyBcCi1kZXZpY2UgJ3siZHJpdmVyIjoidXNiLXRhYmxldCIsImlkIjoiaW5w
dXQwIiwiYnVzIjoidXNiLjAiLCJwb3J0IjoiMSJ9JyBcCi1hdWRpb2RldiAneyJpZCI6ImF1ZGlv
MSIsImRyaXZlciI6Im5vbmUifScgXAotdm5jIDAuMC4wLjA6MSx3ZWJzb2NrZXQ9NTkwMixwYXNz
d29yZD1vbixhdWRpb2Rldj1hdWRpbzEgXAotZGV2aWNlICd7ImRyaXZlciI6InF4bC12Z2EiLCJp
ZCI6InZpZGVvMCIsIm1heF9vdXRwdXRzIjoxLCJyYW1fc2l6ZSI6NjcxMDg4NjQsInZyYW1fc2l6
ZSI6NjcxMDg4NjQsInZyYW02NF9zaXplX21iIjowLCJ2Z2FtZW1fbWIiOjE2LCJidXMiOiJwY2ll
LjAiLCJhZGRyIjoiMHgxIn0nIFwKLWRldmljZSAneyJkcml2ZXIiOiJ2aXJ0aW8tYmFsbG9vbi1w
Y2kiLCJpZCI6ImJhbGxvb24wIiwiYnVzIjoicGNpLjQiLCJhZGRyIjoiMHgwIn0nIFwKLW9iamVj
dCAneyJxb20tdHlwZSI6InJuZy1yYW5kb20iLCJpZCI6Im9ianJuZzAiLCJmaWxlbmFtZSI6Ii9k
ZXYvcmFuZG9tIn0nIFwKLWRldmljZSAneyJkcml2ZXIiOiJ2aXJ0aW8tcm5nLXBjaSIsInJuZyI6
Im9ianJuZzAiLCJpZCI6InJuZzAiLCJtYXgtYnl0ZXMiOjEwMjQsInBlcmlvZCI6MTAsImJ1cyI6
InBjaS41IiwiYWRkciI6IjB4MCJ9JyBcCi1kZXZpY2UgcWVtdS14aGNpLGlkPXhoY2ktZXh0ZXJu
YWwsYWRkcj0weEYscDI9MTUscDM9MTUgXAotZGV2aWNlIHVzYi1ob3N0LGJ1cz14aGNpLWV4dGVy
bmFsLjAsaG9zdGJ1cz0xLGhvc3Rwb3J0PTEyLHZlbmRvcmlkPTB4MDg4ZSxwcm9kdWN0aWQ9MHg1
MDM2IFwKLWRldmljZSB1c2ItaG9zdCxidXM9eGhjaS1leHRlcm5hbC4wLGhvc3RidXM9MSxob3N0
cG9ydD0xMC4xIFwKLWRldmljZSB1c2ItaG9zdCxidXM9eGhjaS1leHRlcm5hbC4wLGhvc3RidXM9
MSxob3N0cG9ydD0xMC4yIFwKLWRldmljZSB1c2ItaG9zdCxidXM9eGhjaS1leHRlcm5hbC4wLGhv
c3RidXM9MSxob3N0cG9ydD0xMC4zIFwKLWRldmljZSB1c2ItaG9zdCxidXM9eGhjaS1leHRlcm5h
bC4wLGhvc3RidXM9MSxob3N0cG9ydD0xMC40IFwKLWRldmljZSB1c2ItaG9zdCxidXM9eGhjaS1l
eHRlcm5hbC4wLGhvc3RidXM9MSxob3N0cG9ydD0zIFwKLWRldmljZSB1c2ItaG9zdCxidXM9eGhj
aS1leHRlcm5hbC4wLGhvc3RidXM9MSxob3N0cG9ydD00IFwKLWRldmljZSB1c2ItaG9zdCxidXM9
eGhjaS1leHRlcm5hbC4wLGhvc3RidXM9Mixob3N0cG9ydD0zIFwKLWRldmljZSB1c2ItaG9zdCxi
dXM9eGhjaS1leHRlcm5hbC4wLGhvc3RidXM9Mixob3N0cG9ydD00IFwKLXNhbmRib3ggb24sb2Jz
b2xldGU9ZGVueSxlbGV2YXRlcHJpdmlsZWdlcz1kZW55LHNwYXduPWRlbnkscmVzb3VyY2Vjb250
cm9sPWRlbnkgXAotZGV2aWNlICd7ImRyaXZlciI6Iml2c2htZW0tZG9vcmJlbGwiLCJpZCI6InNo
bWVtMCIsImNoYXJkZXYiOiJjaGFyc2htZW0wIiwidmVjdG9ycyI6MSwiaW9ldmVudGZkIjp0cnVl
LCJidXMiOiJwY2kuNyIsImFkZHIiOiIweDEifScgXAotY2hhcmRldiBzb2NrZXQsaWQ9Y2hhcnNo
bWVtMCxwYXRoPS90bXAvaXZzaG1lbV9zb2NrZXQgXAotbXNnIHRpbWVzdGFtcD1vbgo=
--000000000000831e8a063b8b54b9--

