Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A70CCD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoZs-0000LT-Uw; Wed, 06 May 2026 22:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wKoZn-0000D4-3s
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:35:00 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wKoZl-0001I9-L0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:34:58 -0400
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8e0a768331cso170007985a.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778121296; x=1778726096; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pfFUadgzVSSK8E5sNm8eEI2T37ZZu/9szHOFpTHfAWo=;
 b=BHJ1rmilfkB7YYF4xm9GL0zEWgKkPmj1jqrioaA392BmiUTJDQ+91CEYOVTv9xwvwV
 n6JODcrhhmQjuldBpIFHHYpY2ZWfvQ6PrCGf+yK7kur1Z4DwbdoCeIT8oYaoQ3WkIxOL
 YbtFJ9TsHO7i37kaBStd8PsY9AaFckLIvykIL9fXmahzYpvLzsHfI4yEP8WaRFordmA1
 gS020LQnpZmJMG+VA+lXbZ6vBEUBp9xXC8OpyiOYjRatt2bGfCYc9sD6Ut+1w/wnRHGq
 uMtForP3deEZLJJKvrdfOsIQjtZEva4B0rXwHhGIjwwZLqNsoD4/yy2YgfdX+1H0DtqA
 djQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121296; x=1778726096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfFUadgzVSSK8E5sNm8eEI2T37ZZu/9szHOFpTHfAWo=;
 b=a3nQHHOnCas4+aVfjCp4GKnesk3f7L0e1RghFOmJCWKD1qAlgKoPq143/x55hNVeUI
 iYhYGu9KwF83JBrVu3Vly7VCIz0rUQAi+jIqNcrI6KvdCtuZOzQRnzH2c73cSn/EyIZE
 TTO5JhEsk8GjqoB+3ESYfSMdgYW0Mu//aXLzxS6O/1EBcEDLsaHhjGWTghBbFQ8KtizF
 TI9ruJRKK8iiDC8W17Gyp+5tlwmnGkKaZ8DwMr+Vh36u75toP4+XzKZ/dtiMuBPDKuZQ
 LLmXxJBZoEBEGlZZo1mu7KOfvUwdzUS6ERCzf30uLJzeCqe+kIZzkWIQuMKC8s5KCfmn
 Ke9A==
X-Gm-Message-State: AOJu0Yz2RptnYMNpPZGrPu3jU+eLjtp8/SmfStprfBL/fYqChgQ12NhX
 8CluRXf7GAnIrHIvWDNM80SLwqE/Gd1wD0q5loYhl10ArgQx7NJQH4vS
X-Gm-Gg: AeBDievlLWD6flTuhMXtkrDeEGcm2MNV3qan2VJJhZFDr+V/QGjzwygvLGDm8OWiuD6
 abQcm6pvN54IH6G/o0iH4o/bSoBCqamIPbZOxmIeyk2m56t09n99qWyFlDm3g/9eKcnJ1fNn/I1
 tsjz1B2yMgBrLFn4FBJopWnYQq9Nt8oHdioO/Tr8aMmkaPjhu8AaNpTTMZqoLCr2PFggxYWDPGw
 z15nXPlb03PChv8dgzfIqir9sKYyPY7C29+EPhrG1j9mFzngjRwBD0iGbPbP9bI//kQ4BWOA7Gt
 ENSFoKvcngZffr2IVqnzPjx5KFc/jHDS6TmUfPVibaqw6KMZnn9rhGGmg5DwoJLtoreke0I0y7/
 hu0Kug/LXV8OKpZ70SD+WGu+aM2DE3pLVXLq1eNjEKjhcLZniYz3Pb6tzdl4xfXUQp03wFTXu4a
 gcBAkMJmGr0fgqtsVu8O97ZCVYZLHvNw1yF7WuH6iEP2ZlNwdIOhqqMwXuPYW1G8BV2KGuaY1oF
 +JL5UD5ajTm7bRT97wDmQ==
X-Received: by 2002:a05:620a:c47:b0:8ee:91d6:cd2c with SMTP id
 af79cd13be357-90653250928mr142353785a.42.1778121296476; 
 Wed, 06 May 2026 19:34:56 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c91fb3bsm1763316785a.41.2026.05.06.19.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:34:56 -0700 (PDT)
Date: Thu, 7 May 2026 10:34:39 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-block@nongnu.org, integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Message-ID: <afv4NaWyZwiMEh4L@ZEVORN-PC.localdomain>
References: <87y0hwbvbp.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0hwbvbp.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x741.google.com
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

Hi Markus,

On Wed, May 06, 2026 at 02:01:46PM +0200, Markus Armbruster wrote:
> I'm cc'ing reviewers and lists mentioned below, and frequent
> contributors to MAINTAINERS.
> 
[...]
> Likewise.  Volunteers?
> 
> These have neither:
> 
>     MAINTAINERS:3719: Checkpatch
>     S: Odd Fixes
I'm interested in this module and have experience in the area. Happy to
help review. checkpatch.pl is already quite stable, so it won't add much
overhead.

Thanks,
Chao
> 
>     MAINTAINERS:4153: SPARC TCG target
>     S: Odd Fixes
> 
> Unless somebody steps up to server as M: or at least R:, we should
> downgrade to S: Orphan.  Volunteers?
> 
> 

