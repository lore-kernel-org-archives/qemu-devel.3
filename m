Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ED2C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgIq-0004tu-Kd; Thu, 29 Feb 2024 08:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rfgIj-0004sI-On; Thu, 29 Feb 2024 08:18:17 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rfgIh-0003hS-PD; Thu, 29 Feb 2024 08:18:17 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6D5A147F90;
 Thu, 29 Feb 2024 14:18:12 +0100 (CET)
Message-ID: <60950146-7b79-465d-9e33-3c485cc00504@proxmox.com>
Date: Thu, 29 Feb 2024 14:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] Workaround Windows failing to find 64bit SMBIOS
 entry point with SeaBIOS
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, anisinha@redhat.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20240227154749.1818189-1-imammedo@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240227154749.1818189-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 27.02.24 um 16:47 schrieb Igor Mammedov:
> Windows (10) bootloader when running on top of SeaBIOS, fails to find            
> SMBIOSv3 entry point. Tracing it shows that it looks for v2 anchor markers       
> only and not v3. Tricking it into believing that entry point is found            
> lets Windows successfully locate and parse SMBIOSv3 tables. Whether it           
> will be fixed on Windows side is not clear so here goes a workaround.            
>                                                                                  
> Idea is to try build v2 tables if QEMU configuration permits,                    
> and fallback to v3 tables otherwise. That will mask Windows issue                
> form majority of users.                                                          
> However if VM configuration can't be described (typically large VMs)             
> by v2 tables, QEMU will use SMBIOSv3 and Windows will hit the issue              
> again. In this case complain to Microsoft and/or use UEFI instead of             
> SeaBIOS (requires reinstall).                                                    
>                                                                                  
> Default compat setting of smbios-entry-point-type after series                   
> for pc/q35 machines:                                                             
>   * 9.0-newer: 'auto'                                                            
>   * 8.1-8.2: '64'                                                                
>   * 8.0-older: '32'                                                              
>                                                                                  
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2008                        

Thank you! I'm happy to confirm that this series works around the issue :)

Best Regards,
Fiona


