Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF00CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENIV-00071o-HO; Wed, 07 Oct 2026 04:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avnish@linux.ibm.com>)
 id 1xEGxe-0008N4-3O; Tue, 06 Oct 2026 22:01:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avnish@linux.ibm.com>)
 id 1xEGwl-0003Nn-J5; Tue, 06 Oct 2026 22:00:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696EZgBk3994513; Tue, 6 Oct 2026 16:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/MELEA
 mgbyE4oXdj8OKfgaLRBUhLYIJYyIdpdy+Oev0=; b=Z58QmbAdUgvrWuveBw5ub/
 VtwGgGgqtIhXvsW5AzwvbgMrSEgjp2a3uqnfq0YwL/y352+/UNUf378E7LJnt1C9
 b2WZ6J0w45F7y7h3EWJeWvio0wpiknK75FY5EV7QsVtUooNSbkLgwGJSv2DHvqwB
 0i2+gF/8g09guiZIvveiCRZSmondO/lAwYGKnd3A7f0qp1ENLboTwXu92kdXrN53
 DXtTjqlBMZxVMP5A3BR5L6warjC4CR6TJ0h/KzROtcnvo4LKCm7s8A1vVGI5F2Fm
 2UGExud3gBEj16SrkNZUzJt3KLooeIG/BI8QicItQw6jL/kDX6VRrDUFGnjC/djQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv85p4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 16:49:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696EHaPj411053; Tue, 6 Oct 2026 16:49:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1ptyve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 16:49:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696GnHne27001584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 16:49:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFE8F58067;
 Tue,  6 Oct 2026 16:49:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8036558065;
 Tue,  6 Oct 2026 16:49:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 16:49:16 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 22:19:16 +0530
From: Avnish Chouhan <avnish@linux.ibm.com>
To: uverma@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, pbonzini@redhat.com, th.huth@posteo.eu,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@linaro.org,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Subject: Re: [RFC PATCH v2 0/8] ppc/spapr: VOF disk image (qcow2) boot support
In-Reply-To: <20261002052605.605858-1-uverma@linux.ibm.com>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
Message-ID: <29203cbbb27553aaca664e3baf1a9dde@linux.ibm.com>
X-Sender: avnish@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aYt6Xz0R2BDak_2oQSNc35vQhBV6aN1C
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac52690 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=EGYj-OwPAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=LErgDqkAfzjqz7ggpl8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xQyHFheebwQZ3wMG2Lhb:22
X-Proofpoint-GUID: h_Vw3wzRtg-ARcRPhwO8Lg-RNgXWlBvK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2NiBTYWx0ZWRfX4Ot72tvCNdHO
 SAVG5PPoViWXpbXK+88MkbAV7r/sMVffYgfu8wQWVILul0TumynTa8kUYT+KH/wKFH3kbFBNinJ
 Uu7abHBdT3haQuv/yWxCCEU4Y9uBCLkHgiDajWcagLIkRXXTt25ZS7pSViJOQdM52F7CHMKgKMv
 C2YOrs2H5Du8M5JlSCwe/brJLnxwi/vyG4+yWQ+Oj/o08hoWQ1I7NYIACstwPh515BrkO1kcvND
 u7mW96oLIlbOnQk4nQYCRi490E0+Sj3XSC+VX+gvILndEkKZ/15xVkZgceoBbb5YnM98CbxXX8T
 lwePb8j8tvx+LDlgiti04s2LuicV7e6f0x5DMfT8Ki8m65vyL/psec/4mek/aDEmAGAGRZJz4yc
 4qnv2FMEXYCr1QfW2De/jxATuiFYzJ+nuyivqPOF615xuRbWi8t9rFehFZXDY3t/kxNgR2Xq5/5
 +znPCZ+pUtJjHrVq0nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2NiBTYWx0ZWRfX4vb/qsYqA2uy
 fGCV82z0oCFB9oMtLeB6y8FA4OtanhIytoABdcyjpe+DJs8DbdfRJxmd/AoylooAaBheKezR4tw
 emcZP2H1KUAnBHGXbIaPJ+DgLPWWgys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=avnish@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Oct 2026 04:24:13 -0400
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

On 2026-10-02 10:55, uverma@linux.ibm.com wrote:

