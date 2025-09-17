Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930CFCAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywuf-0001Wx-KQ; Wed, 17 Sep 2025 14:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uywud-0001WX-9t
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:29:51 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uywua-0004v3-Kn
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:29:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3dae49b1293so20370f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758133787; x=1758738587; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xXrGZWL843p7/daUUCxGhZOGupFHmwmkBDrpVRnKef0=;
 b=V1a+qPhklp8Nq/9N9zKcCAkisU5LNON/IXnLBCZAWTrH5DN9Ymv6NrFJzPzO1ZuuBI
 CI1yz3L4p/DbvPRvrKq+MVX/fceqik9IruphGugl38sxjux8wbE/A2L5BG9FqFK9LhTa
 gNNs5hGf1Wi/Sr/n24vgvdIUvujVCKaCZTpOQ+l88J3RN2Xkk5xw//uTW2MaDtW9INA+
 gjiE++SynYESJV0Grii4Y54LzrDewQq+5Woe1RZz3YagqiTEsWkoOY/j/+Ore05cx4o8
 ahm0tQoIKiExcOvj5adqXFKaYsjQ7ssyMLSzNc+ZDf2bs0IDg4O6a9nFVifT7IZxBZKu
 Pqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758133787; x=1758738587;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xXrGZWL843p7/daUUCxGhZOGupFHmwmkBDrpVRnKef0=;
 b=Ltxkbeyk8ExPWNg9tXH6xKH2AMVLzHz4xT0V/EcszfHDmRJP2b4jCxAy4FMQD88+fA
 6dih0sc6Ll7JNtiopMHqDAvvlWmai1FK5O/CYjbI76MBr7q90gfjdXAodBrrWdbJnFwa
 ALOA2z8WEWih2ONdpM/hXFk2JpbY9M5gE+ybCm4MovlbOiaIVe+2ts6E2tsY37ktFbFI
 xRFFx6YpCtKrrgw9HapMhFdVYDGDZg8oGGFr81Sa25nueYUGvFMeMAbdrwV1cql5y3LV
 tQ31KzNHglH9RBRejvaWK70lcCDqHHIZBEJ8eTyw1yHyFvK4E5ViCCP6cYWHMDXUqX/F
 mRYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV668ZysvB86yaPg0M/GBfHvFsOwFAxLjbVMmTODkltj4KW3Z3X5dUiTWdvso55DrjvwzqMPmapvvUK@nongnu.org
X-Gm-Message-State: AOJu0Yz60a4yICYtACCw/KFge/hjbffUr6PDd2iqOA5k6ZcVSiYeVeI0
 Iu7I8C62SUTlnYU8YdOFuMQ9/VOrO2ce4sMQi4Ha7wxvT8EyjByKSqcM
X-Gm-Gg: ASbGncu7jP/eNa+dXfj0Jr8UlqQTZrmui0jf0bDNtxzFVlNZW94O2LFANZbgz1HeGeu
 cGgLygg9NSDVGw2x/9nANR9VT5Qa3dO/GfHkCne3sE3WSCGa2qaSAaZOcyidFFJERSvgOhyYOzS
 ujld/tZf1R62TnFb9775LnaxJkHFnSO8hQTHJ6Buckx+d29TVpUJpLtfnvsWFru/fkSTubrn/65
 FDws+W/dn7vvmGINq7WIZy7r45mZeiEnN6ls7QsvdX7w14Y4UOY/T1sdttY385S9i80LCm8/1aJ
 fblJ852RI9QWB4ijXeF9T7G76d6Wf8f/n3NOkWpO4YAptk8lRotPNb7q0Kf53lbgtfVJjgBQn3D
 BQIBBk57p6nbLoi7uQnzppqD9SkuM4PFEbFLf+VLvY8XIzTvTNeqjNct8NA==
X-Google-Smtp-Source: AGHT+IEy7dmkRVvsF6BGQxJNYXYQPobNOMToVtUpRysfGRKBMuSd6J8bwT9vH8K5XD/DERXBabs+Hg==
X-Received: by 2002:a05:6000:2207:b0:3ec:db87:fff7 with SMTP id
 ffacd0b85a97d-3ecdf9d1634mr3318059f8f.26.1758133786404; 
 Wed, 17 Sep 2025 11:29:46 -0700 (PDT)
Received: from [192.168.232.93] (37-48-56-34.nat.epc.tmcz.cz. [37.48.56.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbd63c0sm307239f8f.47.2025.09.17.11.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 11:29:42 -0700 (PDT)
Message-ID: <15cc6bcd675f2e20efe4fbd6332018a693122b9c.camel@gmail.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, amit@kernel.org, 
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, 	marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, 	noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org, 
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Date: Wed, 17 Sep 2025 20:29:39 +0200
In-Reply-To: <aMr1sn-LU2f-w49o@redhat.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
 <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
 <aMr1sn-LU2f-w49o@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2025-09-17 at 18:53 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Sep 17, 2025 at 07:11:03PM +0200, Filip Hejsek wrote:
> > On Wed, 2025-09-17 at 17:17 +0100, Daniel P. Berrang=C3=A9 wrote:
> >=20
> > > We shouldn't send any size info to the guest if the hsot backend
> > > does not have it available.
> >=20
> > Does that mean sending 0x0, or not sending anything at all? The later
> > is tricky,=C2=A0because for non-multiport devices it's only really poss=
ible
> > by not offering the feature bit, but we don't know upfront whether the
> > size command will be used.
>=20
> Nothing at all - is in no difference from current QEMU behaviour.

As I said, that's not possible with the current semantics of the resize
command, as we would need to know upfront whether it is going to be
used.

To get the exact same behavior as current QEMU, we would need to add
some way to inform QEMU whether we want to use the resize command (e.g.
device property).

Even then, depending on how you interpret the virtio spec, there would
be a problem with multiport devices if port 0 didn't support size, but
another port did. Not providing port 0 size can only be done by not
offering the size feature bit, and then the question is, can you still
send resize events for the other ports? The spec does not say either
way.

Note that getting the exact same behavior as current QEMU is still
possible by disabling the console-size property on the virtio-serial
device (but it applies to all ports).

With regards,
Filip

