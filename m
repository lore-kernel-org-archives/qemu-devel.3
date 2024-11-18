Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC11D4921E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1Xy-0002mL-4G; Mon, 18 Nov 2024 08:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tD1Xw-0002ly-5P
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:12:04 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tD1Xu-0000ne-HW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:12:03 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-514b8bb231aso140850e0c.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731935521; x=1732540321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8lVpavY7Sh1GsnO0ir6JvMhixef7IJsNtsjqhmk3Grs=;
 b=bvLVjVN9RlTrZfrQ3aoiLCH9MFJF8Rj7pmGe2bfqb1H/4duBva6oHavAlkWvH0YSFa
 WT1iQmmdCUtpqJ66eMELxDM/pnYM8H9bt0MMLDvf+uag8G5KiOMZ19RsrCds9HqSMKEw
 VQgKqvuUwKX0/CAtEmfsoM4vFDSQJHX2ZA54S7TxXgfxEtGMQx33trN8Sr5Td8OLHYzn
 7QmrT89AIoP6C5xnQJqSA1RFgDv2o94U0MNp0S5iSa7FKXeTuNzZ3s6rIIBaJAGcy0mi
 l7wUBMLleAjbf6DYbUwfDwWIGlAD+tXs+GmxhZ/pEqt0hAjVmrrA2ecOr2YWsDbcxPWu
 ygAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731935521; x=1732540321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lVpavY7Sh1GsnO0ir6JvMhixef7IJsNtsjqhmk3Grs=;
 b=PZMcoCvecLK4BO+CT+/7mO64SiiivQAnhuOkZVit+yrP115fXvZciMPIRIbac0VKUp
 edTqz4vGJfhmCgYDTDOOyFncKNdjQl81q9meG/WGqSN3JZwCiKrfhpfWEeIzATc1ccfy
 AYkI45jHfnGQTEubU1HoPq+E9de7dLUOQQPI+Y41hZoy1jwxP6eKmNYuX18nvQ+LUNJb
 OZzXNIcNRluGx7KfoE2kNdUlWkXvDPhT2zDeHwLnYog6zX0CrTStQYvF9Qcg/NRO2MgY
 RUs5JklE6wGbUHDBivPKUbJtRecaiDUXoMwz3fQ8tJOLm/IIYCb309CSGTM4NfI9MHUX
 XjZw==
X-Gm-Message-State: AOJu0YzF+uzz8K62wohYNY2MGg8mZoO4zB7fW2QVxF+iAhf8NOd95h9G
 sGpSH8zKkdjMrmnuz4a34u5aHy/S5HabG5GIelqZnATalTW3fI30ehnkqtTd5b+FoQvR2n4xPoV
 3hb+i5hxASvv3/cFgWH8zvQfAczo=
X-Google-Smtp-Source: AGHT+IGq04qSnUD0kXCeot7uSP7HFRvYVxc4UfO0NQI+vKNfws5PTST2Bc6ZAET4/F8AFJ3NfMyQ76y66Y0GVN8mSTM=
X-Received: by 2002:a05:6122:789:b0:50d:85c8:af3e with SMTP id
 71dfb90a1353d-51477eeb37dmr10551415e0c.3.1731935521196; Mon, 18 Nov 2024
 05:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
 <44fbe3d8-509c-47ad-b764-5c8016980bfe@amazon.com>
 <CAFfO_h5LHsgng5itQTEO30SUT_jn02Pdi-0uYvyZCgRPJfcueA@mail.gmail.com>
 <2970cc68-a34c-4751-b4a3-d7fac416d7d3@amazon.com>
In-Reply-To: <2970cc68-a34c-4751-b4a3-d7fac416d7d3@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 18 Nov 2024 19:12:06 +0600
Message-ID: <CAFfO_h47fHYfiU9vgU61UT+jSnv9YCO8jTy+hB77+AQc+NZ7+w@mail.gmail.com>
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2d.google.com
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

Ping.

This is a small one that needs review.

Regards,
Dorjoy

