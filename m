Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A30ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 11:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCFv1-0000hK-9Z; Fri, 24 Oct 2025 07:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCFux-0000h0-0t; Fri, 24 Oct 2025 07:25:11 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCFuu-0003Fh-6d; Fri, 24 Oct 2025 07:25:10 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B0C71597456;
 Fri, 24 Oct 2025 13:25:02 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id pHPCwg5B4zsa; Fri, 24 Oct 2025 13:25:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A751359744F; Fri, 24 Oct 2025 13:25:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A54DB59736A;
 Fri, 24 Oct 2025 13:25:00 +0200 (CEST)
Date: Fri, 24 Oct 2025 13:25:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Vishal Chourasia <vishalc@linux.ibm.com>
cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
In-Reply-To: <20251024092616.1893092-6-vishalc@linux.ibm.com>
Message-ID: <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Fri, 24 Oct 2025, Vishal Chourasia wrote:
> Add error checking for lseek() failure and provide better error
> messages when image loading fails, including filenames and addresses.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
> hw/core/loader.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 7aca4989ef..48dd4e7b33 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, Error **errp)
>     if (fd < 0)
>         return -1;
>     size = lseek(fd, 0, SEEK_END);
> +    if (size < 0) {
> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
> +        return -1;
> +    }
>     close(fd);
>     return size;
> }
> @@ -129,14 +133,24 @@ ssize_t load_image_targphys_as(const char *filename,
>                                hwaddr addr, uint64_t max_sz, AddressSpace *as,
>                                Error **errp)
> {
> +    ERRP_GUARD();
>     ssize_t size;
>
>     size = get_image_size(filename, errp);
> -    if (size < 0 || size > max_sz) {
> +    if (*errp) {
> +        return -1;
> +    }
> +
> +    if (size > max_sz) {
> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
> +                   filename, max_sz / MiB);

MiB is arbitrary here. This function is used to load all kinds of images 
such as ROMs which may be 64k-2MB or even executables in generic loader 
that can be a few kilobytes. This might result in errors saying max size 
is 0 MiB if the allowed size is less than a MiB (e.g. amigaone PROM_SIZE = 
512 KiB) and integer division discards fractions. Do we have a function to 
pretty print sizes or maybe this should be left as bytes or at most 
kilobytes?

Regards,
BALATON Zoltan

>         return -1;
>     }
> +
>     if (size > 0) {
>         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
> +            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
> +                       filename, addr);
>             return -1;
>         }
>     }
>

