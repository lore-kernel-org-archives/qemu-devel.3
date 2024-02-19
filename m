Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B5EC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6DY-0008H7-Tl; Mon, 19 Feb 2024 11:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danger_mail@list.ru>)
 id 1rc6DW-0008GT-FU
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:10:06 -0500
Received: from smtp35.i.mail.ru ([95.163.41.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danger_mail@list.ru>)
 id 1rc6DR-00051g-DM
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
 MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=+rLYNJUrChrhtAzWA7Iq674kHGbq6l7dYTMgsmhOvko=; t=1708358999; x=1708448999; 
 b=Yf1zKIF/cKkpojObeFoNTnEAHk0VQSIQbG0htYN8TdUpAnipPzDsP10mS61SzuqiFsatboEKZzl
 R+7qZEeBJGt0oDGtd4pv13Mj8UG0GEOiZQXYo3EGZw1Xvzhdza9v2V04hSJkG/OPXvnqwl9AMbVbw
 Lvu2J8CkERhJHj0RwVsc2zA7bXcYptk8Xw1/l8PnHLK3MjXRKWpj0nOSJ2CFSW+ViypSIc6B4J3/O
 8W84to7uDnc/09DKtOAEMsk5JnUoS0xBtzTaGzDYUnMeic8+3OeHzrKE4MHrqcs/Cu1yEbUtnEvlN
 2hC/TyGvTkzilcqoQ6JDNB/fiy7HsRzDnIag==;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <danger_mail@list.ru>)
 id 1rc6DM-000000005Ze-0NSr
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 19:09:56 +0300
Message-ID: <180d236d-c8e4-411a-b4d2-632eb82092fa@list.ru>
Date: Tue, 20 Feb 2024 01:09:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] target/riscv: fix ACPI MCFG table
Content-Language: en-US
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp35.i.mail.ru;
 auth=pass smtp.auth=danger_mail@list.ru
 smtp.mailfrom=danger_mail@list.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021D47CBE561CA8C01FDA47252976C9176500894C459B0CD1B999EC5E4F9728C878D27678DDAA8063143FB8ED8A408A9F4D028ACB8DCD7A66960C43EDF95CA0F6DD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75DF2B1F23425CAE5EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637770CCD3A0ADFB7EEEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8714516BAF94BBB0A553D5D6BCE1227FB6792A51A8589F136B51DF9E95F17B0083B26EA987F6312C9ECB1593CA6EC85F86DF04B652EEC242312D2E47CDBA5A96583C09775C1D3CA48CF27ED053E960B195E117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE77A825AB47F0FC8649FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE78366FD4B81DC17BED32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299EE3A9D0FB4FE0F994AC68425D7ADF6C7CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269176DF2183F8FC7C0FE3A47D6FA29121068655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A392ACC50219273B5BD87FFA1E0B5E5AA0A543847C11F186F3C59DAA53EE0834AAEE
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5377C38AD28DF6BE75002B1117B3ED696F4F9A0863B79B9A16E5F408120975D33823CB91A9FED034534781492E4B8EEAD2E48F5DFA0C1F120C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE68A3847C6B99304CD4D6A127131C617A1C103C2C5559A03D030942056DE982B31E81B06003A5D53F1AD97FD9824DBCDD790366A272C9DB5E70F1C10CCE0F2E35400E342A489F880383C93C5AD2DA449913E6812662D5F2A91B65975CF26433F5AF1F79B5EFCC6D737DC734C950D5767
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpg4ZDo8heSwJqUu+O4kKmg==
X-Mailru-Sender: 19D65BA7D561B83B5199152E7322EC669CC9310F04F0FA73B951B70A5BD4BD8E72A2736BAC0B8625E06E9EA040CFE582ADCF3764918E1C99C77752E0C033A69E789E65DE7FDE2F386BE108876BC2C049B4A721A3011E896F
X-Mras: Ok
Received-SPF: pass client-ip=95.163.41.76; envelope-from=danger_mail@list.ru;
 helo=smtp35.i.mail.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  X512 <danger_mail@list.ru>
From:  X512 via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

MCFG segments should point to PCI configuration range, not BAR MMIO.

Signed-off-by: Ilya Chugin <danger_mail@list.ru>
---
  hw/riscv/virt-acpi-build.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index fb8baf64f6..fe01b626ea 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -558,8 +558,8 @@ static void virt_acpi_build(RISCVVirtState *s, 
AcpiBuildTables *tables)
      acpi_add_table(table_offsets, tables_blob);
      {
          AcpiMcfgInfo mcfg = {
-           .base = s->memmap[VIRT_PCIE_MMIO].base,
-           .size = s->memmap[VIRT_PCIE_MMIO].size,
+           .base = s->memmap[VIRT_PCIE_ECAM].base,
+           .size = s->memmap[VIRT_PCIE_ECAM].size,
          };
          build_mcfg(tables_blob, tables->linker, &mcfg, s->oem_id,
                     s->oem_table_id);
-- 
2.42.1


