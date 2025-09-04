Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F9CCA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 02:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu098-0000ko-EJ; Wed, 03 Sep 2025 22:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu096-0000b4-F8; Wed, 03 Sep 2025 22:56:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu094-000101-Iu; Wed, 03 Sep 2025 22:56:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7723cf6e4b6so490147b3a.3; 
 Wed, 03 Sep 2025 19:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756954576; x=1757559376; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UTeM3pF6tjSudTUXn4D92hIKbyPHRJkYz5FFp7+nbpE=;
 b=b+qcMdrd0wxaehNLQTio1vckye40PJE1f3PL30P3L9qMXCc801lYKPSYkrrih2mUWx
 Nw6jZVItXP5hELSQgXT1PQQann+t5LcCIGfiEM1MryxtfGp7S+rnSACQeF91DR9AA9xa
 DQMBHnIVKFyhUJ++Cvus5nbtqGRJpT2zqHAYHePV3zKH6kXsGkhpu+qkeVL3t1ZwZ499
 uUAI0oasEtPIsIVIDHqh4AoqGq0f6h7RIf7sY1/jm4A9zJmB+cWQ26cE11omySZatdqX
 nd4/0ATn0gQc0d4bIka5IAmWZYBoOhIgRSUN0TfLL6wK+gv+HJiVOqX2D8sbb7lJqCmw
 FiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756954576; x=1757559376;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTeM3pF6tjSudTUXn4D92hIKbyPHRJkYz5FFp7+nbpE=;
 b=peELdlZe/7rBpHXeTlKQ2wIVhyhXopZTQQiJYYF3fsBqIMdtgCLkw/KB2z4+acxszC
 VUfwsSTRy68OfnW4wWb8vcltaSLAwoO5hfB4N8+HIKQN5QsX2+8iOZQJj3q88vjdo6XT
 XXL0WRZ5Zutht9ud6dzPz6xAF+m/yPum7bhrNnF+6urjmSBFeDjv0MUF5mFT92Qjj8DB
 iok9OqH/5Okymv7PN0EG1lrw5JGTXKJc5h+iABPcxm+qohZc0LMks19ttwQDPLtNkenj
 SJJqlMun3703eWgMj5n2eRqYc2AQukI6yAdMVI2do2xj4UtEJElE6CMsDTV6u8gLjz+7
 RxTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsMnaacUkj3AWARF3RFzJ5zZh/svqwr3jmD6mweDYwQvyLfCZsFdluOkbr+rAKR0zP8uun4eXJ26H+@nongnu.org,
 AJvYcCXLgdeuKkx2vvEzy7Yoj8FLR1vcUE7Xz6bNVv6WPYN1ULkooAuOfnd5ZjXP7MpY7j16Id7u3LT7j9w2Jw==@nongnu.org
X-Gm-Message-State: AOJu0Yy7FI3twrIqgGuAHqBez88WgbXKTDmwOGm7i6I1TzdfslITn72M
 IAVIbdL90Olq9MkayqOxa/oxslI5aeQ+H43TD9MKCwUSnSL4QQFqmemu
X-Gm-Gg: ASbGncuDGmpKEAoVBNn+QiyuFg4KQIQbme6V3enB57Hb63pDao/Bnq/L9jnIFkQ4B51
 Q8g+Y09mzI8R8Fw3EjMsjhpeINPVS6sjWdjO6kZiktmB6u1ZDgVyeofbe8BNFUhC2eA7zDf+Yb5
 glddmimrfRYKQxqj730Vmnzgcn2d6Gf8D+sK9CW94MK/ht/bS2VgEo9d6facgoNxlnOL2vk3/pP
 76JGzit+fmEQVeojWw5kkr1zSAaXNK1hsYClCsb5jW0UTyj6/F99F0aLa/AUYAS1pYBm2LJokmV
 Qhxk+dWO7KkHFLpWJcuu2t8GLAvUhuv6Io3B7y1ZsktY6O2Z3UayxSwMiflkD5slBwFxUoNZHHx
 fSivlZw6QNHp/YPvcKPlZcr5gL3k7pv/LTLMBEJxe2R4QU5o=
X-Google-Smtp-Source: AGHT+IEEsnsHmW6T9xue9IvpOxnQXUy48SutZ8f4me4vVKWh1SUJPr4fZBtW9FzNgqEqNEYM8GTNHw==
X-Received: by 2002:a05:6a20:914a:b0:24b:c7d9:88d0 with SMTP id
 adf61e73a8af0-24bc7d98f7cmr839697637.41.1756954575883; 
 Wed, 03 Sep 2025 19:56:15 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4e5684da06sm12643108a12.17.2025.09.03.19.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 19:56:14 -0700 (PDT)
Message-ID: <e1b88c82b1a8687b0e91c01df808a51b982a3bef.camel@gmail.com>
Subject: Re: [PATCH v3 3/5] hw/nvme: add NVMe Admin Security SPDM support
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>,  Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,  Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz	 <hreitz@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum	 <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Thu, 04 Sep 2025 12:56:08 +1000
In-Reply-To: <20250903024705.GA103624@fedora>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
 <20250901034759.85042-5-wilfred.opensource@gmail.com>
 <20250903024705.GA103624@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x430.google.com
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

