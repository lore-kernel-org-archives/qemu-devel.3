Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22519C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJno-000691-Mg; Tue, 06 Aug 2024 09:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbJmS-0005BK-Gy; Tue, 06 Aug 2024 08:59:19 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbJmQ-00012L-5d; Tue, 06 Aug 2024 08:59:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 98C69CE0B2C;
 Tue,  6 Aug 2024 12:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED608C32786;
 Tue,  6 Aug 2024 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722949144;
 bh=WRTEl+sMiGldjc/6bXsqZRJ/sl8EcbB0pjjcgi5eOnM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ep8RaX588umdUmUXLx5Ecl9eEvX47YNAmIbVYHbQTjddP7hhN8RESSLm8qBqTxC2a
 k04/3yPcH8nLyiGq5pVGelazPggWt2NSyeVNfoQ3swNmK33MgaD9ZVCYC2Y6xPPZ0m
 f5wpcsjveio4ADHrQPIgaHAugiXHmzHhWYBwgV3A/8L/qMKGGBL6Td0f866TjjrY5q
 9I7Sl2im7O/9/+nDA0Q3dP2yYghsWpfxyTkJduOG5KzpW0Ug9/ddbVCI64akiIQHxZ
 UhmAixa1/lBNLzqpKl+/OgmbXLzzLAn1+oZ1C7pFSZWvo4szdCO2IsYZD8g89Fu5/0
 c7VTb9knXrq7w==
Date: Tue, 6 Aug 2024 14:58:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240806145856.106c7ebe@foz.lan>
In-Reply-To: <20240806145153.0e1a70a9@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
 <20240806145153.0e1a70a9@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Tue, 6 Aug 2024 14:51:53 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +{ 'struct': 'CommonPlatformErrorRecord',
> > +  'data': {  
> 
> > +      'notification-type': 'str',  
> 
> this should be source id (type is just impl. detail of how QEMU delivers
> event for given source id)
> unless there is no plan to use more sources,
> I'd just drop this from API to avoid confusing user.
> 
> Since the patch comes before 5/7, it's not clear how it will be used at this point.
> I'd move the patch after 5/7.

As described at:

> +# @notification-type: pre-assigned GUID string indicating the record
> +#   association with an error event notification type, as defined
> +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header

This is actually GUID of the error to be generated. Perhaps the better would
be to change the above to:

	{ 'struct': 'CommonPlatformErrorRecord',
	  'data': {
		'guid': 'str',
		'raw-data': 'str'
	}

Making it even clearer. In any case, this is mandatory, as otherwise
the interface would be limited to a single type.

Thanks,
Mauro

