Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E258ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9J-0008MC-8Q; Wed, 07 Oct 2026 04:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xEI7e-0001hE-K4; Tue, 06 Oct 2026 23:15:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xEI7T-0001v9-HY; Tue, 06 Oct 2026 23:15:11 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966c5WC2994055; Tue, 6 Oct 2026 08:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3rGIk4
 IuhrVamx3Q3y/MEovh5gXsO/Qbw5nIMrMs5vw=; b=mkRVJbGuSViZRBa64ZC2Ug
 vSvz+m4naqEcfD8vkVtOpKYQJzzMq2DrEHT4CmZq8f7DywgO7QclYRZ/zzvduEry
 WIvF+0fWoEXXe7BNgFZ6PbL7YzeT4pAG4w1rwNTPTNKip26jBjW1HCzlaf4n7XzX
 YS9JI8xVTrV3QCFjkGqYMIT0YG76ieUhLvCm+BS1Zu7qKLiXdtMqJtfrc7trcHN2
 AFUAmSUb2kIlYYVpdnl/6f+Wk+j633UA6G7eZ1xY6H/6NNxG883dyEVFtu+QFc7t
 rtEhEskQiqxz4BUnsEsbowQ8ed52jY2+bX29Slq5zcmxcw5u9r4gyCW2rIBjvWxw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74pvm3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 08:11:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966lY8w4151924; Tue, 6 Oct 2026 08:10:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgrya6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 08:10:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6968AwS932178830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 08:10:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F08505805E;
 Tue,  6 Oct 2026 08:10:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75B3C58056;
 Tue,  6 Oct 2026 08:10:51 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 08:10:51 +0000 (GMT)
Message-ID: <09391c7e-d9e0-40fa-9ba5-382980c1f52f@linux.ibm.com>
Date: Tue, 6 Oct 2026 13:40:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/8] hw/loader: add load_elf_ram_sym_buf() for
 in-memory ELF loading
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com, philmd@oss.qualcomm.com,
 alistair@alistair23.me
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@linaro.org, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20261002052605.605858-1-uverma@linux.ibm.com>
 <20261002052605.605858-3-uverma@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <20261002052605.605858-3-uverma@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 35NJN8pwVWL8YYiES7LvmBB1T5a8wSzg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX5MCUJEFjAYu1
 cPgrTmw+LDPLy60LJd7LcIC3D3jm+bJlLJvo+NK1qc4uoiI7Kc37M5Ci8JCp5WOrCMY6pitibdu
 nssuD2a2tbsVo0PWhdTTlGDqT5Nd+ZA=
X-Proofpoint-GUID: gGWxE839sji040USvoRUJQz8Sx_WxB_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX8tadK8ps8taD
 X14K4tpc7Hg9GDtYhOUbm3DsPoiCa6RDPR4fwywQ7qFb/iTNhW8oTFX5komYjtUYlvgYkgvyVqy
 VyEG6WTH4IfgJcc0J52zioUuSZ4jz1Tmc5SlkaED0xNW5vZ65FLCX1wL6GCwKusbe7WPYdHJup/
 ylKxZt47zWtHLwsHwyzNjNXKPPYH+tBItG1B5gtJMu/BNhYdcec8us05j2C3bPZu0ETgS+ZinZO
 XBGYtjGVQ3glZyxKK6kwvF2vo1EeaTUE2niB/W+FhlonxkQUVMxpQkcf5MVPEmcAhEeTQX9J9Wk
 6NmOICzS9ElVIeBFFMCr3CJhl0YFnnG8T6c4h0SjcFin8ncTME9nL6SBrAZMyvtssM4P9Hw/VL7
 o7hziof+v1Z5kukJBAAXyQPITfI3HS19OCG/aPxfkK1QrgVmVopsMJDA5S+fwf/oI7d52DUh1GG
 /BR0uaRSdneoq6Ag7AQ==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac4ad14 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=hHydlDmERXRUVUicuWIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

+ Alistair and Philippe

Hi Alistair and Philippe,
Could you please share your feedback on this new ELF loader from buffer 
function. Or suggest someone who may help to review this.
Also, hw/core/loader.c file has no entry in the MAINTAINERS file. So, 
should we add the file under Generic loader section only?

Regards,
Utkarsh

