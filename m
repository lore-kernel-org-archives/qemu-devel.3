Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF73BFED3E9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIbu-0001ev-4Q; Fri, 24 Apr 2026 11:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGIbr-0001ee-2v
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:38:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGIbo-0005wq-Ko
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:38:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso38357995e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777045102; x=1777649902; darn=nongnu.org;
 h=mime-version:cc:to:from:importance:subject:date:savedfromemail
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6ro3fdCBCUJOaaIdp3xv0hByjIqt34nC2nxRPnaPakY=;
 b=FOsuukYU0mBgEvC4Kd+sw2hW/4/GXewRMVPgmEWHoa+z3bhjq2eOA3sxBGxkZF5NfY
 b8EGH5K9wD23E4lP7rCjgcKpvavuSOxqT/Jg36/DlsC97mVrS3Ojh/uufpb6A6ESaDbB
 Cp6qOwGJwEKxSIqPoYouvLkMgHWJXP14gQoLNfo7XcIswDO+TlCTkCaDjAb4/IhpukCk
 LrDJ3gVlKrXVai9uDJFA5e9Lm7Z+txFJQnL9X7YqhekwWJdMql93zWsl3NDyrKhDfVBj
 kiSqBt6fbHLwuA/tcjXWdRn3F6uP1FpqL+65FS+oW8byI821ba9yMDLV9HUieC2c+DmG
 ECww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777045102; x=1777649902;
 h=mime-version:cc:to:from:importance:subject:date:savedfromemail
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ro3fdCBCUJOaaIdp3xv0hByjIqt34nC2nxRPnaPakY=;
 b=nnzkI3kl4kP1oY9FIJgmuV98MWlstQ18ED7PLjXYc0RJwUIdfVyqASS4YCTzAaTVMw
 svBDyWQPNRKB4qXU0l5TAqyKIpwSThc+gioniqF0WzjXKQbs6S25XPTj3Kcmgi08iQlE
 GgTzn8vZQ+hA018nWSakg8nyz+mkST8DlEWQKmkZFZDGF2NcysMso6uLWIGidxkS9HRK
 hUOS58iyYgfUUqNNjG7bnIdKZDfT5ACuN4Z/FLkpN4F3BEBXK4VYhDKz+6Umf50oy13i
 kqgK97JC4CazZnoiakDKHpkon+9suL0ASz/obIA7MZv8KODWA3lzKM967+Y+dI1j3+EI
 ibzw==
X-Gm-Message-State: AOJu0YwGQs3sXR1ABKV6HSKzxXXCA3teCueE611c0xIWTeRnA+rYm0Bi
 NfaW3WnB2Ter2bfvTkeefOoc2dlmF5k3D6yecZEHxfK/PcPT7Gwx/BL7
X-Gm-Gg: AeBDievztho3VAjFDstPuJk2yt8LVpVOFtkLTFLMZBeIe7JxoTK5EVemDywD5aWD9DD
 ZKQjqSY2iiUoKc17vivx7T2zfuyHnPrj4RKAhghGEf3c+hDt8KSllauWtgn70OduVpDvcZTBJi2
 coeYuLtZpyJLOZReRly4d/T/Z0911+uRrUpxStTHVUGqjnP5mNv0HkUJv0pDzutGchwXNNzJnv7
 5g2Ns5lA+w/ZjyHoKDqX+8u5X+GBzA2TDa3C6CdYSRgM0HqJ8FoaWno3dDsm4NH1Ktfl4FVy9NV
 igARnE5mCf/aETd8dqIOng1PLyHk9IP4h6GUWvDbtryZ6wU1S3VfpvKCtlAWgbeHir/T9U9mw4Z
 EKnG32OkfRckadoGcnfIvj2IGiWdeu2NUmaaRHRBcWEKP+p9zwSPp5oirpLiUzpYRPY8w8l0pMN
 QhDSbsInrOID+fN6UYcr1Kk8T4mT5hwBihFd28MZci7J5YShaXdLIC
X-Received: by 2002:a05:600c:8883:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48a582167c7mr176878835e9.8.1777045101774; 
 Fri, 24 Apr 2026 08:38:21 -0700 (PDT)
