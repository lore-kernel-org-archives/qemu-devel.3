Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EDECCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmHG-0000gV-Vz; Fri, 31 Oct 2025 06:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vEmHC-0000bm-8F
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vEmH6-0004RR-LY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761906139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lJSufPyB6bN1hmzOPEJzVNg+xS6L3ijbpCqyae/DFj8=;
 b=asWaqjU5+/zLdhe142UoQ6IDZqllzsBCL05bhjkn10F7nGGLJqgSRh17RHgwQVcHHfG8aA
 ay6EVOUxiICN3bFT5KsQ4jrNQfyTG+zZdIOZKnxINTPPp/8U0d5Jspm0lq9BhdVRWEXXWu
 MGKYGEBWq5JPCUdGV8R9BrvyCdhO7o0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-8EFtq9dKOJCCSCrxtcF87A-1; Fri, 31 Oct 2025 06:22:17 -0400
X-MC-Unique: 8EFtq9dKOJCCSCrxtcF87A-1
X-Mimecast-MFC-AGG-ID: 8EFtq9dKOJCCSCrxtcF87A_1761906136
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-63c41bc2dfcso1491742a12.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761906136; x=1762510936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJSufPyB6bN1hmzOPEJzVNg+xS6L3ijbpCqyae/DFj8=;
 b=aM5xtn7hCnZ2WZqK+oFtwqhpWW+GGXVcFe9zurUg5BkNpe1D/AhNqVeaXyr6t2/umI
 NTHD2DrYrIAEK3n57yKHOTQYXN7LFgeoGmFPGPMD2YTLqmynCqyKgjh7iE6uLkmrC9W5
 56sfvjx5MFkzc/dFGE0844imKVlxgCLZo/sa0iYKX1X+R9cj7lF7J5Y1VSpXxwIDnDcP
 xg2jW0iFGl/pOM2fgrvmnCoqEBODWgCyVrEWUlnwR96MI5Q5lr8LW9b1WTEbD691Y+8x
 ENEjodxmICLvwAvq24BdhY/3e5mrpX1rlpk13vTIiM/lhM4bmksrNdcepGMpGRAg0yyo
 cLGg==
X-Gm-Message-State: AOJu0YyifUdP6ypbF5wpfAis3eJfaIPwcV0ajhKoeRAy/igP5AuZ83ar
 OG41gRen1qNpSmeayEwfYz5v2Rdf4lyot9ZoxWKJBSQ15jawcf6kn5QIP26UvB9+vaRKc1rXcjc
 cj8ZIUhEuFPZJf5XgZjKpN8hrnJkkvoQf6N8eHYbj045GynSIrgKYIbH2
X-Gm-Gg: ASbGnctHNtU7h8pqbL29tWw7NEBOifYx5my7XIHeyfMP3w7k4gzSRwUCp9NE4zblYbw
 u+dvEKKr2DbGmSN60B0h8FGoLz4YXu/3XUUSyMINtnu8IS3J3SYuQUJv+guqoQaVVGSI2Pq4pb/
 AOwPWGjLxjJgyKUkNmtEt/Sb74uv0LclD4VMjF0usv7UoWAz7g34ZtEWKTfXqZEoJ08Gz+Bryqw
 vX5iIejs9EMo1AbxTUv5k/pH89dLsqGE+/eIOmd3OZaG2nFCeAOx4ffVGGNQaGH5OyLToXtJHip
 Xj5YRh0BWFSb8pJZMOFCrly47U4CIFa2B6AAOEMzbjl7m+jEAcvAmyQetAm3NnXssD7DX+UEvtB
 jGY2zL8VBfm2DftcGVgfUmPK16mNC3bGbh5G1q+CCKmgSgbSeT4A=
X-Received: by 2002:a17:907:1ca2:b0:b6d:7db1:49aa with SMTP id
 a640c23a62f3a-b70708a0e58mr295515566b.63.1761906136336; 
 Fri, 31 Oct 2025 03:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtp1lISdfZywW18P2XTw4JeUtMNxCH//JPP91kh3CPXYUsZTkG0CmQj8omZhIvIvnGZ4BGXA==
X-Received: by 2002:a17:907:1ca2:b0:b6d:7db1:49aa with SMTP id
 a640c23a62f3a-b70708a0e58mr295513266b.63.1761906135848; 
 Fri, 31 Oct 2025 03:22:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b70779762bcsm140708366b.15.2025.10.31.03.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 03:22:15 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:22:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] hw/i386/microvm: Use fdt field from MachineState
Message-ID: <heua2u3gdvdrw5fusmx4wy75dcbku3citxa6wbvflipudq7tyy@3orfglusvl6x>
References: <20251030-fix_microvm-v1-1-f89544a04be3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251030-fix_microvm-v1-1-f89544a04be3@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 03:32:04PM +0100, Luigi Leonardi wrote:
>MachineState already provides an fdt field, remove it from
>MicrovmMachineState and use that instead.
>
>This is useful when using the `dumpdtb` option, as QEMU expects the
>device tree to be stored in the MachineState struct, othwise it will

s/othwise/otherwise

>return this error:
>
>qemu-system-x86_64: This machine doesn't have an FDT
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>`fdt` field is already available in `MachineState` but
>`MicrovmMachineState` uses its own.
>
>This prevents the "dumpdtb" option from working.
>---
> hw/i386/microvm-dt.c      | 96 +++++++++++++++++++++++++----------------------
> include/hw/i386/microvm.h |  2 -
> 2 files changed, 52 insertions(+), 46 deletions(-)

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


