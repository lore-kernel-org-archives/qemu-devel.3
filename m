Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB83AEFCE53
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 02:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxyWC-0008Q1-F0; Wed, 04 Mar 2026 21:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxyWA-0008Pf-NK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 21:32:50 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxyW8-0001m7-QM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 21:32:50 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so4195819a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 18:32:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772677967; cv=none;
 d=google.com; s=arc-20240605;
 b=Zj8l0ULseryjEsSf6RLDGhPc3BUJXk6V5IH2FE6m6IQeW9PgpXdMhsO1FjhLwOCQrN
 NUIa7ybMufZFlMNJbZG+BleAaPBISSG/6LS+EGbPLI5HmmAG3+3dKJk4C5lJTncSrBbM
 CO/KDBHYijx41c+kkKpJQBopwCXPle4whfqP4Zw3jX5wK5sTDKO3fX7wwJ2FlPYGOFR6
 ia5w5H9BlNrrrhQZYpdFuY0wCr4Cj+UYA5RUlRkCl3lXsm8JVxhU6lw0WupgRXGGkQQz
 pBFINlZ+5QVkzD5VLUDt9t4Ndhjut0BL0lmX6cjMyNa/2aHXwCibS6Ert1imY0iYnmJU
 Qzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xUOxVjTlUhKhO7cLwOXGxJ2nFxBh7vZ7Z1GsjSRI6J4=;
 fh=qVCHIBAmpZfRsxgXEvXh2s/XRWnqGWa8TXLczCTGhXs=;
 b=Ra9e7WPU9aGYC77EAWJsOF9RR9RCx2BAiU4BeXFm3PpjN+E40QAUdBq+KOEwofwk/g
 sTngql4YPBfpxq/aVRTsjEKMkxUWlgHQkq+GnrROzAR//8gN36lCQKZxb6Wbxkg4GfvM
 GNV50yjWTf4bQ6DmCURcloKdJcNuln+SPbxRbt5wpy5XXz6Xf5Xqco45LQbYXEoGINEI
 BTuYErk+BrBJSIiICN7A7BnGFjHKJMrLYflyLVywIlR/NIw+rdm90DTG7sy4PnCfmA3n
 7v6V+ICFFhaFWJVqlOE+0kEaWESiFdcaNXG9PXX39n56/cyyQLrv1BIl+4Sjzsc3n8oY
 Sepg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772677967; x=1773282767; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUOxVjTlUhKhO7cLwOXGxJ2nFxBh7vZ7Z1GsjSRI6J4=;
 b=W270uwshUhXtVgwVXOxwD2EmC4xwf3xZCujSaySfEnI3fIT+EW/t/swcPyIe5jO9DA
 MG/9JNi+wx6pYMslIx3pcHaQ3j8vGzt23HTlghsbxH+Ibc3UlOw/G+61dbQqm4K4Mp7Q
 71NEJBIgFba9ViNJRhE0DDUivOHJ2N5kt6TlsvTeYzlRtP+FLWosSMXRhVqxPxC9umj4
 zOlJtYPp1UwbwPuYsj8F5U1bQ/vBEZOUeobpWToyY9VmOyhxhw9W7nFS7t3UfhR/YITU
 jRDYvFZZut0b+Wl4HRO+Z5Bn7ZlthTvFCbBRADYGEuV9LCMDJWEKXwqbrIjDIxkcOxpO
 83sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772677967; x=1773282767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xUOxVjTlUhKhO7cLwOXGxJ2nFxBh7vZ7Z1GsjSRI6J4=;
 b=ccp3KNg2MZmFGK8cEgkmpImv8sitbRf2Trc2LJaMnQxcmIx0/oWn/f+hq+QtlpVLTP
 0frPIZ2q3C7uq8LI45Sw4pukcc5wZ4narqlxxS+BUIix/NPeKc4nGwjLkkjLhJz2jX0X
 s1zrhHQCy+uXGYdoqZZa36ozLPz+7y1A5uGXmz5IMtG9XoZHop9NpBrx6iJUOY225JL6
 W7OwKipFcArKBr1qhzo2bUR1UkceG9WibV0aUJzAN90VGliCJeLBmtgQyiThU14IOS0K
 81mJ6mD2EGSmzcSBoHzS+DRDz19n1gC2W5rN+A2cc/Bcn7GIFVt1hrLDR2M4Vn/eZa+w
 AJ0Q==
X-Gm-Message-State: AOJu0Yy1hn9sp3i/to/Kuq3nBa5+RSxzmuaCvqJHxlkwsx40ejJQrHJE
 5Dn7uRzYbdaIdE5u0Db6V+sQuYHramQ1g5vv9n5BY7lA1Xo0TNy7ZPF2L5c098xzRcxRkafFPg2
 HVpyNKU5+YOhpQxS+R9wkZCE6BLGMq/g=
X-Gm-Gg: ATEYQzyGKrigdAM6RoRrZSv4ZXjVWGPxBzNP7emgPGGQ2ehiHVjUPZ6QzeVhL59Fqn0
 XGE7m92QRJfoNNRj2OgX5BaaxQ1pyXcrUQKZhtKsum14I6LXzEgCWHAXfQAcX6ZZC+dhD9dfX04
 WAth6jjc+QCkqEb+e5x+CFdaYHIyj1hrMXZM2dNKyqVgkxO/aMXzS7g7DGb7XUZk6GZIFSW7TWr
 0cHWzEhataPlOAVKoeSOhDhR0LRv3Dj9mY56m1Ol6vnFKxjaobbh9bCZ4njRKxqg+txpwjyZsSF
 tyc9UyGvCXStMtyKJaBGPt+wI9CZcupKfhN+Bw==
X-Received: by 2002:a05:6402:1442:b0:660:a23d:4666 with SMTP id
 4fb4d7f45d1cf-660efcac8edmr2614842a12.18.1772677966634; Wed, 04 Mar 2026
 18:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-2-max.chou@sifive.com>
In-Reply-To: <20260304134006.2908449-2-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2026 12:32:20 +1000
X-Gm-Features: AaiRm53NHAgdnbmQjhPr7308nUR--TPgHMMb5wUY8gpoDIZ1_JK8tH4hF9Z6rvg
Message-ID: <CAKmqyKOjaLv31yKpSzt6uHv4aRExjpdtP08-TCWSD2chdh6HkQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] target/riscv: rvv: Fix NOP_UU_B vs2 width
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 4, 2026 at 11:42=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index f75177b0fc..b2315ecf9c 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4982,7 +4982,7 @@ GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
>
>  /* Narrowing Floating-Point/Integer Type-Convert Instructions */
>  /* (TD, T2, TX2) */
> -#define NOP_UU_B uint8_t,  uint16_t, uint32_t
> +#define NOP_UU_B uint8_t,  uint16_t, uint16_t
>  #define NOP_UU_H uint16_t, uint32_t, uint32_t
>  #define NOP_UU_W uint32_t, uint64_t, uint64_t
>  /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
> --
> 2.52.0
>
>

