Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2693BCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 19:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9q7a-0006FR-4s; Fri, 17 Oct 2025 15:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9q7Y-0006Ez-3p; Fri, 17 Oct 2025 15:28:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9q7L-0000JI-Ca; Fri, 17 Oct 2025 15:28:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C2AF15972EF;
 Fri, 17 Oct 2025 21:27:57 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Vnts2jVvsmmY; Fri, 17 Oct 2025 21:27:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C1E9F5972EE; Fri, 17 Oct 2025 21:27:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C00BD59703F;
 Fri, 17 Oct 2025 21:27:55 +0200 (CEST)
Date: Fri, 17 Oct 2025 21:27:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Vishal Chourasia <vishalc@linux.ibm.com>
cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
Subject: Re: [Patch v4 2/5] hw/core/loader: Use qemu_open() instead of open()
 in get_image_size()
In-Reply-To: <20251017181250.1421446-6-vishalc@linux.ibm.com>
Message-ID: <3932aca8-7dc3-9b92-8b91-a3616ee03f4a@eik.bme.hu>
References: <20251017181250.1421446-2-vishalc@linux.ibm.com>
 <20251017181250.1421446-6-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Fri, 17 Oct 2025, Vishal Chourasia wrote:
> Replace open() with qemu_open() which provides better error handling
> via the Error object, automatically sets O_CLOEXEC, and supports FD
> passing with /dev/fdset.
>
> Remove redundant error_setg_file_open() call since qemu_open() now
> handles error reporting internally.
>
> Suggested-by: Daniel P. Berrang?? <berrange@redhat.com>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
> hw/core/loader.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index e40cba1b9f..030f832e54 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -77,9 +77,8 @@ int64_t get_image_size(const char *filename, Error **errp)
> {
>     int fd;
>     int64_t size;
> -    fd = open(filename, O_RDONLY | O_BINARY);
> +    fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
>     if (fd < 0) {
> -        error_setg_file_open(errp, errno, filename);

This was just added by previous patch so it's useless to add to remove 
right away. Maybe this patch should come first before adding more error 
messages to this function?

Regards,
BALATON Zoltan

>         return -1;
>     }
>     size = lseek(fd, 0, SEEK_END);
>