On 10/2/26 10:55 AM, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
> 
> Add a new public API load_elf_ram_sym_buf() that loads an ELF image
> from a caller-supplied memory buffer rather than a file path.
> The implementation creates a temporary file via g_file_open_tmp(), then
> reuses the existing load_elf32/load_elf64 paths.
> 
> To support per-segment inspection by callers (e.g. detecting VoF
> firmware segments), extend the internal load_elf{32,64} template
> (elf_ops.h.inc) with an optional segment_fn_t callback that is
> invoked once for every PT_LOAD segment after its load address is
> resolved. Returning false from the callback aborts the load with
> ELF_LOAD_FAILED.
> 
> AI-used-for: code
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
> Chaneglog:
> v2:
> - Replaced memfd_create() with g_file_open_tmp()
> - Replaced write() call with qemu_write_full()
> ---
>   hw/core/loader.c         | 81 +++++++++++++++++++++++++++++++++++++++-
>   include/hw/core/loader.h | 30 +++++++++++++++
>   include/hw/elf_ops.h.inc | 12 +++++-
>   3 files changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5cbfba0a86..fa04c59ed0 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -510,12 +510,14 @@ ssize_t load_elf_ram_sym(const char *filename,
>           ret = load_elf64(filename, fd, elf_note_fn,
>                            translate_fn, translate_opaque, must_swab,
>                            pentry, lowaddr, highaddr, pflags, elf_machine,
> -                         clear_lsb, data_swab, as, load_rom, sym_cb);
> +                         clear_lsb, data_swab, as, load_rom, sym_cb,
> +                         NULL, NULL);
>       } else {
>           ret = load_elf32(filename, fd, elf_note_fn,
>                            translate_fn, translate_opaque, must_swab,
>                            pentry, lowaddr, highaddr, pflags, elf_machine,
> -                         clear_lsb, data_swab, as, load_rom, sym_cb);
> +                         clear_lsb, data_swab, as, load_rom, sym_cb,
> +                         NULL, NULL);
>       }
>   
>       if (ret > 0) {
> @@ -527,6 +529,81 @@ ssize_t load_elf_ram_sym(const char *filename,
>       return ret;
>   }
>   
> +ssize_t load_elf_ram_sym_buf(const uint8_t *buf, size_t buflen,
> +                              uint64_t (*elf_note_fn)(void *, void *, bool),
> +                              uint64_t (*translate_fn)(void *, uint64_t),
> +                              void *translate_opaque, uint64_t *pentry,
> +                              uint64_t *lowaddr, uint64_t *highaddr,
> +                              uint32_t *pflags, int elf_data_order,
> +                              int elf_machine, int clear_lsb, int data_swab,
> +                              AddressSpace *as, bool load_rom,
> +                              symbol_fn_t sym_cb,
> +                              segment_fn_t segment_fn, void *segment_opaque)
> +{
> +    const int host_data_order = HOST_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB;
> +    int fd, must_swab;
> +    ssize_t ret = ELF_LOAD_FAILED;
> +    uint8_t e_ident[EI_NIDENT];
> +    gchar *tmp_path = NULL;
> +    GError *gerr = NULL;
> +
> +    fd = g_file_open_tmp("qemu-elf-buf-XXXXXX", &tmp_path, &gerr);
> +    if (fd < 0) {
> +        error_report("load_elf_ram_sym_buf: %s", gerr->message);
> +        g_error_free(gerr);
> +        return ELF_LOAD_FAILED;
> +    }
> +    g_unlink(tmp_path);
> +    g_free(tmp_path);
> +
> +    if (qemu_write_full(fd, buf, buflen) != buflen) {
> +        error_report("load_elf_ram_sym_buf: write: %s", strerror(errno));
> +        goto fail;
> +    }
> +
> +    lseek(fd, 0, SEEK_SET);
> +    if (read(fd, e_ident, sizeof(e_ident)) != sizeof(e_ident)) {
> +        goto fail;
> +    }
> +    if (e_ident[0] != ELFMAG0 ||
> +        e_ident[1] != ELFMAG1 ||
> +        e_ident[2] != ELFMAG2 ||
> +        e_ident[3] != ELFMAG3) {
> +        ret = ELF_LOAD_NOT_ELF;
> +        goto fail;
> +    }
> +
> +    if (elf_data_order != ELFDATANONE && elf_data_order != e_ident[EI_DATA]) {
> +        ret = ELF_LOAD_WRONG_ENDIAN;
> +        goto fail;
> +    }
> +
> +    must_swab = host_data_order != e_ident[EI_DATA];
> +
> +    lseek(fd, 0, SEEK_SET);
> +    if (e_ident[EI_CLASS] == ELFCLASS64) {
> +        ret = load_elf64("(buffer)", fd, elf_note_fn,
> +                         translate_fn, translate_opaque, must_swab,
> +                         pentry, lowaddr, highaddr, pflags, elf_machine,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb,
> +                         segment_fn, segment_opaque);
> +    } else {
> +        ret = load_elf32("(buffer)", fd, elf_note_fn,
> +                         translate_fn, translate_opaque, must_swab,
> +                         pentry, lowaddr, highaddr, pflags, elf_machine,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb,
> +                         segment_fn, segment_opaque);
> +    }
> +
> +    if (ret > 0) {
> +        debuginfo_report_elf("(buffer)", fd, 0);
> +    }
> +
> + fail:
> +    close(fd);
> +    return ret;
> +}
> +
>   static void bswap_uboot_header(uboot_image_header_t *hdr)
>   {
>   #if !HOST_BIG_ENDIAN
> diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> index d9431e8a8d..b67b2ca013 100644
> --- a/include/hw/core/loader.h
> +++ b/include/hw/core/loader.h
> @@ -156,6 +156,36 @@ ssize_t load_elf_ram_sym(const char *filename,
>                            int clear_lsb, int data_swab,
>                            AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);
>   
> +/*
> + * segment_fn_t:
> + * Per-PT_LOAD segment callback for load_elf_ram_sym_buf().
> + */
> +typedef bool (*segment_fn_t)(void *opaque,
> +                             uint64_t paddr, uint64_t vaddr,
> +                             uint64_t filesz, uint64_t memsz);
> +
> +/*
> + * load_elf_ram_sym_buf:
> + * @buf: pointer to an in-memory ELF image
> + * @buflen: size of @buf in bytes
> + * @segment_fn: optional per-PT_LOAD callback
> + * @segment_opaque: opaque data passed to @segment_fn
> + *
> + * Identical to load_elf_ram_sym() but loads from a caller-supplied
> + * memory buffer instead of a file.  All other parameters have the
> + * same meaning as load_elf_ram_sym().
> + */
> +ssize_t load_elf_ram_sym_buf(const uint8_t *buf, size_t buflen,
> +                             uint64_t (*elf_note_fn)(void *, void *, bool),
> +                             uint64_t (*translate_fn)(void *, uint64_t),
> +                             void *translate_opaque, uint64_t *pentry,
> +                             uint64_t *lowaddr, uint64_t *highaddr,
> +                             uint32_t *pflags, int elf_data_order,
> +                             int elf_machine, int clear_lsb, int data_swab,
> +                             AddressSpace *as, bool load_rom,
> +                             symbol_fn_t sym_cb,
> +                             segment_fn_t segment_fn, void *segment_opaque);
> +
>   /** load_elf_as:
>    * Same as load_elf_ram_sym(), but always loads the elf as ROM
>    */
> diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
> index 044e72de2a..a2c9b52bf9 100644
> --- a/include/hw/elf_ops.h.inc
> +++ b/include/hw/elf_ops.h.inc
> @@ -321,7 +321,9 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>                                     uint32_t *pflags, int elf_machine,
>                                     int clear_lsb, int data_swab,
>                                     AddressSpace *as, bool load_rom,
> -                                  symbol_fn_t sym_cb)
> +                                  symbol_fn_t sym_cb,
> +                                  segment_fn_t segment_fn,
> +                                  void *segment_opaque)
>   {
>       struct elfhdr ehdr;
>       struct elf_phdr *phdr = NULL, *ph;
> @@ -504,6 +506,14 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>                   addr = ph->p_paddr;
>               }
>   
> +            if (segment_fn) {
> +                if (!segment_fn(segment_opaque, addr, ph->p_vaddr,
> +                                file_size, mem_size)) {
> +                    ret = ELF_LOAD_FAILED;
> +                    goto fail;
> +                }
> +            }
> +
>               if (data_swab) {
>                   elf_word j;
>                   for (j = 0; j < file_size; j += (1 << data_swab)) {


