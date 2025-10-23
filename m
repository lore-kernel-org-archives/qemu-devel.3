Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A39CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 07:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBprs-0002Cv-RW; Thu, 23 Oct 2025 03:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBprp-00029r-7U; Thu, 23 Oct 2025 03:36:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBprl-0001Gl-1L; Thu, 23 Oct 2025 03:36:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MKpWot017956;
 Thu, 23 Oct 2025 07:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=qTzcLsGAb+l30vWZwteq8lQsD9UIsp
 gC2BUdX8z3V0A=; b=SA7Xuh0jh97fvpVs/GOO7phKpcUP5qjuR4U2Q/Ln57veFi
 6tIUYh9uwQDMod4d02yBMuad7Zm+BSCQzHQPrbsCh+KGdLZX5dmnhwylTAUA/Orb
 kyd38O4SxOBnRpiudJstRo/1wlugbH1erD0njl9Xcol7PzfasXlQHMBnjyyUhyJ6
 rESbomzOklnPOKtv/nTW6vf/8tCXY70QFH78qE7G8RuLEgUVjSgrtEo/gGu1ENrI
 53iOUODmSm1keuriLMX9GL9zdxbe/Hwtgz/zDGTvEz+tJU6N7ay/l0P4w/r4ev0z
 jVdazD7a0xKWYrmIV/dCfJQc7IOtTumLvAB24v7g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s8x5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:35:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N7ZkHR002016;
 Thu, 23 Oct 2025 07:35:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s8x5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:35:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6QoHr032096;
 Thu, 23 Oct 2025 07:35:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n4hk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:35:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N7ZfqS50725204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 07:35:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BBC820043;
 Thu, 23 Oct 2025 07:35:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A8C020040;
 Thu, 23 Oct 2025 07:35:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.253])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Oct 2025 07:35:37 +0000 (GMT)
Date: Thu, 23 Oct 2025 13:05:32 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: shivang upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 0/8] Implement Firmware Assisted Dump for PSeries
Message-ID: <o6fvcmmrppmh2qxm5g73gg2ece6uy6ywzydvj5fbolluxkxbff@x5457rib3ca3>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <3e3378f1-7fc0-47da-800a-9f8987bf072b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3378f1-7fc0-47da-800a-9f8987bf072b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AV6n5KejJIWGv4t_2u_hPMwB3KwJq7k-
X-Proofpoint-GUID: R_BIScBEvmVZdF_zTmYBoy5Gs1eitDMN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0EAaVHj4xobP
 ENCIQxI28nxxSNFJMYvVIaemdwccvsRbk8Od/uGQQYB5NLEv6bzY53mWdCtQ82qanhNy13b9Xft
 UiXwadc8H/4Wxh/VGIMKNPE9nwa+dOn1P+LOx8SrqjH7NSRudN7O+qzzvwdhT6bmYsTRXJNZndx
 2K8TtBTzwtrv9de7z+2zUyqSncyzmjlLkmgtIvfEbbFoSwMhy6Q/yL+alXcPtwzmDRe8t4yiD1i
 cu+/zuMBZa+ScWPIUW1b9/Kw0msToM/OtKk98WxvdsVBPnKuN3z7muC5gE7VTRIHwhncb3GnO9p
 16wCzzJ8xSwl8PpqDACI6XvsyJwIr1pCwFPUXQX+7OGisR3x5ZKMQNyaEcLprLSBVXtqBxA4rV4
 kshPrm9WW4tPF8V14iUEssvXCXLkvw==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f9dad2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=93Ubh6UdAAAA:8 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8 a=_mP84sfxVUV9Dh3dp9EA:9
 a=CjuIK1q_8ugA:10 a=q-6THwuxr82FYj4XiUVi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/10/23 12:51PM, shivang upadhyay wrote:
> 
> > <...snip...>
>
> >   MAINTAINERS                               |   8 +
> >   hw/ppc/meson.build                        |   1 +
> >   hw/ppc/spapr.c                            |  69 ++
> >   hw/ppc/spapr_fadump.c                     | 730 ++++++++++++++++++++++
> >   hw/ppc/spapr_rtas.c                       |  76 +++
> >   include/hw/ppc/spapr.h                    |  11 +-
> >   include/hw/ppc/spapr_fadump.h             | 124 ++++
> >   tests/functional/ppc64/meson.build        |   2 +
> >   tests/functional/ppc64/test_fadump.py     | 182 ++++++
> >   tests/functional/qemu_test/linuxkernel.py |  59 ++
> >   10 files changed, 1261 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/ppc/spapr_fadump.c
> >   create mode 100644 include/hw/ppc/spapr_fadump.h
> >   create mode 100755 tests/functional/ppc64/test_fadump.py
> 
> I've tested this patch series on the fedora-42 cloud images [1], and
> buildroot `qemu_ppc64_pseries_defconfig` image.
> Tested-by:Shivang Upadhyay <shivangu@linux.ibm.com>