On Tue, 2025-09-02 at 22:47 -0400, Stefan Hajnoczi wrote:
> On Mon, Sep 01, 2025 at 01:47:58PM +1000, Wilfred Mallawa wrote:
> >=20
[snip]
> > +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest
> > *req)
> > +{
> > +=C2=A0=C2=A0=C2=A0 StorageSpdmTransportHeader hdr =3D {0};
> > +=C2=A0=C2=A0=C2=A0 g_autofree uint8_t *sec_buf =3D NULL;
> > +=C2=A0=C2=A0=C2=A0 uint32_t transfer_len =3D le32_to_cpu(req->cmd.cdw1=
1);
> > +=C2=A0=C2=A0=C2=A0 uint32_t transport_transfer_len =3D transfer_len;
> > +=C2=A0=C2=A0=C2=A0 uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> > +=C2=A0=C2=A0=C2=A0 uint32_t recvd;
> > +=C2=A0=C2=A0=C2=A0 uint16_t nvme_cmd_status, ret;
> > +=C2=A0=C2=A0=C2=A0 uint8_t secp =3D extract32(dw10, 24, 8);
> > +=C2=A0=C2=A0=C2=A0 uint8_t spsp1 =3D extract32(dw10, 16, 8);
> > +=C2=A0=C2=A0=C2=A0 uint8_t spsp0 =3D extract32(dw10, 8, 8);
> > +=C2=A0=C2=A0=C2=A0 bool spdm_res;
> > +
> > +=C2=A0=C2=A0=C2=A0 transport_transfer_len +=3D sizeof(hdr);
> > +=C2=A0=C2=A0=C2=A0 if (transport_transfer_len >
> > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
>=20
> An integer overflow check is needed since transfer_len comes from the
> untrusted guest. This will prevent the sec_buf buffer overflow below
> when nvme_h2c() is called.
Ah yeah, good catch! I will fixup in V4.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NVME_INVALID_FIELD |=
 NVME_DNR;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /* Generate the NVMe transport header */
> > +=C2=A0=C2=A0=C2=A0 hdr.security_protocol =3D secp;
> > +=C2=A0=C2=A0=C2=A0 hdr.security_protocol_specific =3D cpu_to_le16((sps=
p1 << 8) |
> > spsp0);
> > +=C2=A0=C2=A0=C2=A0 hdr.length =3D cpu_to_le32(transfer_len);
> > +
> > +=C2=A0=C2=A0=C2=A0 sec_buf =3D g_malloc0(transport_transfer_len);
>=20
> g_try_malloc0() is safer when using untrusted input from the guest.
> g_malloc0() aborts the process on failure, so it's disruptive.
> g_try_malloc0() allows you to handle allocation failures.
>=20
okay, that sounds alot better. Will switch to that.=20
> > +
> > +=C2=A0=C2=A0=C2=A0 /* Attach the transport header */
> > +=C2=A0=C2=A0=C2=A0 memcpy(sec_buf, &hdr, sizeof(hdr));
> > +=C2=A0=C2=A0=C2=A0 ret =3D nvme_h2c(n, sec_buf + sizeof(hdr), transfer=
_len, req);
> > +=C2=A0=C2=A0=C2=A0 if (ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 spdm_res =3D spdm_socket_send(n->spdm_socket,
> > SPDM_SOCKET_STORAGE_CMD_IF_SEND,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> > sec_buf,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transport_transfer_len);
> > +=C2=A0=C2=A0=C2=A0 if (!spdm_res) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NVME_DATA_TRAS_ERROR=
 | NVME_DNR;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /* The responder shall ack with message status */
> > +=C2=A0=C2=A0=C2=A0 recvd =3D spdm_socket_receive(n->spdm_socket,
> > SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (uint8_t *)&nvme_cmd_status,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> > +
> > +=C2=A0=C2=A0=C2=A0 nvme_cmd_status =3D cpu_to_be16(nvme_cmd_status);
>=20
> be16_to_cpu()?
Yeah it should be!
>=20
> >=20
[snip]
> > +=C2=A0=C2=A0=C2=A0 nvme_cmd_status =3D cpu_to_be16(nvme_cmd_status);
>=20
> Should this be be16_to_cpu()?
Yep, it should be. Thanks!
>=20
> > +=C2=A0=C2=A0=C2=A0 /* An error here implies the prior if_recv from req=
uester was
> > spurious */
> > +=C2=A0=C2=A0=C2=A0 if (nvme_cmd_status !=3D NVME_SUCCESS) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nvme_cmd_status;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /* Clear to start receiving data from the server */
> > +=C2=A0=C2=A0=C2=A0 rsp_spdm_buf =3D g_malloc0(alloc_len);
>=20
> g_try_malloc0().

Thanks!
Wilfred
>=20

