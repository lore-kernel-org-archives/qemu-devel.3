Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DEBC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 16:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s80nL-00009N-Qi; Fri, 17 May 2024 12:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s80nK-00008d-B1; Fri, 17 May 2024 12:50:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s80nG-00012D-48; Fri, 17 May 2024 12:50:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HGomwO003547; Fri, 17 May 2024 16:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=miH3sW21gydpc1VWw0IB4KBP/c7FYgpYLpAMacIHT6U=;
 b=AMhszD3uc0vUYiqlC8rXgUp9uUbjP8wtGki827GhwRoAFpT9J3qlQxGyUU+6+HWbI4bU
 Q31xneqxDFYXwcWLdYCHqUFA+9u8E+e22kG1r5SKPdqOci446s5RDcDWTTDGhz90QfIU
 SFQqFn5MeeXR7vnsrZmogKdRv4bvevrkZH0gT8JfhYEAhn0Vmpm3bn+JwPZDqWdFk6q8
 hec1M4RWrQnvQUeyGTVqDC+KfZQdwfJerlmONOIhhfwgMlbQSe8yE+MyDskHbppzyoWt
 WrmmuP32+T5PJE1CYVGHJUpHB6VhhrONewKAf/eZfdtU+QjaxGlgjnm7jpIP0ETVQoH7 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y6ab7g3pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 16:50:48 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HGompk003584;
 Fri, 17 May 2024 16:50:48 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y6ab7g3h5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 16:50:48 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HEiE07006183; Fri, 17 May 2024 16:46:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgn139t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 16:46:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44HGkCol39649558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 May 2024 16:46:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 066A35805C;
 Fri, 17 May 2024 16:46:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54F425805E;
 Fri, 17 May 2024 16:46:11 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 May 2024 16:46:11 +0000 (GMT)
Message-ID: <bf5641abc75b53403f54ddf05008ad2ae50229c5.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/5] tests/qtest: Add pnv-spi-seeprom qtest
From: Miles Glenn <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: fbarrat@linux.ibm.com, npiggin@gmail.com, clg@kaod.org, calebs@us.ibm.com, 
 chalapathi.v@ibm.com, chalapathi.v@linux.ibm.com,
 saif.abrar@linux.vnet.ibm.com, dantan@us.ibm.com
Date: Fri, 17 May 2024 11:46:10 -0500
In-Reply-To: <20240516163304.25191-6-chalapathi.v@linux.ibm.com>
References: <20240516163304.25191-1-chalapathi.v@linux.ibm.com>
 <20240516163304.25191-6-chalapathi.v@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XqHLl75HMB_KUdEzsRQIMjtr3xFhNP31
X-Proofpoint-ORIG-GUID: BW43eqJHooM4jB1BEMChhQOYbOH4akQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_07,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=753 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Chalapathi,

Looks good.  I think I would just shorten the names of the xscom
read/write functions to make things more readable inside the
transaction function.

-Glenn

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

> +static uint64_t pnv_spi_seeprom_xscom_addr(uint32_t reg)
> +{
> +    return pnv_xscom_addr(SPIC2_XSCOM_BASE + reg);
> +}
> +
> +static void pnv_spi_controller_xscom_write(QTestState *qts, uint32_t
> reg,
> +                uint64_t val)
> +{
> +    qtest_writeq(qts, pnv_spi_seeprom_xscom_addr(reg), val);
> +}
> +
> +static uint64_t pnv_spi_controller_xscom_read(QTestState *qts,
> uint32_t reg)
> +{
> +    return qtest_readq(qts, pnv_spi_seeprom_xscom_addr(reg));
> +}
> +
> +static void spi_seeprom_transaction(QTestState *qts)
> +{
> +    /* SPI transactions to SEEPROM to read from SEEPROM image */
> +    pnv_spi_controller_xscom_write(qts, COUNTER_CONFIG_REG,
> +                                    READ_OP_COUNTER_CONFIG);
> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
> +                                    READ_OP_SEQUENCER);
> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG,
> READ_OP_TDR_DATA);
> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, 0);
> +    /* Read 5*8 bytes from SEEPROM at 0x100 */
> +    uint64_t rdr_val = pnv_spi_controller_xscom_read(qts,
> RECEIVE_DATA_REG);
> +    printf("RDR READ = 0x%lx\n", rdr_val);
> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    printf("RDR READ = 0x%lx\n", rdr_val);
> +
> +    /* SPI transactions to SEEPROM to write to SEEPROM image */
> +    pnv_spi_controller_xscom_write(qts, COUNTER_CONFIG_REG,
> +                                    WRITE_OP_COUNTER_CONFIG);
> +    /* Set Write Enable Latch bit of status0 register */
> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
> +                                    WRITE_OP_SEQUENCER);
> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG,
> WRITE_OP_WREN);
> +    /* write 8 bytes to SEEPROM at 0x100 */
> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
> +                                    WRITE_OP_SEQUENCER);
> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG,
> WRITE_OP_TDR_DATA);
> +}
> +
> +/* Find complete path of in_file in the current working directory */
> +static void find_file(const char *in_file, char *in_path)
> +{
> +    g_autofree char *cwd = g_get_current_dir();
> +    char *filepath = g_build_filename(cwd, in_file, NULL);
> +    if (!access(filepath, F_OK)) {
> +        strcpy(in_path, filepath);
> +    } else {
> +        strcpy(in_path, "");
> +        printf("File %s not found within %s\n", in_file, cwd);
> +    }
> +}
> +
> +static void test_spi_seeprom(void)
> +{
> +    QTestState *qts = NULL;
> +    char seepromfile[500];
> +    find_file("sbe_measurement_seeprom.bin.ecc", seepromfile);
> +    if (strcmp(seepromfile, "")) {
> +        printf("Starting QEMU with seeprom file.\n");
> +        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
> +                          "threads=1 -accel tcg,thread=single
> -nographic "
> +                          "-blockdev node-
> name=pib_spic2,driver=file,"
> +			  "filename=sbe_measurement_seeprom.bin.ecc "
> +			  "-device 25csm04,bus=pnv-spi-bus.2,cs=0,"
> +			  "drive=pib_spic2");
> +    } else {
> +        printf("Starting QEMU without seeprom file.\n");
> +        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
> +                          "threads=1 -accel tcg,thread=single
> -nographic"
> +			  " -device 25csm04,bus=pnv-spi-bus.2,cs=0");
> +    }
> +    spi_seeprom_transaction(qts);
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("spi_seeprom", test_spi_seeprom);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 86293051dc..2fa98b2430 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -171,6 +171,7 @@ qtests_ppc64 = \
>    qtests_ppc + \
>    (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-
> test'] : []) +               \
>    (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] 
> : []) +                 \
> +  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-
> test'] : []) +           \
>    (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-
> test'] : []) +              \
>    (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] :
> []) +                      \
>    (slirp.found() ? ['pxe-test'] : []) +              \


