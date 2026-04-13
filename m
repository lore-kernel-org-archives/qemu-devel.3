Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8C4F34C40
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCFuu-0007Mv-VZ; Mon, 13 Apr 2026 07:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wCFut-0007Mh-LR
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 07:57:23 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wCFus-0005BG-5Z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 07:57:23 -0400
Received: from example.com (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 977DD20B6F01;
 Mon, 13 Apr 2026 04:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 977DD20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776081439;
 bh=QAt3V/69bjuLDa6D+9wZ9aHyMQTnHhrnwOHgoSS1x7I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VUlvy+ouwW9XupQuz04GsIS/0lwbcpY1IISflQt78cFP4+WxtS4v/XlqviTv6XYEl
 bkM60ci2aA/fsJuGEt6u8Yo/MgauPCTOk2g+K13hx1Ru43xV0ziv5ibdjTkjdTj8HL
 hvd3T9q4YTRyKeC3y0biiAHwPszzc3Mu5eL01VZs=
Date: Mon, 13 Apr 2026 13:57:17 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 1/1] target/i386/mshv: fix read/write memory across the
 page boundary
Message-ID: <adzaHT8YdPcQ2GTw@example.com>
References: <20260409175334.181249-1-dblanzeanu@linux.microsoft.com>
 <20260409175334.181249-2-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409175334.181249-2-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 09, 2026 at 08:53:34PM +0300, Doru Blânzeanu wrote:
> Previously, read_memory and write_memory performed a single GVA-to-GPA
> translation for the entire buffer. If the buffer spanned a page
> boundary, the translated GPA was only valid for the first page, causing
> incorrect reads/writes for the remainder.
> 
> Fix both functions to loop over pages, translating and accessing each
> page-aligned chunk separately.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 71 +++++++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 2bc978deb2..afdb6b6e29 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1316,21 +1316,38 @@ static int read_memory(const CPUState *cpu, uint64_t initial_gva,
>  {
>      int ret;
>      uint64_t gpa, flags;
> -
> -    if (gva == initial_gva) {
> -        gpa = initial_gpa;
> -    } else {
> -        flags = HV_TRANSLATE_GVA_VALIDATE_READ;
> -        ret = translate_gva(cpu, gva, &gpa, flags);
> -        if (ret < 0) {
> -            return -1;
> +    uint64_t cur_gva = gva;
> +    size_t page_left, chunk;
> +    uint8_t *cur_data = data;
> +
> +    /*
> +     * If the read spans multiple pages,
> +     * we need to translate and read each page separately
> +     */
> +    while (len > 0) {
> +        page_left = HV_HYP_PAGE_SIZE - (cur_gva & (HV_HYP_PAGE_SIZE - 1));
> +        chunk = MIN(len, page_left);
> +
> +        if (cur_gva == initial_gva) {
> +            gpa = initial_gpa;
> +        } else {
> +            flags = HV_TRANSLATE_GVA_VALIDATE_READ;
> +            ret = translate_gva(cpu, cur_gva, &gpa, flags);
> +            if (ret < 0) {
> +                return -1;
> +            }
>          }
>  
> -        ret = mshv_guest_mem_read(gpa, data, len, false, false);
> +        ret = mshv_guest_mem_read(gpa, cur_data, chunk,
> +                                  false, false);
>          if (ret < 0) {
>              error_report("failed to read guest mem");
>              return -1;
>          }
> +
> +        cur_gva += chunk;
> +        cur_data += chunk;
> +        len -= chunk;
>      }
>  
>      return 0;
> @@ -1341,18 +1358,34 @@ static int write_memory(const CPUState *cpu, uint64_t gva, const uint8_t *data,
>  {
>      int ret;
>      uint64_t gpa, flags;
> +    uint64_t cur_gva = gva;
> +    size_t page_left, chunk;
> +    const uint8_t *cur_data = data;
> +
> +    /*
> +     * If the write spans multiple pages,
> +     * we need to translate and write each page separately
> +     */
> +    while (len > 0) {
> +        page_left = HV_HYP_PAGE_SIZE - (cur_gva & (HV_HYP_PAGE_SIZE - 1));
> +        chunk = MIN(len, page_left);
> +
> +        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
> +        ret = translate_gva(cpu, cur_gva, &gpa, flags);
> +        if (ret < 0) {
> +            error_report("failed to translate gva to gpa");
> +            return -1;
> +        }
>  
> -    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
> -    ret = translate_gva(cpu, gva, &gpa, flags);
> -    if (ret < 0) {
> -        error_report("failed to translate gva to gpa");
> -        return -1;
> -    }
> +        ret = mshv_guest_mem_write(gpa, cur_data, chunk, false);
> +        if (ret != MEMTX_OK) {
> +            error_report("failed to write to mmio");
> +            return -1;
> +        }
>  
> -    ret = mshv_guest_mem_write(gpa, data, len, false);
> -    if (ret != MEMTX_OK) {
> -        error_report("failed to write to mmio");
> -        return -1;
> +        cur_gva += chunk;
> +        cur_data += chunk;
> +        len -= chunk;
>      }
>  
>      return 0;
> -- 
> 2.53.0

Fixes: 6dec60528c (target/i386/mshv: Implement mshv_vcpu_run())

