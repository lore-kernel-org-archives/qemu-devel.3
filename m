Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73ACC624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1N6i-0006uC-F8; Tue, 01 Sep 2026 07:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x1DMc-0003EJ-60
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 21:32:38 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x1DMa-0003Ad-HB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 21:32:37 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66e5d39cfe1so2058389d50.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788226355; cv=none;
 d=google.com; s=arc-20260327;
 b=iLlkFlZJZeyHG0mjl1473W6c8a/GRHk16JD3EDxeHIIhB1gVBvug0SdxwTrjECUy+P
 mNKXrtMxjqIifpJFMnhqwDtQ4F97woBGHwE4+Oo+TsTvhm8c/WtY2UYzPO7/Rn7o7O1S
 SE4PANGVIX1wAwaC2BifssUWZgdvHLLxG2ZWboSomXmniLGGpCuh6CL+WlVa/Usyo+cE
 xJvHoglzkzqbwD1W6ukdU7Y4EXO7OvdAYBklMI2mrC4asC2KEQd0VPouaHkF/oYaW0eg
 PhXK0rQKLrZFL6dGJEE1KLQp9ZPix+tkqPDhfcbDHsAt8RbcbMK/6uROJUatOoKMDziF
 ZAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=gWcFKAmhLAR14Y5QDnQw8pNSjtdfdiU1rPQNQzkk9YE=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=UDZQWMGqu+uQN4FX9kg/at8m4aPTSqEucDXR5BlYrhlrciJZihm2p3xi4hYPyeaqcW
 uv6WnBXMllKIBoj0MwEdeDn/uqXErcap/flSMYgsAbnuZ86C7rh13h8GYf5gqa+1hP9q
 X9FXKqxiX2LwNZVOntoPI3V9SfsYPYo4XBHW8ZIsAD1B8cX2RHI/INojwGg2jp5ZJK0o
 fVxhcVEL0Pjs4SnbzNZn37+jfdVE0rhAMtdYcZrsRVM06D/JpbPIcaJujI4P8EH5c9Us
 XzZFI1hoJP3m6wi45XtqXcv8WaJCdk5PgXAaorZHhuuumtzlkjsJzJy3++2y5x2CE4t2
 vbOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788226355; x=1788831155; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gWcFKAmhLAR14Y5QDnQw8pNSjtdfdiU1rPQNQzkk9YE=;
 b=FjFCccA+RlhBbecncwPsrXIude/AtV86R5x6kye/q/xqe071x89sDOPm45FTeM8q+n
 qpjbJD1C27xka4HPPAtrTYLSJ/EkJVPQLcyPXrLf8YouROQU8LQALTLd9t5TDf8eF/M4
 rDb6+PxOulxFSgVvVmoIxjLTyxoDAf376LkzlZ8pNtFeMyoCeQq3Hu86wR+EvHMrsPbM
 6oU29xhxSU3zB8MED13JQukRFUAZJrsl7nTwJqTj2ABpyXwq3C10vST1fITIhn/12K9i
 8NhXG3++sf7dvdtXAklt16B4bBmvI3MDWdIfGFJrX8KzJkDRfFgK9deuAd6vcuMPMkw3
 5DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788226355; x=1788831155;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gWcFKAmhLAR14Y5QDnQw8pNSjtdfdiU1rPQNQzkk9YE=;
 b=SvsuuD447iFQkJwf4+LEdMKMcwRg4Vpdigo2t3tiGkmTkkf8q1wruoFXdsSOi6U4rO
 XRpzBdI3VyCDV0os5tqUG2/97dK/kbdzoEj/usCSNphYg7lDlN5+k4gdEkRvqfV/sRBd
 BAf4bj6da+sOxSGPqoOJN7ZtnWOOoL3ITMdvHC3D/gkqK4JDDptVGmkTqmpCINb9RcXl
 BOwlrFZMwvcG8AB0usyAfJ9hT4OZ/E6foJ1WVugFPRkQi6muBz0Kk+iZ0l0OxyIKZKWX
 mTuBJjg4Lc5FXQRDaLXzaDhiOkYyPpGZfv2Wowg8J2oWxoLRPa7XjqOF5vQuDgxJX6if
 Bvog==
X-Gm-Message-State: AFuF++lk37q9IrQDelmagVVGkDVkypWIWIKCKxxJercMxrZKiLe0Uu7F
 FF3wIM2TBqW7DaYF4zH/5SpkFCgLW2L14jZrrEJ9kF8mQO80RTT+8Lg2bxXNIUoO/SN/UZNRow7
 NNbgnn942YCY8aeN3510LRSzZRzUj8bjhOpSlM4c=
X-Gm-Gg: AYBFou1IJQftUEMFycbnvkCxsmBugodKUWGo3Yzz0bGyXpJUfPMfwJuGrw3dYMOEmH9
 nzE8LZw7MZxQMkVNU/vDAM5Bx7sjn7MdFZjty0G87t7CXKBg/ffsqYjXmMrAyva+m63aIzNX2pw
 vnhqcHyImAmfGpU+525UksZNAKUdqAXhzKtYWOi2efGoysgiR08i+yV9nTWyfyN2ePjuVIn2FA0
 fsx5EyD79dHlkElfzubEOcipujacsQ4e6aPWr4gXpyy2PdDi06LAUONg9Uh/G/iNF2Irj5zbxBZ
 C9BODJpD91UZtxsikcXbz7fGPpEQOEWLjABct7K3WjehNw==
