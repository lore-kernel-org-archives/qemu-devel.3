Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C416FCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 13:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWGq-0005JY-2P; Thu, 14 May 2026 09:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1wNWGn-0005Dn-Hn
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:38:33 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1wNWGl-0003Bp-EZ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:38:33 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-90d2acb9936so331546385a.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1778765909; x=1779370709; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tifc0Q2b+CTeA0QnyzjYGtpdL5D6Vxy5bM32g7urohc=;
 b=PTcjKcbH0xxRdV1oEL8uCirGL1XWPJDl54y64p33nc1i5DJ5SYFhUkVlqvgwtCOnTq
 TbzcU6JK9QKqpUSAihLX5IE1ueJPlnG3F3CWR25Ee/UnnTn2yjdGVN46RWNSZ6QcYMqm
 Tvp39PW3U7sptsBOqbPEoPjrmH1zTeFLHyBnNH6frc2DNHsTrb2155ckV7lFJm7meG69
 EWL5qLspIW82yX/aI1m8teYJXnBEadTIJSfg6Z4hGGS1CSbOcF+TV5QMa9ABma2Suvsv
 zrHur5Gjs/9S44f84bYS2pQNTosWIn9c+voLYomSUaiMQcISSEygjMSxyFMfrVk87kf2
 l81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778765909; x=1779370709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tifc0Q2b+CTeA0QnyzjYGtpdL5D6Vxy5bM32g7urohc=;
 b=Xh4wSJJcxx8rqF3Q1fcOiTxAtJtTiK5/iYzjh/nxUvCZsB1zOLWEbxnTbetpN3eK2r
 dceaIm1/qwTwifI1Tb1OEiO+lGH293JvxtCUEVNkgSySls7zV2PT1X9oYHs6KJH/4Xv7
 qsijZzH/CkJv7WzUvEIjGVd6MEYGgY2kYFJLDg19mFGM19hYrsPfFFlkq4gTjTvk9JMk
 S9fp1PfzpgYXWtG77ETEeEub28cDo8ja0eIlyGUDEVMZY3DCwq1hWpPYYIq77KDHQa/G
 J/pkDhiX+irqofnESNGjJ6H2kHwQCxSfV3xuNF1Fj5pHBrB+mCAn8652jynghdjPwnLa
 +tmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LfdX2FvGhNcCA+W7mX8jPpSoFjzREx11HV00kZNQSuAeb9PRhN0dYaFqPwvjtkJWCrIUrzfkKdw0F@nongnu.org
X-Gm-Message-State: AOJu0YyC9J4YGHZRJE3BVp2+D6NNYWFUx1om7LQ9MzfUuSqefKGc2uvK
 nYrHUBsrrHK6I2x3kY6Fxoqi7qJwv/q2k9L0xloXJ0jgX3V8b1MJxrYNbqG0kktW7/8=
X-Gm-Gg: Acq92OF9sqKtmWw6ypSi2myRFDKKWKOM8djLsUY8wmnEWk0qQVON+9+R+7ONQwwhfKZ
 poLLCiMw9ZfAImzE6eE0+HtGWnbX5ezu+8jw+6HW7cVlReIB39KisFXZbYPYqtwl7Xix11BONsR
 y+A8uIPp/u0jLQRhYy+pKrXwbKOrLaqVWfZtALSNkQj8xBrVFW3BgxUbIQvgu55Nl1ft1hjhuvL
 mIVJ8i/HPSpd88WlOD42ZviMMWDy8g/drpIxWEylsQQTSrvVs1TAXPVetirDfi+I2lw7Qv1FYiU
 qPXNN6pkdzfwwzmMTJKqrsSVkS9HCxBMyM4NeB5Sh+Rf9Gn7njZgjHf5SjJmIuwuCzkaQluPksy
 BjGqdwizNxfBQvGZycp8RCfGxNXUOrN2knAZ3bRqPrtmXEC6HinT79MpViWNpiZo9sdTRSjphkJ
 ITgODGGd4BXUSu54xY9VElUvsp1Cc8iHXqDdYFjr7ohrFvE1diWgMd+PzL6eP4n8nVkjHB2/32b
 e6rWmmgLNL3
X-Received: by 2002:a05:620a:3942:b0:90a:1517:99d6 with SMTP id
 af79cd13be357-90fadf4eae5mr1235225185a.58.1778765909128; 
 Thu, 14 May 2026 06:38:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bae27359sm264873585a.17.2026.05.14.06.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:38:28 -0700 (PDT)
Date: Thu, 14 May 2026 09:38:26 -0400
From: Gregory Price <gourry@gourry.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 david@redhat.com, jonathan.cameron@huawei.com, apopple@nvidia.com,
 dan.j.williams@intel.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v7 1/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <agXQUrxu06Wfl-Wj@gourry-fedora-PF4VCD3F>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <20260306082735.1106690-2-FangSheng.Huang@amd.com>
 <20260514150559.3148f9dc@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514150559.3148f9dc@imammedo>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, May 14, 2026 at 03:05:59PM +0200, Igor Mammedov wrote:
> 
> I don't recall but I likely asked before
> why not use device memory instead for it (aka DIMM device or some device derived
> from device memory object and then add e820 entry for it).
> 
> It would be a way more simpler approach and impl. without need to resplit
> anything in e820.
> And no need for messing with firmware (SeaBIOS: RamSizeOver4G patch) nor EDK2.
> 

David previously addressed your question on the original patch version:

https://lore.kernel.org/qemu-devel/6e7ad90d-a467-40cc-99fa-d0915438dd05@redhat.com/

  I wondered the same in my reply: I'm afraid it cannot be a DIMM/NVDIMM,
  these ranges are only described in E820 as "hotplug area".

  I think it must be something that's present in the memory map right from
  the start, where the OS would identify it as SP and treat it accordingly.


We're trending towards devices being given dedicated nodes for their
memory, so this actually makes sense as an extension to NUMA.

While heterogenous device/memory nodes are possible - they're also
pretty nonsensical outside of specifically the simple use case of:

   This node has both hotpluggable and not-hotpluggable memory.

Which can already be accomplished another way.

For a device being given a node with memory, marking it reserved or spm
in e820 is needed to make the memory hotpluggable in the future (as that
node has to be reserved and the hotplug memory region accounted for).

Unless I am misunderstanding your feedback here - please let me know.

~Gregory

