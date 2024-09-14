Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7D5FC6194
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 05:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spLUp-0007jo-0N; Sat, 14 Sep 2024 01:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1spLUn-0007hm-8t; Sat, 14 Sep 2024 01:38:57 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1spLUl-0006H5-R0; Sat, 14 Sep 2024 01:38:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 784AA5C47A3;
 Sat, 14 Sep 2024 05:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7547C4CEC0;
 Sat, 14 Sep 2024 05:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726292333;
 bh=UlVn8fWFgP8yf3muvfLEqiwH/WZRlUZiVMyShTuifUY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XpO1WWzYHYTwRtLfZGl4iOOc7d+02PCfjEXlKJgaPkkWLX5jvtsyvdEICyVPR88fz
 1CLcPeREenOMSbsiVjC1eCVSNLpfRMm6OuAh7FVMzqV6IAj6TPakHA7AByFGg6mO2C
 C4eqLv5pOy4s+wcWUiFCgd38TC6kczItyDizuNPEOlAn3KJWn4NyOmyOvQLnFVXGc+
 5m2ERtBlScH1IwFeTDHnVF5Uhyoj7uZxI70kwpLOww07a411ZzUpKU8k3QwpVzcefB
 2c+eY7LsP/CG6jUGv9zMFt4DzlfCrZKxySKF9JwcKLvFYJbkHgBH2KtcJQ9tIq0isO
 Lo9HaYdhEumLg==
Date: Sat, 14 Sep 2024 07:38:48 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240914073848.7b8bd8f0@foz.lan>
In-Reply-To: <20240913142802.08571a15@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
 <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
 <20240825052923.715f88bc@sal.lan>
 <20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
 <20240911163436.00004738@Huawei.com>
 <20240912144233.675d6b63@imammedo.users.ipa.redhat.com>
 <20240913072025.76a329b0@foz.lan>
 <20240913111300.00007a3c@Huawei.com>
 <20240913142802.08571a15@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

Em Fri, 13 Sep 2024 14:28:02 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > > 5. Just return an error code without doing any resets. To me, this is 
> > >    the worse scenario.
> > > 
> > > I don't like (5), as if something bad happens, there's nothing to be
> > > done.    
> > 
> > If it happens on a real system nothing is done either. So I'm not sure
> > we need to handle that.  Or maybe real hardware reinjects the interrupt
> > if the OSPM hasn't done anything about it for a while.
> >   
> > > 
> > > For QMP error injection (4) seems is overkill. It may be needed in the
> > > future if we end implementing a logic where host OS informs guest about
> > > hardware problems, and such errors use asynchronous notifications.
> > > 
> > > I would also avoid implementing (3) at least for now, as reporting
> > > such error via QMP seems enough for the QMP usecase.
> > > 
> > > So, if ok for you, I'll change the code to (2).    
> > 
> > Whilst I don't feel strongly about it, I think 5 is unfortunately the
> > correct option if we aren't going to queue errors in qemu (so make it
> > an injection tool problem).  
> 
> +1 to option (5)

Ok, will do (5) then.

Thanks,
Mauro

