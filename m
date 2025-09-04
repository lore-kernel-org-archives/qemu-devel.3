Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CEDCA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 02:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu0Bt-0002hY-E0; Wed, 03 Sep 2025 22:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0Bo-0002gK-Pc; Wed, 03 Sep 2025 22:59:08 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0Bl-0002Df-6L; Wed, 03 Sep 2025 22:59:06 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4cf40cd0d1so444388a12.0; 
 Wed, 03 Sep 2025 19:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756954743; x=1757559543; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6bhDyuP8uZ0IHn55YBLu4IA83FNFTTzPmIxfP2mLmW4=;
 b=PiPPhk+Fk5o57OA7EGbjfm++O3GBsY+3nkVTTQrxiW0eIf7cigxmwwDCx/KUCZeJKG
 j6QJh30CLhlkRdUi+gZbVc43bTs+ww1YiHNuyrsh01O/+hrwsIAJ0z+ic/q3mcedLE67
 ModQIusSGeU1HgixmJMn0GZBeukFDAGw/ttylWpw42ERJCVqtx7LjgBdyjtldLo8ZPF7
 9IlggrU5G3UJbRaD71MexsM85wG4L3Sz9KJghZSCVod7PoJeBfU24AnkGlVRIbTrX8xG
 OGmABmYA75wF+Pyi+QZ+6SIKu5d9Up2DbpPfwFwmhZJQDI+MvenHxknt+QhUqeuR9beR
 cWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756954743; x=1757559543;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6bhDyuP8uZ0IHn55YBLu4IA83FNFTTzPmIxfP2mLmW4=;
 b=vogGDbr2fZM0VIApQ2Vso6sez250dlxd1kbgnRNYYv/l5xcugTGBJ4IhxIzbL8dC3L
 7jtWLLlZtkUlADf5qFtr9cUFu6c/GmeHUcdnZRF/F85fdrNRP4gLffwI9se5ipR9mDsf
 Czx4xFary9gnw2GSuS0UQZjdV5m9c4ImD7dRfyTqxXo2KXHESjK2skXlZumzkNsDDzgi
 NwaH2Ar04qAHiAcf00GWrnBas8/1m3+joJUNMRCHCAW0i6+F2zzPgZdklD14A1jnix52
 MlOi6f8E+Ik3HKTR7wLnL+2I4uYD0aqxNab6YCVn0S80ZmKkFFCqDz885i8SeezVZjRD
 7smA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUok0Ey3kusTGNtdiM38HD68oRoT6qU5Kg1G6cKaRXz/j3VlBGZKBf7ZNKFNE3urC78HOz67FgQX2YgdQ==@nongnu.org,
 AJvYcCV44ZLQpyMbdILgdvY0wBp4I0kdi7rjgLWD5fT24ttRvDHW2fwarbIFIDq1NzQhDLU+4KPj6lvZejoz@nongnu.org
X-Gm-Message-State: AOJu0YzbCGcywXtCWjAr+5G3UW6qaxR2LZKB/103jGfZxYVcE0ty7h5d
 9wChNFAelq/T9uRNTfR1LxC6KtuW87yjBIrp3Y8M09YuHFUm9KtYkUqY
X-Gm-Gg: ASbGnct4/vfIg+qmRoM2GAwUQafRL266rKH7zQvfE64xOwNGg/v3gv+uOErWAqfZH8X
 /327RVTVL3jn6wGeDIqjxKwx/uomHEAXC2zrxaQh6M1SWIhPITzOU3jVtS9tPktJAfsCX+amABZ
 SOytXc3MUTJIHF/3XWebZQjl2GXOkZ7tbkrj5n9AWN6jSzzVFwp/N9gdfaq2nnwcylxLTlzu9iS
 dzs+CxPyTo++zmdD/Y6ReqxLYhxrfo+tWuXU9/OTH4wxhWEG1J5Ukjk76HmM4rlltUfKaGzXZuh
 AtBVgLcQlgy8pzrtmAYg2+3aPZfxVIz1L60K+3xhhSRbBYnzbVcXhW04sjH/UgTcPhyKbi6SfgI
 9qV9dQrPIHM2EdV8NtCTAdL4ZlrzAyw2wyApAYvnUSfJuQ2c=
X-Google-Smtp-Source: AGHT+IFJE02c1RcTWmdZ7oB4KhxjslF89qxqIbquEWfmzvvc1U/JuVe3cq4La9aTl40pe0FeaJLrAw==
X-Received: by 2002:a17:903:3d0d:b0:24c:8984:5f9c with SMTP id
 d9443c01a7336-24c898478c6mr61905715ad.36.1756954742968; 
 Wed, 03 Sep 2025 19:59:02 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24cb28e33d7sm15660295ad.89.2025.09.03.19.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 19:59:02 -0700 (PDT)
Message-ID: <852755e33a0a6d1ca962283c7813b76fc5e5ef3f.camel@gmail.com>
Subject: Re: [PATCH v3 3/5] hw/nvme: add NVMe Admin Security SPDM support
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>,  Jesper Devantier	 <foss@defmacro.it>, Stefan Hajnoczi
 <stefanha@redhat.com>, Fam Zheng	 <fam@euphon.net>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,  Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>
Date: Thu, 04 Sep 2025 12:58:56 +1000
In-Reply-To: <aLgOlzuRwi0-_cvy@AALNPWKJENSEN.aal.scsc.local>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
 <20250901034759.85042-5-wilfred.opensource@gmail.com>
 <aLgOlzuRwi0-_cvy@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x531.google.com
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

On Wed, 2025-09-03 at 12:01 +0200, Klaus Jensen wrote:
> On Sep=C2=A0 1 13:47, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > Adds the NVMe Admin Security Send/Receive command support with
> > support
> > for DMTFs SPDM. The transport binding for SPDM is defined in the
> > DMTF DSP0286.
> >=20
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > ---
>=20
> > +/* From host to controller */
> > +static uint16_t nvme_security_send(NvmeCtrl *n, NvmeRequest *req)
> > +{
> > +=C2=A0=C2=A0=C2=A0 uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> > +=C2=A0=C2=A0=C2=A0 uint8_t secp =3D (dw10 >> 24) & 0xff;
> > +
> > +=C2=A0=C2=A0=C2=A0 switch (secp) {
> > +=C2=A0=C2=A0=C2=A0 case NVME_SEC_PROT_DMTF_SPDM:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nvme_sec_prot_spdm_s=
end(n, req);
>=20
> If spdm_socket is not set, I think this should be Invalid Field in
> Command too, right? Same for receive.
Yeah! it should be. will fixup in V4.

Thanks,
Wilfred
>=20