Thanks for testing the patches, Shivang !

- Aditya G

> following are the logs for fedora test.
> kernel command line
> # grubby --info=ALL
> ....
> args="no_timer_checkconsole=tty1console=ttyS0,115200n8systemd.firstboot=offrootflags=subvol=rootfadump=on"
> ....
> triggeringthepanic
> # echo c > /proc/sysrq-trigger
> [390.457957]sysrq:Triggeracrash
> [390.462183]Kernelpanic-notsyncing:sysrqtriggeredcrash
> [390.463285]CPU:0UID:0PID:1081Comm:bashNottainted6.14.0-63.fc42.ppc64le#1
> [390.464074]Hardwarename:IBMpSeries(emulatedbyqemu)POWER10(architected)0x8012000xf000006of:SLOF,git-ee03aepSeries
> [390.465359]CallTrace:
> [390.465675][c000000007023890][c000000001787a64]dump_stack_lvl+0x88/0xc4(unreliable)
> [390.467916][c0000000070238c0][c000000000250a44]panic+0x19c/0x4a8
> [390.468555][c000000007023960][c000000000f70684]sysrq_handle_crash+0x24/0x30
> [390.469218][c0000000070239c0][c000000000f71388]__handle_sysrq+0xe8/0x3c0
> [390.469898][c000000007023a90][c000000000f722d0]write_sysrq_trigger+0x1d0/0x268
> [390.470563][c000000007023af0][c0000000008bf620]proc_reg_write+0xf0/0x160
> [390.471184][c000000007023b20][c0000000007b63b8]vfs_write+0x128/0x590
> [390.471791][c000000007023be0][c0000000007b6a10]ksys_write+0x80/0x150
> [390.472388][c000000007023c30][c000000000032980]system_call_exception+0x160/0x310
> [390.473075][c000000007023e50][c00000000000d05c]system_call_vectored_common+0x15c/0x2ec
> [390.473826]---interrupt:3000at0x7fffa36a8494
> [390.474653]NIP:00007fffa36a8494LR:00007fffa36a8494CTR:0000000000000000
> [390.475341]REGS:c000000007023e80TRAP:3000Nottainted(6.14.0-63.fc42.ppc64le)
> [390.476056]MSR:800000000280f033<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>CR:48222408XER:00000000
> [390.477150]IRQMASK:0
> [390.477150]GPR00:000000000000000400007fffefd0a24000000000001000000000000000000001
> [390.477150]GPR04:000000013fd206c0000000000000000200000000000000000000000000000000
> [390.477150]GPR08:0000000000000000000000000000000000000000000000000000000000000000
> [390.477150]GPR12:000000000000000000007fffa3a0ac20000000012300005c000000013fd59b40
> [390.477150]GPR16:0000000123009528000000013fd3e3f000000000000000010000000122f06460
> [390.477150]GPR20:00000000000000000000000122faea1000000001230096d80000000123008bb8
> [390.477150]GPR24:00000000000000000000000123008ba80000000122fb156000007fffa3841878
> [390.477150]GPR28:000000000000000200007fffa3841790000000013fd206c00000000000000002
> [390.483172]NIP[00007fffa36a8494]0x7fffa36a8494
> [390.483616]LR[00007fffa36a8494]0x7fffa36a8494
> [390.484072]---interrupt:3000
> qemu-system-ppc64:warning:TCGdoesn'tsupportrequestedfeature,cap-cfpc=workaround
> qemu-system-ppc64:warning:TCGdoesn'tsupportrequestedfeature,cap-ibs=workaround
> qemu-system-ppc64:warning:TCGdoesn'tsupportrequestedfeature,cap-ccf-assist=on
> SLOF**********************************************************************
> QEMUStarting
> BuildDate=Nov6202415:31:54
> FWVersion=git-ee03aec2c106a699
> Press"s"toenterOpenFirmware.
> Populating/vdevicemethods
> Populating/vdevice/vty@71000000
> Populating/vdevice/nvram@71000001
> Populating/vdevice/l-lan@71000002
> Populating/vdevice/v-scsi@71000003
> SCSI:Lookingfordevices
> 8000000000000000DISK:"QEMUQEMUHARDDISK2.5+"
> 8200000000000000CD-ROM:"QEMUQEMUCD-ROM2.5+"
> Populating/pci@800000020000000
> 000000(D):12341111qemuvga
> 000800(D):10330194serialbus[usb-xhci]
> InstallingQEMUfb
> ScanningUSB
> XHCI:Initializing
> USBKeyboard
> USBmouse
> Usingdefaultconsole:/vdevice/vty@71000000
> WelcometoOpenFirmware
> Copyright(c)2004,2017IBMCorporationAllrightsreserved.
> Thisprogramandtheaccompanyingmaterialsaremadeavailable
> underthetermsoftheBSDLicenseavailableat
> http://www.opensource.org/licenses/bsd-license.php
> Tryingtoload:from:/vdevice/v-scsi@71000003/disk@8000000000000000...Successfullyloaded
> WelcometoGRUB!
> error:../../grub-core/term/serial.c:278:serialport`auto'isn'tfound.
> error:../../grub-core/commands/terminal.c:138:terminal`serial'isn'tfound.
> error:../../grub-core/commands/terminal.c:138:terminal`serial'isn'tfound.
> Booting`FedoraLinux(6.14.0-63.fc42.ppc64le)42(CloudEdition)'
> OFstdoutdeviceis:/vdevice/vty@71000000
> PreparingtobootLinuxversion6.14.0-63.fc42.ppc64le(mockbuild@6dfdb20f66f3497abc344a07ba6fd9d1)(gcc(GCC)15.0.120250228(RedHat15.0.1-0),GNUldversion2.44-3.fc42)#1
> SMP Mon Mar 24 19:38:12 UTC 2025
> Detectedmachinetype:0000000000000101
> commandline:BOOT_IMAGE=(ieee1275/disk,gpt2)/vmlinuz-6.14.0-63.fc42.ppc64leno_timer_checkconsole=tty1console=ttyS0,115200n8systemd.firstboot=offroot=UUID=1226ffcb-9b43-42cd-9265-c87dfc50b214rootflags=subvol=rootfadump=on
> Maxnumberofcorespassedtofirmware:2048(NR_CPUS=2048)
> Callingibm,client-architecture-support...done
> memorylayoutatinit:
> memory_limit:0000000000000000(16MBaligned)
> alloc_bottom:000000000ac50000
> alloc_top:0000000030000000
> alloc_top_hi:0000000280000000
> rmo_top:0000000030000000
> ram_top:0000000280000000
> founddisplay:/pci@800000020000000/vga@0,opening...done
> instantiatingrtasat0x000000002fff0000...done
> prom_hold_cpus:skipped
> copyingOFdevicetree...
> Buildingdtstrings...
> Buildingdtstructure...
> Devicetreestrings0x000000000ac60000->0x000000000ac60c96
> Devicetreestruct0x000000000ac70000->0x000000000ac80000
> QuiescingOpenFirmware...
> BootingLinuxvia__start()@0x0000000002300000...
> [0.000000]rtasfadump:Firmware-assisteddumpisactive.
> [0.000000]random:crnginitdone
> [0.000000]fadump:Updatedcmdline:BOOT_IMAGE=(ieee1275/disk,gpt2)/vmlinuz-6.14.0-63.fc42.ppc64leno_timer_checkconsole=tty1console=ttyS0,115200n8systemd.firstboot=offroot=UUID=1226ffcb-9b43-42cd-9265-c87dfc50b214rootflags=subvol=rootfadump=on
> [0.000000]fadump:Firmware-assisteddumpisactive.
> [0.000000]fadump:Reserving9728MBofmemoryat0x00000020000000forpreservingcrashdata
> [0.000000]radix-mmu:Pagesizesfromdevice-tree:
> [0.000000]radix-mmu:Pagesizeshift=12AP=0x0
> [0.000000]radix-mmu:Pagesizeshift=16AP=0x5
> [0.000000]radix-mmu:Pagesizeshift=21AP=0x1
> [0.000000]radix-mmu:Pagesizeshift=30AP=0x2
> ....
> openingthegeneratedinvmcoreincrash(vmlinuxdebugsourcetakenfrom[2]).
> # crash ./vmcore ./vmlinux
> crash9.0.0++
> ....
> Forhelp,type"help".
> Type"aproposword"tosearchforcommandsrelatedto"word"...
> KERNEL:/home/crash-images/vmlinux
> DUMPFILE:./vmcore[PARTIALDUMP]
> CPUS:1
> DATE:WedDec3119:00:00EST1969
> UPTIME:00:04:33
> LOADAVERAGE:1.14,1.50,0.73
> TASKS:111
> NODENAME:localhost
> RELEASE:6.14.0-63.fc42.ppc64le
> VERSION:#1 SMP Mon Mar 24 19:38:12 UTC 2025
> MACHINE:ppc64le(1000Mhz)
> MEMORY:10GB
> PANIC:"Kernelpanic-notsyncing:sysrqtriggeredcrash"
> PID:1084
> COMMAND:"bash"
> TASK:c000000007057580[THREAD_INFO:c000000007057580]
> CPU:0
> STATE:TASK_RUNNING(PANIC)
> crash>
> ....
> [1]https://fedoraproject.org/cloud/download/
> [2]https://archive.fedoraproject.org/pub/fedora-secondary/releases/42/Server/ppc64le/debug/tree/Packages/k/kernel-debuginfo-6.14.0-63.fc42.ppc64le.rpm