Reviewed the complete series, looks good!

Reviewed-by: Avnish Chouhan <avnish@linux.ibm.com>

Regards,
Avnish Chouhan

> From: Utkarsh Verma <uverma@linux.ibm.com>
> 
> This series adds support for booting from a disk image under the 
> Virtual Open
> Firmware (VOF) path for sPAPR/pseries machines in QEMU.
> 
> The most common use case for pseries VMs is booting from a distro qcow2 
> disk
> image. These images carry a PReP boot partition containing GRUB2, which 
> in turn
> loads the kernel and initrd via IEEE 1275 client interface calls.
> VOF currently only supports direct -kernel/-initrd boot; there is no
> firmware-mediated path to hand off to a bootloader on disk. This series
> implements that missing path, making VOF capable of handling the 
> standard
> distro qcow2 boot flow without requiring SLOF.
> 
> This series takes reference from an earlier implementation by Alexey
> Kardashevskiy [1] which explored the same concept but was not carried 
> forward at
> the time.
> 
> The existing load_elf function works on a file, whereas in the VOF the 
> PReP
> partition (GRUB) is read from the disk image and loaded in the memory, 
> also
> on loading the PReP partition in the guest memory the 
> /memory@0/available FDT
> needs to be properly updated for each PT_LOAD segment of the core.elf 
> file
> of the GRUB (PReP partition).
> 
> Implemented a new public elf loader API load_elf_ram_sym_buf() to 
> resolve both
> these issues.
> - load_elf_ram_sym_buf() accepts a caller-supplied memory buffer 
> instead of a
>   filename, using g_file_open_tmp() to obtain an anonymous file 
> descriptor for
>   the caller-supplied buffer. This means the ELF image has 2 copies, 
> the
>   caller's heap buffer and the temporary file. For typical PReP 
> partition sizes
>   (~4 MB) this is acceptable, but if a more memory-efficient approach 
> is
>   preferred we are open to alternatives. Feedback on the preferred 
> direction is
>   welcome.
> - Also, added optional segment_fn_t callback in load_elf_ram_sym_buf() 
> through
>   the internal elf_ops.h.inc template; it is invoked once per PT_LOAD 
> segment
>   after the load address is resolved, allowing callers to perform 
> per-segment
>   work such as VOF memory claims.
> 
> When no -kernel is given, spapr_vof_reset() calls a newly implemented 
> function
> spapr_vof_try_prep_boot() which iterates attached block backends, scans
> partitions for a PReP boot partition, reads the partition contents into 
> a
> host buffer, calls load_elf_ram_sym_buf() to load the GRUB in the guest 
> memory,
> and on success stores the ELF entry point in spapr->kernel_addr.
> spapr_vof_client_dt_finalize() then writes the entry point into
> /chosen/qemu,boot-kernel so VOF then transfers control to GRUB.
> 
> - Partition scanner (spapr_vof_partition.c): scans MBR and GPT 
> partition tables
>   on a BlockBackend to locate the PReP boot partition.
> 
> - Core loader extension (hw/core/loader.c): new load_elf_ram_sym_buf() 
> API loads
>   a 32/64-bit ELF binary from a caller-supplied memory buffer, reusing 
> the
>   existing load_elf32/load_elf64 paths. A new segment_fn_t callback in
>   elf_ops.h.inc lets callers act on each PT_LOAD segment as it is 
> resolved.
> 
> - read, seek OF services: two previously unimplemented IEEE 1275 client
>   services, covering block device I/O needed by GRUB.
> 
> - vscsi-report-luns method: walks the SCSIBus and builds the LUN report 
> table
>   in guest memory in the format expected by GRUB's ofdisk driver, 
> matching
>   SLOF's dev-generate-srplun encoding.
> 
> - VTY write/read routing: routes console I/O through the VTY chardev 
> backend;
>   promotes vty_getchars to external linkage. Also opens a stdin ihandle 
> in
>   addition to stdout so GRUB can read from the console.
> 
> - FDT "disk" wildcard child node (spapr_vscsi.c): emits a single 
> generic "disk"
>   child FDT node under the vSCSI adapter (without a per-LUN suffix), 
> matching
>   the actual Open Firmware behaviour. The path_offset() wildcard 
> fallback
>   resolves any "disk@<srp-lun>" open request to this shared node; the 
> LUN is
>   extracted from the path string at runtime in vof_do_open().
> 
> We used AI to build prototype with manual changes incorporated as 
> identified
> during debugging multiple issues faced while making it work, hence 
> using below
> tag as being discussed in the ongoing AI policy patch:
> [PATCH v4 0/4] docs/devel, AGENTS.md: a completely new policy on
> AI-generated contributions
> Link to the patch [2].
> AI-used-for: Code
> 
> Testing:
> 
> The series has been tested end-to-end by booting a RHEL9.7 qcow2 image 
> on a
> pseries machine with VOF enabled (no SLOF).
> 
> build$ ./qemu-system-ppc64 -M pseries,x-vof=on -cpu power9 -m 2G \
> -hda ../../rhel-guest-image-9.7-20251021.0.ppc64le.qcow2 -nographic
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-cfpc=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ibs=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=on
> Welcome to GRUB!
> <snip>
>                                GRUB version 2.06
> 
>  
> +----------------------------------------------------------------------------+
>  |*Red Hat Enterprise Linux (5.14.0-611.5.1.el9_7.ppc64le) 9.7 (Plow)   
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  |                                                                      
>       |
>  
> +----------------------------------------------------------------------------+
> 
>       Use the ^ and v keys to select which entry is highlighted.
>       Press enter to boot the selected OS, `e' to edit the commands
>       before booting or `c' for a command-line.
> 
> <snip>
> 
> Red Hat Enterprise Linux 9.7 (Plow)
> Kernel 5.14.0-611.5.1.el9_7.ppc64le on an ppc64le
> 
> Activate the web console with: systemctl enable --now cockpit.socket
> 
> localhost login: root
> Password:
> Last login: Fri Jul 10 01:45:44 on hvc0
> [root@localhost ~]#
> [root@localhost ~]# ls /
> afs  boot  etc	 lib	media  opt   root  sbin  sys  usr
> bin  dev   home  lib64	mnt    proc  run   srv	 tmp  var
> [root@localhost ~]#
> [root@localhost ~]# echo "Hello, World!" > hello.txt
> [root@localhost ~]# cat hello.txt
> Hello, World!
> [root@localhost ~]#
> 
> [1] 
> https://lore.kernel.org/qemu-devel/20200203032943.121178-1-aik@ozlabs.ru/#t
> [2] 
> https://lore.kernel.org/qemu-devel/20260930085433.830743-1-pbonzini@redhat.com/
> 
> Utkarsh Verma (8):
>   ppc/spapr: add PReP boot partition detection
>   hw/loader: add load_elf_ram_sym_buf() for in-memory ELF loading
>   ppc/spapr: add baseline VOF disk boot support
>   ppc/spapr: add VTY backend support to OF read/write/open services
>   ppc/spapr: add block device backend to VOF open/read/write/seek
>     services
>   spapr_vscsi: add VOF disk nodes to the device tree
>   ppc/spapr: strip OF path argument suffix in path_offset
>   ppc/spapr: implement vscsi-report-luns call-method for PAPR vSCSI
> 
>  hw/char/spapr_vty.c          |   2 +-
>  hw/core/loader.c             |  81 +++++-
>  hw/ppc/meson.build           |   5 +-
>  hw/ppc/spapr_vof.c           | 164 +++++++++++-
>  hw/ppc/spapr_vof_partition.c | 272 ++++++++++++++++++++
>  hw/ppc/trace-events          |   4 +
>  hw/ppc/vof.c                 | 475 ++++++++++++++++++++++++++++++++++-
>  hw/scsi/spapr_vscsi.c        |  23 ++
>  include/hw/core/loader.h     |  30 +++
>  include/hw/elf_ops.h.inc     |  12 +-
>  include/hw/ppc/spapr_vio.h   |   1 +
>  include/hw/ppc/spapr_vof.h   |  14 ++
>  include/hw/ppc/vof.h         |   2 +
>  13 files changed, 1070 insertions(+), 15 deletions(-)
>  create mode 100644 hw/ppc/spapr_vof_partition.c
>  create mode 100644 include/hw/ppc/spapr_vof.h

