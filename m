Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45512C5472D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 03:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1si4F5-0005WU-1W; Sat, 24 Aug 2024 23:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1si4F3-0005Hq-FJ; Sat, 24 Aug 2024 23:48:37 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1si4Ey-0005Hn-Ht; Sat, 24 Aug 2024 23:48:37 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5B19A60C2A;
 Sun, 25 Aug 2024 03:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D72EC32782;
 Sun, 25 Aug 2024 03:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724557711;
 bh=wYgVuEohUFvuJR7BKrYMXwPNC/z0NyGx+4ELX1Susf4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cU9m02+Q+n9ZugrlSKrJO3kJq9i/EDGjwYHvvSXjDN6St7fDBdNzFeg2kTNP7eXpQ
 PaGvOKE+ladpOqXrfG1yDUHWw3b/gTnwP7jdSfWHYJIuVNT9i2Z+UvXJYryyssTTu8
 5IWGzqjwlqwOcuWlyZhUWkjf3Pp2lkDm+YqSCfIzY7FmObj3yqzWQg/HCV1Gy0vfkq
 clvSWadtyQVDElaXntxw9pKuf8CKX90GGAmyUythIk23qoVVLs9r/TPwE0cX34BJah
 3eS/YVBl9QgTknLHBPVfifvJ1KwPLbaBDynVKuJAU9/ZsD82V8JkJNd6ndSqkHPvdG
 3LrgZ6IPU/L0A==
Date: Sun, 25 Aug 2024 05:48:12 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 13/13] acpi/ghes: check if the BIOS pointers for HEST
 are correct
Message-ID: <20240825054812.32f780e5@sal.lan>
In-Reply-To: <20240824021510.71451b57@sal.lan>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
 <20240819160733.464ccebf@imammedo.users.ipa.redhat.com>
 <20240824021510.71451b57@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Em Sat, 24 Aug 2024 02:15:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Ok, we could still do something like this pseudo-code to get the
> error source offset:
> 
> 	#define ACPI_HEST_TYPE_GHESV2	11
> 
> 	err_struct_offset = 0;
> 	for (i = 0; i < source_id_count; i++) {
> 		/* NOTE: Other types may have different sizes */
> 		assert(ghes[i].type == ACPI_HEST_TYPE_GHESV2);
> 		if (ghes[i].source_id == source_id)
> 			break;
> 		err_struct_offset += HEST_GHES_V2_TABLE_SIZE;
> 	}
> 	assert (i < source_id_count);

This is what I ended implementing on v9.

Regards,
Mauro

