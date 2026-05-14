Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0F8CD4F21
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 02:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNMBD-0002vn-DI; Wed, 13 May 2026 22:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNMAt-0002s9-QH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 22:51:48 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNMAr-00027N-4D
 for qemu-devel@nongnu.org; Wed, 13 May 2026 22:51:47 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2f36da5c8fbso7388610eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 19:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778727103; x=1779331903; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HA+UczhCJ5C+PKEVk6vbqvTyrtZEWM6NdrhXuMT/oMw=;
 b=PlnM+fZJcic7+XW+m18q9C6elzLPaW4tQp/+eUglvhcXtOMdx2dmhevyGXyUkn6WUk
 0hWst3jpwuPJjMrSezLj4x2cgRypZ8h6HvDaMac1NST0q/kTYvGMLzK3XnveaevW2hDE
 XRNw47eerAkcDJSb5fIWq46yOIvyCS4IRzs1O4yzGEIOD8uLuH1FM9zbcxmSSmOz5+hV
 fWCWODjuKcdSUemKaG4Ol48TrXcqr395cJm1dFU6vPxXvETrH9xH8zSG6UFvYg8bUg4M
 ABlcjaj5oNyKyy727iEe7tn8RWYK50537+qmfBQ0zq/WWEIqnKz1klHmQyHJkWqq+CTs
 Ppww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778727103; x=1779331903;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HA+UczhCJ5C+PKEVk6vbqvTyrtZEWM6NdrhXuMT/oMw=;
 b=HXqcS6Lt9jXmc+3aN7TUblaE6Zw7XuC3/GEcfmPPtiVfuEKhmniFz6KyJfZCNJcwsb
 lELHWP/ygz6nW+n46O2EyavjEqyqieWY3chFkABrZ6KBwEfF9kqr3q8lAspWJgcYmLQA
 Sbuwtic/WqNF63p2yLKsNCzJDwskC3KJLmG+RhkHSn3zCyE8dc8FaCTMDl1YMnztMZIZ
 gDHJS3DQ86mt+L53que97ByN8KC1k9iX/n2Xvuonbq7Fre/RLt9p4Cijb9LaFT7QGPFS
 7TW0r645I+X5XV7e8ON7CcZecwMH/gVJeSZtEYudxvnPGBEcniRQPBX4tjfy+5fgjVhM
 VtlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X9SoRUwHxobJFOvvPiugXv4k6C6gPyQ+ifWFqJzKsIs9uQKMszMKkdCZF26bjQ9qL7ur/A9Yl52Vi@nongnu.org
X-Gm-Message-State: AOJu0YyapAJr0usdWkfFrW2nUNXuEffjIRy/oHGP4DUcTmdgNC7NXPiu
 or9nMSVtseGi3GRu5flEAYuH5JIcGpfeXnXcUkVv8Z5W3xJQRfAl/ezo
X-Gm-Gg: Acq92OHyssRid/zq8Bjri8LkkN3JI6KlQxDhNxqwGDYeqv0K4GCaT+Dnc0PoN34B4/i
 ugN1Tm2ysZV0+hfIlQN8qVqwfOb05fz3SWdD4Tg7Bf5L6aLzfGRMBAovXbPx9de3+vYaDG67tr+
 i0Z0a4hN/hLID25+IL6MZ/b6k6DU2BmCMvS5i6wquoz6pJtmPsTzqZGwDw8+Olbbjkg8OYRt6HI
 W0mntDZ+A5YCNONsy1BV5Els5WncsyHFpN/ifU7lrGG/LS0G6i614nlycmij0NU4jIZvpl/Wdle
 yfyNPScxvorSZoXsN/bfOZibpvc1N9wWqcIbe9MNC+2Bg/y0hk0p+vwPTFiHmQQz9Ymk2euzmxP
 GJJtV+pii5reBXQCKknETpMHO4HXSGqBsTAjNVjpHwRdAp4K25gSXyVs/9bIIcCgtWRlnEYvX0G
 Yt/RZMwHLE82907lp51sEjuj3qRPOKp44SfyAYc5PWpWY5N5A97TDNb6P7bOLIx2+3OPMdz2Irk
 29RJj9myIhfX/10O+qi8KDpGmbK0VeOJfYVSHnDmA==
X-Received: by 2002:a05:7022:608b:b0:132:5d42:55ba with SMTP id
 a92af1059eb24-1343677c602mr3863224c88.16.1778727102508; 
 Wed, 13 May 2026 19:51:42 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc2351d9sm2186331c88.9.2026.05.13.19.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 19:51:42 -0700 (PDT)
Date: Thu, 14 May 2026 10:51:35 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: armbru@redhat.com, Thomas Huth <thuth@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for Checkpatch
Message-ID: <agU3-ZPw4Xhwhe3o@ZEVORN-PC.localdomain>
References: <20260513070830.851842-1-chao.liu.zevorn@gmail.com>
 <7d877cb8-f176-4442-9df8-776d9f511b4e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d877cb8-f176-4442-9df8-776d9f511b4e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

On Wed, May 13, 2026 at 09:18:04AM +0200, Philippe Mathieu-Daudé wrote:
> On 13/5/26 09:08, Chao Liu wrote:
> > Add myself as a reviewer for the Checkpatch module, so I can help
> > review related patches and continue maintaining it.
> > 
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> FYI: https://lore.kernel.org/qemu-devel/20250819-checkpatch-py-v1-1-99de8bb733db@linaro.org/

Oh, nice! I have always had an idea to refactor checkpatch.pl by following
the approach used in the kernel’s Python checkpatch script.

I’ll take a close look at this patchset. Thanks for the reminder!

Thanks,
Chao

