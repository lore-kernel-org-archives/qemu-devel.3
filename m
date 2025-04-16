Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB65CC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 13:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u52lA-0005XM-UF; Wed, 16 Apr 2025 09:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u52kr-0005Vc-FA
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:24:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u52kn-0002K3-Nx
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:24:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2260c91576aso57598695ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744809876; x=1745414676; darn=nongnu.org;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6QexFJEEMJSic0+z/ZC+XLtFb+kKnzgDCDW4UFJLdc=;
 b=cKh3iUOUUCMQCx+fs/7mjE1hCqLcydLnuZ86B9mjFitJITZnTO4WgQxxvz6lxzsKdf
 2q1QZPYQwgZi04Kn2JY6eczPFvwdMAthdx0CEKCoPr5zskC7PnOCSzVrvIRb73bskeIF
 HrFvYwk9nO2dsrmqhtdncA6AELkxXyI/hpXLIr/0ZTH5sjq9iF5ZX6zDIeEUOyw/Sd2X
 LpQrzgUJVoe9OpspWG/BRj5al6rPw2FODSkbs77PgQVLzwQez0mmkN3gU0JWc6Z2rtg/
 wQjhvi1lZffWsQ+Ala98331hsbwJqUyp+V7AEGnvst6UnBRl5OfTtVtmSh6uWbNX57zf
 qyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744809876; x=1745414676;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a6QexFJEEMJSic0+z/ZC+XLtFb+kKnzgDCDW4UFJLdc=;
 b=Xy7Z9P8WKEBfjB3YgnSHjlcsfaaVhkZXpbXMkn6mjddi/usBRVmJo16IY2z7pNum22
 KGAMKmLs5Nc5Jkwpsa0osHvw0DouLos3bqBtY+sqwhoF71oThykFANlMlcEsbVkqCzVF
 gYO1UiKbS9FCOO69LintY6Fdb/naNEIKOtmfcZoLgN5PS3OiSr6rCKLoUqhoercYJEa0
 VURl9KV/kfz++IiIzbsR67iCi8TIkjxJ7kxA5nzzXaGYP7JKUENGesznqNIi3YLcsSdx
 AMQVdozz3oCYMo4fV/Ub9WIsBCXCznetyDIivcAj7zGZKs1XbeDQhUc1PVpUSciuJxW6
 N9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDiAagwvoVk8b4ZxZeI9pmN7CntnVLGNJLc4vSpgN96bq9Mw6KX/Z/+NLUoBL+RQgV9QbaLdlRKNha@nongnu.org
X-Gm-Message-State: AOJu0Yy3QWueD63uqQORYORP+lvvWveS3wohXKgFayw2OKD4hquSZ6XQ
 02kFaXj7C953oOQuOK5dua1NvXSbGn2WECiAZ3iYqRDgQvlIiUt6
X-Gm-Gg: ASbGncscS/XmSmtQbdNuzg7uURSaiNiMhRfz3aG+TjmEKYOsLwar6hLrdjI8jIkYqOD
 5NwWclW/QWFdoOJzU6HdADuq3FASDyCiitbgATy7GA80MuWZ3t3nKZspaWfS6N7nYXYhpdrkmfW
 F5YPqoX4MUDQv0zz/40V2Qgd6Q5HwDTR8S89SnezSFBKb0btCmq0IWJcOb1kbXEtRnofca2ghC/
 9YVQIg4z3xGwqLv0Zm9hROGOUqenTLV2BYa5O6NDL/JrQrYGvZ8PSLtDCuRxpttgBeErKUA3A7Z
 xN278FDUZswdXjd6HmmMzM8MyV3/VBU=
X-Google-Smtp-Source: AGHT+IFoycJct0tKTG853mskBR7Wro2zQXNetyFfpDZYQqK6KFgGwPi7e3oAFZEZoEiJeyLQ5LM5/A==
X-Received: by 2002:a17:902:e541:b0:224:912:153 with SMTP id
 d9443c01a7336-22c358c4083mr28401405ad.5.1744809876066; 
 Wed, 16 Apr 2025 06:24:36 -0700 (PDT)
Received: from localhost ([1.145.55.85]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6e1dsm13310615ad.236.2025.04.16.06.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 06:24:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Apr 2025 23:24:32 +1000
Message-Id: <D983H9RDME9Z.1ZIYO7RRNBQS4@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 000/163] tcg: Convert to TCGOutOp structures
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250415192515.232910-1-richard.henderson@linaro.org>
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Wed Apr 16, 2025 at 5:22 AM AEST, Richard Henderson wrote:
> v2: 20250107080112.1175095-1-richard.henderson@linaro.org
> v3: 20250216231012.2808572-1-richard.henderson@linaro.org
>
> Since it has been 2 months, I don't recall specific changes from v3 to v4=
.
> It's mostly application of r-b tags.  There is one more patch, which I
> believe was Phil asking for one patch to be split.
>
> Patches still requiring review: 29, 41-43, 46, 47, 49-51, 55, 57, 59-62,
>   64, 66-68, 70, 72-78, 80, 82-87, 89, 91, 93, 95, 97-102, 104, 106-162.

For ppc64 host I ran check and functional and avocado tests and
some ad hoc tests and holds up so far.

Tested-by: Nicholas Piggin <npiggin@gmail.com> (ppc64 host)