Received: from [192.168.100.13] ([188.138.129.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5aa3ae83sm386417375e9.12.2026.04.24.08.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 08:38:21 -0700 (PDT)
Message-ID: <69eb8e6d.050a0220.d6a14.a85a@mx.google.com>
SavedFromEmail: elisey.konstantinov@gmail.com
Date: Fri, 24 Apr 2026 18:38:20 +0300
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
Importance: normal
From: "elisey.konstantinov" <elisey.konstantinov@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--_com.samsung.android.email_216966584498990"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

----_com.samsung.android.email_216966584498990
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

VGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBmZWVkYmFja0nigJl2ZSB1bmRlcnN0b29kIHRo
ZSBsZWl0bW90aWYgb2YgeW91ciBtZXNzYWdlcywgYW5kIGFmdGVyIGdpdmluZyBpdCBzb21lIHRo
b3VnaHQsIEnigJl2ZSBjb21lIHRvIGZ1bGx5IGFncmVlIHdpdGggaXRXZWxsIHRoZW4sIEnigJlt
IHJlYWR5IHRvIHRha2Ugb24gdGhlIHRhc2sgb2YgaWRlbnRpZnlpbmcgdGhlIFVDb250ZXh0IGJ1
ZyBvciBob3cgUUVNVSBpbnRlcmFjdHMgd2l0aCBpdEhvd2V2ZXIsIHBsZWFzZSBrZWVwIGluIG1p
bmQgdGhhdCBJ4oCZbGwgb25seSBiZSBhYmxlIHRvIGdldCB0byBpdCBpbiBhYm91dCBhIHdlZWvi
gJlzIHRpbWUsIGFuZCBJ4oCZZCBhbHNvIGFwcHJlY2lhdGUgYW55IGhlbHAgb24gR2l0TGFiIDpd
TWluZCB5b3UsIHNvbWV0aGluZyB0ZWxscyBtZSAod2hpY2ggaXMgd2h5IEkgbWVudGlvbmVkIHRo
YXQgaW52ZXN0aWdhdGluZyB0aGUgVUNvbnRleHQgaXNzdWUgd291bGQgdGFrZSBzb21lIHRpbWUp
IHRoYXQgdGhlIHByb2JsZW0gbGllcyBub3Qgd2l0aCBRRU1VIGFmdGVyIGFsbCwgYnV0IHdpdGgg
VUNvbnRleHQgaXRzZWxmLi4uCg==

----_com.samsung.android.email_216966584498990
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPjwvaGVhZD48Ym9keSBkaXI9ImF1dG8iPlRoYW5rIHlvdSB2
ZXJ5IG11Y2ggZm9yIHlvdXIgZmVlZGJhY2s8ZGl2IGRpcj0iYXV0byI+SeKAmXZlIHVuZGVyc3Rv
b2QgdGhlIGxlaXRtb3RpZiBvZiB5b3VyIG1lc3NhZ2VzLCBhbmQgYWZ0ZXIgZ2l2aW5nIGl0IHNv
bWUgdGhvdWdodCwgSeKAmXZlIGNvbWUgdG8gZnVsbHkgYWdyZWUgd2l0aCBpdDwvZGl2PjxkaXYg
ZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPldlbGwgdGhlbiwgSeKAmW0gcmVh
ZHkgdG8gdGFrZSBvbiB0aGUgdGFzayBvZiBpZGVudGlmeWluZyB0aGUgVUNvbnRleHQgYnVnIG9y
IGhvdyBRRU1VIGludGVyYWN0cyB3aXRoIGl0PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkhvd2V2ZXIs
IHBsZWFzZSBrZWVwIGluIG1pbmQgdGhhdCBJ4oCZbGwgb25seSBiZSBhYmxlIHRvIGdldCB0byBp
dCBpbiBhYm91dCBhIHdlZWvigJlzIHRpbWUsIGFuZCBJ4oCZZCBhbHNvIGFwcHJlY2lhdGUgYW55
IGhlbHAgb24gR2l0TGFiIDpdPC9kaXY+PGRpdiBkaXI9ImF1dG8iPk1pbmQgeW91LCBzb21ldGhp
bmcgdGVsbHMgbWUgKHdoaWNoIGlzIHdoeSBJIG1lbnRpb25lZCB0aGF0IGludmVzdGlnYXRpbmcg
dGhlIFVDb250ZXh0IGlzc3VlIHdvdWxkIHRha2Ugc29tZSB0aW1lKSB0aGF0IHRoZSBwcm9ibGVt
IGxpZXMgbm90IHdpdGggUUVNVSBhZnRlciBhbGwsIGJ1dCB3aXRoIFVDb250ZXh0IGl0c2VsZi4u
LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvYm9keT48L2h0bWw+

----_com.samsung.android.email_216966584498990--