X-Received: by 2002:a05:690e:3d0:b0:66d:1a5a:1d27 with SMTP id
 956f58d0204a3-66e4c6985f4mr5844050d50.12.1788226354597; Mon, 31 Aug 2026
 18:32:34 -0700 (PDT)
MIME-Version: 1.0
From: rick vernam <rtvernam@gmail.com>
Date: Mon, 31 Aug 2026 20:32:22 -0500
X-Gm-Features: AcwNN1WjHmZTcWxDqbeW3_AEWxs69ov4FXwCB_ECElhVQC3LsNDCbMwezjKoBCw
Message-ID: <CAFH9MbUdL=HuSvqpwHF-1yo-MeCGREQoqKjdT7us=5CiKSxp3w@mail.gmail.com>
Subject: qemu-vdagent guest to host clipboard sync
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a4d390065a61e498"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=rtvernam@gmail.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:56:50 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000a4d390065a61e498
Content-Type: text/plain; charset="UTF-8"

Hello,

With -display dbus, clipboard sync only works host to guest; guest to host
fails without any failure messaging.

The guest's 'clipboard-grab' message is received correctly by ui/vdagent.c,
but ui/dbus-clipboard.c:dbus_clipboard_update_info() drops it before it
ever reaches the D-Bus display client.
Checking info->has_serial in dbus_clipboard_update_info() always fails for
guest to host as has_serial is never assinged:

if (self_update || !info->has_serial) {
    return;
}

Steps to reproduce:
1. Start QEMU with:
   "-display dbus,gl=on -chardev qemu-vdagent,...,name=vdagent,clipboard=on
-device virtserialport,...,name=com.redhat.spice.0"
2. Connect a D-Bus display client implementing "org.qemu.Display1.Clipboard"
3. In the guest, copy text to the clipboard.
4. Observe on the host side.

Expected result:
Guest clipboard content is forwarded to the D-Bus client via
"Clipboard.Grab".

Actual result:
Nothing is forwarded. "dbus_clipboard_update_info()" returns early, a
subsequent "Clipboard.Request" from the host fails with "Empty clipboard".

Fix tested locally:
Removing the check of info->has_serial resolves the issue with no observed
regression on Windows or Linux guests:

-    if (self_update || !info->has_serial) {
+    if (self_update) {
         return;
     }

I didn't really consider an approach of setting info->has_serial as that
looked like a larger patch, and it appears dbus_clipboard_grab() takes a
similar approach to this fix by setting has_serial unconditionally for host
to guest clipboard sync.

I believe this if statement has been unchanged since the initial commit
ff1a5810f61f78b47ddad995f49bcc70171d9e38 "ui/dbus: add clipboard interface".

Thanks,
- Rick

--000000000000a4d390065a61e498
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div>With -display dbus, clipbo=
ard sync only works host to guest; guest to host fails without any failure =
messaging.<br><br>The guest&#39;s &#39;clipboard-grab&#39; message is recei=
ved correctly by ui/vdagent.c, but ui/dbus-clipboard.c:dbus_clipboard_updat=
e_info() drops it before it ever reaches the D-Bus display client.<br>Check=
ing info-&gt;has_serial in dbus_clipboard_update_info() always fails for gu=
est to host as has_serial is never assinged:<br><br>if (self_update || !inf=
o-&gt;has_serial) {<br>=C2=A0 =C2=A0 return;<br>}<br><br>Steps to reproduce=
:<br>1. Start QEMU with:<br>=C2=A0 =C2=A0&quot;-display dbus,gl=3Don -chard=
ev qemu-vdagent,...,name=3Dvdagent,clipboard=3Don -device virtserialport,..=
.,name=3Dcom.redhat.spice.0&quot;<br>2. Connect a D-Bus display client impl=
ementing &quot;org.qemu.Display1.Clipboard&quot;<br>3. In the guest, copy t=
ext to the clipboard.<br>4. Observe on the host side.<br><br>Expected resul=
t:<br>Guest clipboard content is forwarded to the D-Bus client via &quot;Cl=
ipboard.Grab&quot;.<br><br>Actual result:<br>Nothing is forwarded. &quot;db=
us_clipboard_update_info()&quot; returns early, a subsequent &quot;Clipboar=
d.Request&quot; from the host fails with &quot;Empty clipboard&quot;.<br><b=
r>Fix tested locally:<br>Removing the check of info-&gt;has_serial resolves=
 the issue with no observed regression on Windows or Linux guests:<br><br>-=
 =C2=A0 =C2=A0if (self_update || !info-&gt;has_serial) {<br>+ =C2=A0 =C2=A0=
if (self_update) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =
=C2=A0 =C2=A0}<br><br><div>I didn&#39;t really consider an approach of sett=
ing info-&gt;has_serial as that looked like a larger patch, and it appears =
dbus_clipboard_grab() takes a similar approach to this fix by setting has_s=
erial unconditionally for host to guest clipboard sync.</div><br><div>I bel=
ieve this if statement has been unchanged since the initial commit ff1a5810=
f61f78b47ddad995f49bcc70171d9e38 &quot;ui/dbus: add clipboard interface&quo=
t;.</div><div><br></div><div>Thanks,</div><div>- Rick</div></div>

--000000000000a4d390065a61e498--

