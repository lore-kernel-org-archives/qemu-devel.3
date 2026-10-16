Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A35CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHh37-0007Tj-0j; Fri, 16 Oct 2026 08:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xHh34-0007T7-JJ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:28:34 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xHh32-0001he-6b
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:28:34 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-35b2c599f43so169126eec.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792153710; cv=none;
 d=google.com; s=arc-20260327;
 b=mYwOybWpCxt2XegZO/kDbyljj8AenGHHsn2dXPBfkZrarPG5ZrnUqey38JM8oz/WJI
 m2TiOaCj4IYI8de1rh7p93Ei47eu5aopRIQ+LIokJsL0UTjlmRLpyHA/PklsN89gDlzR
 q86Zub3aTXfu8ndAdDiNubY68cFfVFuz+kX11E1hnnR3XMooyK8xcALsd1+ckQELH/Wp
 RPjJVUhXe/CbHjQz2LpIbDnyYRKG2I36gG3VigY3H2ziCrlaMf8u0yFWgFFgWGBCVMGm
 XzHsStMQobsH87zUq8TzvbzXTe74NR+r079iHCbWgJhXuUisGXzfZqeGExLCTb5OJUOC
 U30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GNLUdZHVU+zjxpIxO7qAkv/KVYr7fwTF3MmU6ttWkoU=;
 fh=qAX0oJxOOYE5IQsixN1XiS6rs9CNjF4Qy4Pvsd2Byrs=;
 b=PXr1YgHYEo4vTlrj32pznsGZRQd6TtpsXeei0pND5AGhRq+qdhFRyM5NrNH3v8Xj7A
 a3mWxAV6ILXn11I9WmbecG9dEZbjJfYnHDJLDlNwkYBushlESJ2xzvn7lpY8dCcpWBaL
 +xc6Wv//yozJFJ9I+Y6oiRBPQV/UB6OwGqcR0X43EvC86VeRW0doO7T6lXBrGhYrxm9g
 ApPTLLOaaQDyDMUd3ClSMS8f4esnvrSUtUAyXjLCfIKEe1tDNwIdCdv89TN0AQsF90Ws
 NO4GN45QVUffFbf/Cgpiky+Uqp3CEfeLOQ2j6YY48fBUrpOS6P0k/nh6prrT7bGkNsQo
 BbCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792153710; x=1792758510; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GNLUdZHVU+zjxpIxO7qAkv/KVYr7fwTF3MmU6ttWkoU=;
 b=q/BvUtSz6nm8Xx64rBsqxIkiGj7ARVQMs61n7D9q/x1E7YLXBCndFqPD0kzyEqXzqu
 0M9o98uADwIXBy2aShpQGvEPCMI9EjY3DiHtMjM5KYd20E8dIWq0qawtvn16oJC0++1k
 XIideWPL6rVwyiUP90dTEEpBkzNeW7Y5u4TFAZgguhWpajlt+iGQ0fGm19TdTNVf5/UJ
 A7MjCGtGBi+xC/MyBXjzAFsk7CDhW2eOAYrsl+o+zEDvZt1bKGUCehoGOrKEk3WcpvSV
 EeHOCF+HFMscdD4SWh8juP55e0Ji9KyI22OJskaVx5wg4nhtW4AaWr745swqh+YwS4NT
 Zehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792153710; x=1792758510;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GNLUdZHVU+zjxpIxO7qAkv/KVYr7fwTF3MmU6ttWkoU=;
 b=n9a0ZLGbFodmleHAM2fLdoSNRqRhPsuNNAfc8i7ar+18hCPTxYCN1S6SVc+jOhCKWl
 7UwmwgdBJ4OwMSVVfNkhXjfuWsqTgdGq8hPhuagsYaW8HQfAB3dIhJLzwFSTceatgKBU
 Kh9gRFiYBCwEttnn/I0BS98B02qeO/+Vy0/gAPiKwpvcIoF/z186175PFJAprl6/ta7I
 bl9l/CIpvGmcypVdr/yV0aH2Ep4SLKvamJpJcsJAURCwyX5qZDhMHN4nfOMPuGqVk4BE
 tIEsFWaHr2wk26Rr2f9FPALrNdiIWfFzWFI7jT0GXxW0oSaDll0Ef/ALU7fFIB3RxrDn
 rAog==
X-Gm-Message-State: AFq9FYLUCCq+rJRMuvSRlWLfsvcl3Ju2LnQ6OzpglPayBPI6PSz/zo/K
 F9ZxyWYpYKPZBmBF4EpVXIoNKjfMbfV0Ygx4K+8zQFHoBojvf3nwEmj37Zhp2QbkyN7icqYTO9B
 HRCklwSzu22W30gahrDyY2BvDZd6U7kG7ydnhnn9GFQ==
X-Gm-Gg: AYBFou1W6+LGtUdNLtrBaS5WRtGGqeZbG6tGscJLev3LW89KIkyQjpqY7TsM90Ky9p6
 BeBB7zXqD3pmBE0wVqJ3iO2LC7FtLnfzOrbABeHq7LwRiC9KETWAQhuStAhj0OWGv2PYQuPufPp
 cJfDJUXQ7xrPHck3zy8ocC3MSEPgaVmThpe4VajygzlnABLJdnU+jit08KUMDLOgZvUs7g/qBp3
 ITOMWXW7vEER7FLqXBxHvCuPK7gM5iNsB+iZvL8FPDVaum1yVMIWFLhOYPYoZy2fq9SsKykeiwh
 NzNtNxstaRGif+BcpSnoj+WdsY0DS4FHTFp7/jS00Mrd4en7yypXc05MOrmVFdbgyweBmEUghB8
 NrSp6lQdMUDrd
X-Received: by 2002:a05:693c:8642:20b0:358:d3d6:207e with SMTP id
 5a478bee46e88-358d3d625b3mr27841249eec.11.1792153710341; Fri, 16 Oct 2026
 05:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261016122113.226920-1-apolivodaa433@gmail.com>
In-Reply-To: <20261016122113.226920-1-apolivodaa433@gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Fri, 16 Oct 2026 22:28:17 +1000
X-Gm-Features: AclHuK_Ynbzo-uVjxTtmRW8JaiWE6syiwlu1LuSN87Iu0GZD1Y-rV7bcCiYltkA
Message-ID: <CAGscdFvtLkFsLaTzWLPd=J757ioWyFmBKds_yb467WY7RrqhJA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Reject VPINSRW with VEX.pp != 0b01
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Testcase:
```nasm
bits 64

global _start
_start:
db 0xc5, 0xf8, 0xc4, 0x00, 0x00
int3
```
```
$ nasm -f elf64 vpinsrw_test.asm
$ ld.lld -o vpinsrw_test vpinsrw_test
```

