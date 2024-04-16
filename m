Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ADDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwouR-0008Ui-Qz; Tue, 16 Apr 2024 15:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1rwodm-0002r5-7d
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:38:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1rwodh-0003aL-32
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:38:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43GJTgvo002300; Tue, 16 Apr 2024 19:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=k/F/EU+1gEBae2wb/OYbVL78HMhxnfR5ZT0z5b8RkiI=;
 b=ia4bmdkqxDSD4QgkazPE3Y17EiJAJ+tmxINpuopGtUED4ezo0HVSipJnodNvQV/KXVQR
 cGXHalFQcJLY6Xk39Ph+MQ9sVFxsrvx0WXtpKmAhxGzEotufu4vryEBNGZnBFQCzrCDk
 84RrjayKgItpwv7C7TlcAYFBOgwqtbSs/4ENDzUlZK3izzHzf1KHkv3ooAGjzpAepuE+
 IpL3uwGKO+t33mwExUR+93Uhz6nhAt0EeD0UNiZlaI0AppylMpxhfj5UPq472pwwkSf1
 sGSB2YDP1qmVEIT6LXkQOU0MfmZwb37arJ3/b3Reh9dDvHH4Jd+vsZXURAgALip6OKOn kQ== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhygh80qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 19:38:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43GIr5uO023575; Tue, 16 Apr 2024 19:38:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cp03q2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 19:38:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43GJcYFb16122600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 19:38:37 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC09858067;
 Tue, 16 Apr 2024 19:38:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F7AD58066;
 Tue, 16 Apr 2024 19:38:34 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 19:38:34 +0000 (GMT)
Message-ID: <7accde46322e4a653fe961742abedb04f68a2d17.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] hw/i2c: Convert to spec v7 terminology
 (automatically)
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2024 14:38:34 -0500
In-Reply-To: <20240416184722.28334-4-philmd@linaro.org>
References: <20240416184722.28334-1-philmd@linaro.org>
 <20240416184722.28334-4-philmd@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4EzsIjymi6fjEHXesH-PnTpeIhYfoHzb
X-Proofpoint-GUID: 4EzsIjymi6fjEHXesH-PnTpeIhYfoHzb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_17,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Apr 2024 15:55:36 -0400
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

Looks good.  Thanks for taking care of that for us!

-Glenn

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Tue, 2024-04-16 at 20:47 +0200, Philippe Mathieu-Daudé wrote:
> One of the biggest change from I2C spec v6 -> v7 is:
> 
>   • Updated the terms "master/slave" to "controller/target"
> 
> Since it follows the inclusive terminology from the "Conscious
> Language in your Open Source Projects" guidelines [*], replace
> the I2C terminology.
> 
> Mechanical transformation running:
> 
>   $ cat i2c_rename.txt | while read old new; do \
>       sed -i -e "s/$old/$new/g" $(git grep -l $old); \
>     done
> 
> Having:
> 
>   $ cat i2c_rename.txt
>   i2c_bus_master i2c_bus_controller
>   i2c_schedule_pending_master i2c_schedule_pending_controller
>   I2CPendingMasters I2CPendingControllers
>   I2CPendingMaster I2CPendingController
>   pending_masters pending_controllers
>   i2c-slave i2c-target
>   I2C_SLAVE_CLASS I2C_TARGET_CLASS
>   I2C_SLAVE_GET_CLASS I2C_TARGET_GET_CLASS
>   I2CSlaveClass I2CTargetClass
>   I2CSlave I2CTarget
>   TYPE_I2C_SLAVE TYPE_I2C_TARGET
>   I2C_SLAVE I2C_TARGET
>   i2c_slave_new i2c_target_new
>   i2c_slave_create_simple i2c_target_create_simple
>   i2c_slave_realize_and_unref i2c_target_realize_and_unref
>   i2c_slave_set_address i2c_target_set_address
>   VMSTATE_I2C_SLAVE VMSTATE_I2C_TARGET
>   vmstate_i2c_slave vmstate_i2c_target
> 
> [*] 
> https://github.com/conscious-lang/conscious-lang-docs/blob/main/faq.md
> 
> Inspired-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/display/i2c-ddc.h     |   2 +-
>  include/hw/gpio/pca9552.h        |   2 +-
>  include/hw/gpio/pca9554.h        |   2 +-
>  include/hw/i2c/aspeed_i2c.h      |   4 +-
>  include/hw/i2c/i2c.h             |  66 ++++-----
>  include/hw/i2c/i2c_mux_pca954x.h |   2 +-
>  include/hw/i2c/smbus_slave.h     |   4 +-
>  include/hw/nvram/eeprom_at24c.h  |   4 +-
>  include/hw/sensor/tmp105.h       |   2 +-
>  hw/arm/aspeed.c                  | 232 +++++++++++++++------------
> ----
>  hw/arm/bananapi_m2u.c            |   2 +-
>  hw/arm/cubieboard.c              |   2 +-
>  hw/arm/musicpal.c                |   6 +-
>  hw/arm/npcm7xx_boards.c          |  44 +++---
>  hw/arm/nseries.c                 |   6 +-
>  hw/arm/pxa2xx.c                  |  36 ++---
>  hw/arm/realview.c                |   2 +-
>  hw/arm/spitz.c                   |  12 +-
>  hw/arm/stellaris.c               |   2 +-
>  hw/arm/tosa.c                    |  14 +-
>  hw/arm/versatilepb.c             |   2 +-
>  hw/arm/vexpress.c                |   2 +-
>  hw/arm/z2.c                      |  20 +--
>  hw/audio/wm8750.c                |  18 +--
>  hw/display/ati.c                 |   4 +-
>  hw/display/i2c-ddc.c             |  10 +-
>  hw/display/sii9022.c             |  16 +--
>  hw/display/sm501.c               |   2 +-
>  hw/display/ssd0303.c             |  14 +-
>  hw/display/xlnx_dp.c             |   2 +-
>  hw/gpio/max7310.c                |  14 +-
>  hw/gpio/pca9552.c                |  14 +-
>  hw/gpio/pca9554.c                |  14 +-
>  hw/gpio/pcf8574.c                |  12 +-
>  hw/i2c/aspeed_i2c.c              |  16 +--
>  hw/i2c/core.c                    |  88 ++++++------
>  hw/i2c/i2c_mux_pca954x.c         |   6 +-
>  hw/i2c/imx_i2c.c                 |   2 +-
>  hw/i2c/smbus_slave.c             |  12 +-
>  hw/input/lm832x.c                |  14 +-
>  hw/misc/axp2xx.c                 |  14 +-
>  hw/misc/i2c-echo.c               |  14 +-
>  hw/nvram/eeprom_at24c.c          |  22 +--
>  hw/ppc/e500.c                    |   2 +-
>  hw/ppc/pnv.c                     |   4 +-
>  hw/ppc/sam460ex.c                |   2 +-
>  hw/rtc/ds1338.c                  |  14 +-
>  hw/rtc/m41t80.c                  |  12 +-
>  hw/rtc/twl92230.c                |  16 +--
>  hw/sensor/dps310.c               |  14 +-
>  hw/sensor/emc141x.c              |  16 +--
>  hw/sensor/lsm303dlhc_mag.c       |  16 +--
>  hw/sensor/tmp105.c               |  16 +--
>  hw/sensor/tmp421.c               |  20 +--
>  hw/tpm/tpm_tis_i2c.c             |  12 +-
>  55 files changed, 461 insertions(+), 461 deletions(-)
> 
> diff --git a/include/hw/display/i2c-ddc.h b/include/hw/display/i2c-
> ddc.h
> index 94b5880587..faf3cd84fa 100644
> --- a/include/hw/display/i2c-ddc.h
> +++ b/include/hw/display/i2c-ddc.h
> @@ -26,7 +26,7 @@
>  /* A simple I2C slave which just returns the contents of its EDID
> blob. */
>  struct I2CDDCState {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>      bool firstbyte;
>      uint8_t reg;
> diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
> index c36525f0c3..d7f07a44e0 100644
> --- a/include/hw/gpio/pca9552.h
> +++ b/include/hw/gpio/pca9552.h
> @@ -23,7 +23,7 @@ DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,
>  
>  struct PCA955xState {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>  
>      uint8_t len;
> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
> index 54bfc4c4c7..0b528a0033 100644
> --- a/include/hw/gpio/pca9554.h
> +++ b/include/hw/gpio/pca9554.h
> @@ -21,7 +21,7 @@ DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
>  
>  struct PCA9554State {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>  
>      uint8_t len;
> diff --git a/include/hw/i2c/aspeed_i2c.h
> b/include/hw/i2c/aspeed_i2c.h
> index a064479e59..d8fd179a69 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -236,7 +236,7 @@ struct AspeedI2CBus {
>      struct AspeedI2CState *controller;
>  
>      /* slave mode */
> -    I2CSlave *slave;
> +    I2CTarget *slave;
>  
>      MemoryRegion mr;
>  
> @@ -267,7 +267,7 @@ struct AspeedI2CState {
>  #define TYPE_ASPEED_I2C_BUS_SLAVE "aspeed.i2c.slave"
>  OBJECT_DECLARE_SIMPLE_TYPE(AspeedI2CBusSlave, ASPEED_I2C_BUS_SLAVE)
>  struct AspeedI2CBusSlave {
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>  };
>  
>  struct AspeedI2CClass {
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index a1b3f4d179..75c8154138 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -21,34 +21,34 @@ enum i2c_event {
>  
>  typedef struct I2CNodeList I2CNodeList;
>  
> -#define TYPE_I2C_SLAVE "i2c-slave"
> -OBJECT_DECLARE_TYPE(I2CSlave, I2CSlaveClass,
> -                    I2C_SLAVE)
> +#define TYPE_I2C_TARGET "i2c-target"
> +OBJECT_DECLARE_TYPE(I2CTarget, I2CTargetClass,
> +                    I2C_TARGET)
>  
> -struct I2CSlaveClass {
> +struct I2CTargetClass {
>      DeviceClass parent_class;
>  
>      /* Master to slave. Returns non-zero for a NAK, 0 for success.
> */
> -    int (*send)(I2CSlave *s, uint8_t data);
> +    int (*send)(I2CTarget *s, uint8_t data);
>  
>      /*
>       * Master to slave (asynchronous).
>       * Receiving slave must call i2c_ack().
>       */
> -    void (*send_async)(I2CSlave *s, uint8_t data);
> +    void (*send_async)(I2CTarget *s, uint8_t data);
>  
>      /*
>       * Slave to master.  This cannot fail, the device should always
>       * return something here.
>       */
> -    uint8_t (*recv)(I2CSlave *s);
> +    uint8_t (*recv)(I2CTarget *s);
>  
>      /*
>       * Notify the slave of a bus state change.  For start event,
>       * returns non-zero to NAK an operation.  For other events the
>       * return code is not used and should be zero.
>       */
> -    int (*event)(I2CSlave *s, enum i2c_event event);
> +    int (*event)(I2CTarget *s, enum i2c_event event);
>  
>      /*
>       * Check if this device matches the address provided.  Returns
> bool of
> @@ -57,11 +57,11 @@ struct I2CSlaveClass {
>       *
>       * If broadcast is true, match should add the device and return
> true.
>       */
> -    bool (*match_and_add)(I2CSlave *candidate, uint8_t address, bool
> broadcast,
> +    bool (*match_and_add)(I2CTarget *candidate, uint8_t address,
> bool broadcast,
>                            I2CNodeList *current_devs);
>  };
>  
> -struct I2CSlave {
> +struct I2CTarget {
>      DeviceState qdev;
>  
>      /* Remaining fields for internal use by the I2C code.  */
> @@ -74,25 +74,25 @@ OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
>  typedef struct I2CNode I2CNode;
>  
>  struct I2CNode {
> -    I2CSlave *elt;
> +    I2CTarget *elt;
>      QLIST_ENTRY(I2CNode) next;
>  };
>  
> -typedef struct I2CPendingMaster I2CPendingMaster;
> +typedef struct I2CPendingController I2CPendingController;
>  
> -struct I2CPendingMaster {
> +struct I2CPendingController {
>      QEMUBH *bh;
> -    QSIMPLEQ_ENTRY(I2CPendingMaster) entry;
> +    QSIMPLEQ_ENTRY(I2CPendingController) entry;
>  };
>  
>  typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;
> -typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster)
> -            I2CPendingMasters;
> +typedef QSIMPLEQ_HEAD(I2CPendingControllers, I2CPendingController)
> +            I2CPendingControllers;
>  
>  struct I2CBus {
>      BusState qbus;
>      I2CNodeList current_devs;
> -    I2CPendingMasters pending_masters;
> +    I2CPendingControllers pending_controllers;
>      uint8_t saved_address;
>      bool broadcast;
>  
> @@ -147,12 +147,12 @@ int i2c_start_send(I2CBus *bus, uint8_t
> address);
>   */
>  int i2c_start_send_async(I2CBus *bus, uint8_t address);
>  
> -void i2c_schedule_pending_master(I2CBus *bus);
> +void i2c_schedule_pending_controller(I2CBus *bus);
>  
>  void i2c_end_transfer(I2CBus *bus);
>  void i2c_nack(I2CBus *bus);
>  void i2c_ack(I2CBus *bus);
> -void i2c_bus_master(I2CBus *bus, QEMUBH *bh);
> +void i2c_bus_controller(I2CBus *bus, QEMUBH *bh);
>  void i2c_bus_release(I2CBus *bus);
>  int i2c_send(I2CBus *bus, uint8_t data);
>  int i2c_send_async(I2CBus *bus, uint8_t data);
> @@ -169,7 +169,7 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address,
> bool broadcast,
>   * properties to be set. Type @name must exist. The device still
>   * needs to be realized. See qdev-core.h.
>   */
> -I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
> +I2CTarget *i2c_target_new(const char *name, uint8_t addr);
>  
>  /**
>   * Create and realize an I2C slave device on the heap.
> @@ -180,8 +180,8 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t
> addr);
>   * Create the device state structure, initialize it, put it on the
>   * specified @bus, and drop the reference to it (the device is
> realized).
>   */
> -I2CSlave *i2c_slave_create_simple(I2CBus *bus,
> -                                  const char *name, uint8_t addr);
> +I2CTarget *i2c_target_create_simple(I2CBus *bus,
> +                                    const char *name, uint8_t addr);
>  
>  /**
>   * Realize and drop a reference an I2C slave device
> @@ -196,10 +196,10 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus,
>   * reference to it.
>   *
>   * This function is useful if you have created @dev via qdev_new(),
> - * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
> + * i2c_target_new() or i2c_slave_try_new() (which take a reference
> to
>   * the device it returns to you), so that you can set properties on
> it
>   * before realizing it. If you don't need to set properties then
> - * i2c_slave_create_simple() is probably better (as it does the
> create,
> + * i2c_target_create_simple() is probably better (as it does the
> create,
>   * init and realize in one step).
>   *
>   * If you are embedding the I2C slave into another QOM device and
> @@ -211,23 +211,23 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus,
>   * which doesn't currently exist but would be trivial to create if
> we
>   * had any code that wanted it.)
>   */
> -bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error
> **errp);
> +bool i2c_target_realize_and_unref(I2CTarget *dev, I2CBus *bus, Error
> **errp);
>  
>  /**
>   * Set the I2C bus address of a slave device
>   * @dev: I2C slave device
>   * @address: I2C address of the slave when put on a bus
>   */
> -void i2c_slave_set_address(I2CSlave *dev, uint8_t address);
> +void i2c_target_set_address(I2CTarget *dev, uint8_t address);
>  
> -extern const VMStateDescription vmstate_i2c_slave;
> +extern const VMStateDescription vmstate_i2c_target;
>  
> -#define VMSTATE_I2C_SLAVE(_field, _state)
> {                          \
> -    .name       =
> (stringify(_field)),                               \
> -    .size       =
> sizeof(I2CSlave),                                  \
> -    .vmsd       =
> &vmstate_i2c_slave,                                \
> -    .flags      =
> VMS_STRUCT,                                        \
> -    .offset     = vmstate_offset_value(_state, _field,
> I2CSlave),    \
> +#define VMSTATE_I2C_TARGET(_field, _state)
> {                          \
> +    .name       =
> (stringify(_field)),                                \
> +    .size       =
> sizeof(I2CTarget),                                  \
> +    .vmsd       =
> &vmstate_i2c_target,                                \
> +    .flags      =
> VMS_STRUCT,                                         \
> +    .offset     = vmstate_offset_value(_state, _field,
> I2CTarget),    \
>  }
>  
>  #endif
> diff --git a/include/hw/i2c/i2c_mux_pca954x.h
> b/include/hw/i2c/i2c_mux_pca954x.h
> index 3dd25ec983..89f6179dd2 100644
> --- a/include/hw/i2c/i2c_mux_pca954x.h
> +++ b/include/hw/i2c/i2c_mux_pca954x.h
> @@ -14,6 +14,6 @@
>   *
>   * Returns: a pointer to the associated i2c bus.
>   */
> -I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel);
> +I2CBus *pca954x_i2c_get_bus(I2CTarget *mux, uint8_t channel);
>  
>  #endif
> diff --git a/include/hw/i2c/smbus_slave.h
> b/include/hw/i2c/smbus_slave.h
> index 86bfe0a79e..04f4dc4f22 100644
> --- a/include/hw/i2c/smbus_slave.h
> +++ b/include/hw/i2c/smbus_slave.h
> @@ -34,7 +34,7 @@ OBJECT_DECLARE_TYPE(SMBusDevice, SMBusDeviceClass,
>  
>  
>  struct SMBusDeviceClass {
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>  
>      /*
>       * An operation with no data, special in SMBus.
> @@ -68,7 +68,7 @@ struct SMBusDeviceClass {
>  
>  struct SMBusDevice {
>      /* The SMBus protocol is implemented on top of I2C.  */
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>  
>      /* Remaining fields for internal use only.  */
>      int32_t mode;
> diff --git a/include/hw/nvram/eeprom_at24c.h
> b/include/hw/nvram/eeprom_at24c.h
> index 9d29f0a69a..caf06e52c7 100644
> --- a/include/hw/nvram/eeprom_at24c.h
> +++ b/include/hw/nvram/eeprom_at24c.h
> @@ -18,7 +18,7 @@
>   * Create the device state structure, initialize it, put it on the
> specified
>   * @bus, and drop the reference to it (the device is realized).
>   */
> -I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t
> rom_size);
> +I2CTarget *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t
> rom_size);
>  
>  
>  /*
> @@ -33,7 +33,7 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t
> address, uint32_t rom_size);
>   * @bus, and drop the reference to it (the device is realized).
> Copies the data
>   * from @init_rom to the beginning of the EEPROM memory buffer.
>   */
> -I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,
> +I2CTarget *at24c_eeprom_init_rom(I2CBus *bus,
>                                  uint8_t address, uint32_t rom_size,
>                                  const uint8_t *init_rom,
>                                  uint32_t init_rom_size);
> diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h
> index 244e2989fe..6034671fc4 100644
> --- a/include/hw/sensor/tmp105.h
> +++ b/include/hw/sensor/tmp105.h
> @@ -30,7 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
>   */
>  struct TMP105State {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>  
>      uint8_t len;
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 8279ad748a..d95d310b1a 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -459,13 +459,13 @@ static void
> palmetto_bmc_i2c_init(AspeedMachineState *bmc)
>  
>      /* The palmetto platform expects a ds3231 RTC but a ds1338 is
>       * enough to provide basic RTC features. Alarms will be missing
> */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0),
> "ds1338", 0x68);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0),
> "ds1338", 0x68);
>  
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                            eeprom_buf);
>  
>      /* add a TMP423 temperature sensor */
> -    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 2),
> +    dev = DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 2),
>                                           "tmp423", 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000,
> &error_abort);
> @@ -481,21 +481,21 @@ static void
> quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
>       * The quanta-q71l platform expects tmp75s which are compatible
> with
>       * tmp105s.
>       */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4e);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4c);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4e);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4f);
>  
>      /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
>      /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
>      /* TODO: Add Memory Riser i2c mux and eeproms. */
>  
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9546", 0x74);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9548", 0x77);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9546", 0x74);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9548", 0x77);
>  
>      /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
>  
>      /* i2c-7 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> "pca9546", 0x70);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> "pca9546", 0x70);
>      /*        - i2c@0: pmbus@59 */
>      /*        - i2c@1: pmbus@58 */
>      /*        - i2c@2: pmbus@58 */
> @@ -514,7 +514,7 @@ static void
> ast2500_evb_i2c_init(AspeedMachineState *bmc)
>                            eeprom_buf);
>  
>      /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                       TYPE_TMP105, 0x4d);
>  }
>  
> @@ -527,7 +527,7 @@ static void
> ast2600_evb_i2c_init(AspeedMachineState *bmc)
>                            eeprom_buf);
>  
>      /* LM75 is compatible with TMP105 driver */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
>                       TYPE_TMP105, 0x4d);
>  }
>  
> @@ -539,9 +539,9 @@ static void
> yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
>      at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
> 128 * KiB,
>                            yosemitev2_bmc_fruid,
> yosemitev2_bmc_fruid_len);
>      /* TMP421 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> "tmp421", 0x1f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> "tmp421", 0x4e);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> "tmp421", 0x4f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> "tmp421", 0x1f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> "tmp421", 0x4e);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> "tmp421", 0x4f);
>  
>  }
>  
> @@ -551,7 +551,7 @@ static void
> romulus_bmc_i2c_init(AspeedMachineState *bmc)
>  
>      /* The romulus board expects Epson RX8900 I2C RTC but a ds1338
> is
>       * good enough */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> "ds1338", 0x32);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> "ds1338", 0x32);
>  }
>  
>  static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
> @@ -562,14 +562,14 @@ static void
> tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
>      at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 6), 0x54,
> 128 * KiB,
>                            tiogapass_bmc_fruid,
> tiogapass_bmc_fruid_len);
>      /* TMP421 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> "tmp421", 0x1f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> "tmp421", 0x4f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> "tmp421", 0x4e);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> "tmp421", 0x1f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> "tmp421", 0x4f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> "tmp421", 0x4e);
>  }
>  
>  static void create_pca9552(AspeedSoCState *soc, int bus_id, int
> addr)
>  {
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
>                              TYPE_PCA9552, addr);
>  }
>  
> @@ -578,8 +578,8 @@ static void
> sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
>      AspeedSoCState *soc = bmc->soc;
>  
>      /* bus 2 : */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "tmp105", 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "tmp105", 0x49);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "tmp105", 0x48);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "tmp105", 0x49);
>      /* bus 2 : pca9546 @ 0x73 */
>  
>      /* bus 3 : pca9548 @ 0x70 */
> @@ -594,8 +594,8 @@ static void
> sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
>      create_pca9552(soc, 4, 0x77);
>  
>      /* bus 6 : */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> "tmp105", 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> "tmp105", 0x49);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> "tmp105", 0x48);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> "tmp105", 0x49);
>      /* bus 6 : pca9546 @ 0x73 */
>  
>      /* bus 8 : */
> @@ -635,9 +635,9 @@ static void
> witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>      LEDState *led;
>  
>      /* Bus 3: TODO bmp280@77 */
> -    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
> +    dev = DEVICE(i2c_target_new(TYPE_PCA9552, 0x60));
>      qdev_prop_set_string(dev, "description", "pca1");
> -    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
> +    i2c_target_realize_and_unref(I2C_SLAVE(dev),
>                                  aspeed_i2c_get_bus(&soc->i2c, 3),
>                                  &error_fatal);
>  
> @@ -649,29 +649,29 @@ static void
> witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>          qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
>                                qdev_get_gpio_in(DEVICE(led), 0));
>      }
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>                              "dps310", 0x76);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>                              "max31785", 0x52);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>                              "tmp423", 0x4c);
>  
>      /* The Witherspoon expects a TMP275 but a TMP105 is compatible
> */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              TYPE_TMP105, 0x4a);
>  
>      /* The witherspoon board expects Epson RX8900 I2C RTC but a
> ds1338 is
>       * good enough */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>                              "ds1338", 0x32);
>  
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                            eeprom_buf);
> -    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
> +    dev = DEVICE(i2c_target_new(TYPE_PCA9552, 0x60));
>      qdev_prop_set_string(dev, "description", "pca0");
> -    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
> +    i2c_target_realize_and_unref(I2C_SLAVE(dev),
>                                  aspeed_i2c_get_bus(&soc->i2c, 11),
>                                  &error_fatal);
>      /* Bus 11: TODO ucd90160@64 */
> @@ -682,19 +682,19 @@ static void
> g220a_bmc_i2c_init(AspeedMachineState *bmc)
>      AspeedSoCState *soc = bmc->soc;
>      DeviceState *dev;
>  
> -    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 3),
> +    dev = DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 3),
>                                           "emc1413", 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature2", 20000,
> &error_abort);
>  
> -    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 12),
> +    dev = DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 12),
>                                           "emc1413", 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature2", 20000,
> &error_abort);
>  
> -    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 13),
> +    dev = DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 13),
>                                           "emc1413", 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000,
> &error_abort);
> @@ -716,25 +716,25 @@ static void
> g220a_bmc_i2c_init(AspeedMachineState *bmc)
>  static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = bmc->soc;
> -    I2CSlave *i2c_mux;
> +    I2CTarget *i2c_mux;
>  
>      /* The at24c256 */
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x50,
> 32768);
>  
>      /* The fp5280g2 expects a TMP112 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
>                              TYPE_TMP105, 0x49);
>  
> -    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,
> 2),
> +    i2c_mux = i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 
> 2),
>                       "pca9546", 0x70);
>      /* It expects a TMP112 but a TMP105 is compatible */
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
>                              TYPE_TMP105, 0x4a);
>  
>      /* It expects a ds3232 but a ds1338 is good enough */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              "ds1338", 0x68);
>  
>      /* It expects a pca9555 but a pca9552 is compatible */
> @@ -744,44 +744,44 @@ static void
> fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
>  static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = bmc->soc;
> -    I2CSlave *i2c_mux;
> +    I2CTarget *i2c_mux;
>  
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 *
> KiB);
>  
>      create_pca9552(soc, 3, 0x61);
>  
>      /* The rainier expects a TMP275 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              TYPE_TMP105, 0x49);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              TYPE_TMP105, 0x4a);
> -    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,
> 4),
> +    i2c_mux = i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 
> 4),
>                                        "pca9546", 0x70);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 *
> KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 *
> KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 *
> KiB);
>      create_pca9552(soc, 4, 0x60);
>  
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>                              TYPE_TMP105, 0x49);
>      create_pca9552(soc, 5, 0x60);
>      create_pca9552(soc, 5, 0x61);
> -    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,
> 5),
> +    i2c_mux = i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 
> 5),
>                                        "pca9546", 0x70);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 *
> KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 *
> KiB);
>  
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
>                              TYPE_TMP105, 0x4a);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
>                              TYPE_TMP105, 0x4b);
> -    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,
> 6),
> +    i2c_mux = i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 
> 6),
>                                        "pca9546", 0x70);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 *
> KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 *
> KiB);
> @@ -794,19 +794,19 @@ static void
> rainier_bmc_i2c_init(AspeedMachineState *bmc)
>      create_pca9552(soc, 7, 0x33);
>      create_pca9552(soc, 7, 0x60);
>      create_pca9552(soc, 7, 0x61);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                              "dps310", 0x76);
>      /* Bus 7: TODO si7021-a20@20 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                              "max31785", 0x52);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 *
> KiB);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 *
> KiB);
>  
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
>                              TYPE_TMP105, 0x4a);
>      at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
>                            64 * KiB, rainier_bb_fruid,
> rainier_bb_fruid_len);
> @@ -818,23 +818,23 @@ static void
> rainier_bmc_i2c_init(AspeedMachineState *bmc)
>      /* Bus 8: ucd90320@b */
>      /* Bus 8: ucd90320@c */
>  
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              "tmp423", 0x4d);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 *
> KiB);
>  
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
>                              "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
>                              "tmp423", 0x4d);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 *
> KiB);
>  
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>                              TYPE_TMP105, 0x49);
> -    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,
> 11),
> +    i2c_mux = i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 
> 11),
>                                        "pca9546", 0x70);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 *
> KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 *
> KiB);
> @@ -854,7 +854,7 @@ static void
> rainier_bmc_i2c_init(AspeedMachineState *bmc)
>  static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
>                                   I2CBus **channels)
>  {
> -    I2CSlave *mux = i2c_slave_create_simple(bus, "pca9548",
> mux_addr);
> +    I2CTarget *mux = i2c_target_create_simple(bus, "pca9548",
> mux_addr);
>      for (int i = 0; i < 8; i++) {
>          channels[i] = pca954x_i2c_get_bus(mux, i);
>      }
> @@ -888,8 +888,8 @@ static void fuji_bmc_i2c_init(AspeedMachineState
> *bmc)
>          get_pca9548_channels(i2c[40 + i], 0x76, &i2c[80 + i * 8]);
>      }
>  
> -    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4c);
> -    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4d);
> +    i2c_target_create_simple(i2c[17], TYPE_LM75, 0x4c);
> +    i2c_target_create_simple(i2c[17], TYPE_LM75, 0x4d);
>  
>      /*
>       * EEPROM 24c64 size is 64Kbits or 8 Kbytes
> @@ -899,33 +899,33 @@ static void
> fuji_bmc_i2c_init(AspeedMachineState *bmc)
>      at24c_eeprom_init(i2c[20], 0x50, 256);
>      at24c_eeprom_init(i2c[22], 0x52, 256);
>  
> -    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x48);
> -    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x49);
> -    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x4a);
> -    i2c_slave_create_simple(i2c[3], TYPE_TMP422, 0x4c);
> +    i2c_target_create_simple(i2c[3], TYPE_LM75, 0x48);
> +    i2c_target_create_simple(i2c[3], TYPE_LM75, 0x49);
> +    i2c_target_create_simple(i2c[3], TYPE_LM75, 0x4a);
> +    i2c_target_create_simple(i2c[3], TYPE_TMP422, 0x4c);
>  
>      at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);
> -    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x4a);
> +    i2c_target_create_simple(i2c[8], TYPE_LM75, 0x4a);
>  
> -    i2c_slave_create_simple(i2c[50], TYPE_LM75, 0x4c);
> +    i2c_target_create_simple(i2c[50], TYPE_LM75, 0x4c);
>      at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);
> -    i2c_slave_create_simple(i2c[51], TYPE_TMP75, 0x48);
> -    i2c_slave_create_simple(i2c[52], TYPE_TMP75, 0x49);
> +    i2c_target_create_simple(i2c[51], TYPE_TMP75, 0x48);
> +    i2c_target_create_simple(i2c[52], TYPE_TMP75, 0x49);
>  
> -    i2c_slave_create_simple(i2c[59], TYPE_TMP75, 0x48);
> -    i2c_slave_create_simple(i2c[60], TYPE_TMP75, 0x49);
> +    i2c_target_create_simple(i2c[59], TYPE_TMP75, 0x48);
> +    i2c_target_create_simple(i2c[60], TYPE_TMP75, 0x49);
>  
>      at24c_eeprom_init(i2c[65], 0x53, 8 * KiB);
> -    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x49);
> -    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x48);
> +    i2c_target_create_simple(i2c[66], TYPE_TMP75, 0x49);
> +    i2c_target_create_simple(i2c[66], TYPE_TMP75, 0x48);
>      at24c_eeprom_init(i2c[68], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[69], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[70], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[71], 0x52, 8 * KiB);
>  
>      at24c_eeprom_init(i2c[73], 0x53, 8 * KiB);
> -    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x49);
> -    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x48);
> +    i2c_target_create_simple(i2c[74], TYPE_TMP75, 0x49);
> +    i2c_target_create_simple(i2c[74], TYPE_TMP75, 0x48);
>      at24c_eeprom_init(i2c[76], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[77], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[78], 0x52, 8 * KiB);
> @@ -934,9 +934,9 @@ static void fuji_bmc_i2c_init(AspeedMachineState
> *bmc)
>  
>      for (int i = 0; i < 8; i++) {
>          at24c_eeprom_init(i2c[81 + i * 8], 0x56, 64 * KiB);
> -        i2c_slave_create_simple(i2c[82 + i * 8], TYPE_TMP75, 0x48);
> -        i2c_slave_create_simple(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
> -        i2c_slave_create_simple(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
> +        i2c_target_create_simple(i2c[82 + i * 8], TYPE_TMP75, 0x48);
> +        i2c_target_create_simple(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
> +        i2c_target_create_simple(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
>      }
>  }
>  
> @@ -957,35 +957,35 @@ static void
> bletchley_bmc_i2c_init(AspeedMachineState *bmc)
>      for (int i = 0; i < 6; i++) {
>          /* Missing model: ti,ina230 @ 0x45 */
>          /* Missing model: mps,mp5023 @ 0x40 */
> -        i2c_slave_create_simple(i2c[i], TYPE_TMP421, 0x4f);
> +        i2c_target_create_simple(i2c[i], TYPE_TMP421, 0x4f);
>          /* Missing model: nxp,pca9539 @ 0x76, but PCA9552 works
> enough */
> -        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x76);
> -        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x67);
> +        i2c_target_create_simple(i2c[i], TYPE_PCA9552, 0x76);
> +        i2c_target_create_simple(i2c[i], TYPE_PCA9552, 0x67);
>          /* Missing model: fsc,fusb302 @ 0x22 */
>      }
>  
>      /* Bus 6 */
>      at24c_eeprom_init(i2c[6], 0x56, 65536);
>      /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough
> */
> -    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
> +    i2c_target_create_simple(i2c[6], "ds1338", 0x51);
>  
>  
>      /* Bus 7 */
>      at24c_eeprom_init(i2c[7], 0x54, 65536);
>  
>      /* Bus 9 */
> -    i2c_slave_create_simple(i2c[9], TYPE_TMP421, 0x4f);
> +    i2c_target_create_simple(i2c[9], TYPE_TMP421, 0x4f);
>  
>      /* Bus 10 */
> -    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x4f);
> +    i2c_target_create_simple(i2c[10], TYPE_TMP421, 0x4f);
>      /* Missing model: ti,hdc1080 @ 0x40 */
> -    i2c_slave_create_simple(i2c[10], TYPE_PCA9552, 0x67);
> +    i2c_target_create_simple(i2c[10], TYPE_PCA9552, 0x67);
>  
>      /* Bus 12 */
>      /* Missing model: adi,adm1278 @ 0x11 */
> -    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4c);
> -    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4d);
> -    i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
> +    i2c_target_create_simple(i2c[12], TYPE_TMP421, 0x4c);
> +    i2c_target_create_simple(i2c[12], TYPE_TMP421, 0x4d);
> +    i2c_target_create_simple(i2c[12], TYPE_PCA9552, 0x67);
>  }
>  
>  static void fby35_i2c_init(AspeedMachineState *bmc)
> @@ -997,12 +997,12 @@ static void fby35_i2c_init(AspeedMachineState
> *bmc)
>          i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
>      }
>  
> -    i2c_slave_create_simple(i2c[2], TYPE_LM75, 0x4f);
> -    i2c_slave_create_simple(i2c[8], TYPE_TMP421, 0x1f);
> +    i2c_target_create_simple(i2c[2], TYPE_LM75, 0x4f);
> +    i2c_target_create_simple(i2c[8], TYPE_TMP421, 0x1f);
>      /* Hotswap controller is actually supposed to be mp5920 or
> ltc4282. */
> -    i2c_slave_create_simple(i2c[11], "adm1272", 0x44);
> -    i2c_slave_create_simple(i2c[12], TYPE_LM75, 0x4e);
> -    i2c_slave_create_simple(i2c[12], TYPE_LM75, 0x4f);
> +    i2c_target_create_simple(i2c[11], "adm1272", 0x44);
> +    i2c_target_create_simple(i2c[12], TYPE_LM75, 0x4e);
> +    i2c_target_create_simple(i2c[12], TYPE_LM75, 0x4f);
>  
>      at24c_eeprom_init(i2c[4], 0x51, 128 * KiB);
>      at24c_eeprom_init(i2c[6], 0x51, 128 * KiB);
> @@ -1024,14 +1024,14 @@ static void
> qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = bmc->soc;
>  
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15),
>                              "tmp105", 0x4d);
>  }
>  
>  static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = bmc->soc;
> -    I2CSlave *therm_mux, *cpuvr_mux;
> +    I2CTarget *therm_mux, *cpuvr_mux;
>  
>      /* Create the generic DC-SCM hardware */
>      qcom_dc_scm_bmc_i2c_init(bmc);
> @@ -1039,35 +1039,35 @@ static void
> qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
>      /* Now create the Firework specific hardware */
>  
>      /* I2C7 CPUVR MUX */
> -    cpuvr_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 7),
> +    cpuvr_mux = i2c_target_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 7),
>                                          "pca9546", 0x70);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0),
>                              "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1),
>                              "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2),
>                              "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3),
>                              "pca9548", 0x72);
>  
>      /* I2C8 Thermal Diodes*/
> -    therm_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 8),
> +    therm_mux = i2c_target_create_simple(aspeed_i2c_get_bus(&soc-
> >i2c, 8),
>                                          "pca9548", 0x70);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 0),
>                              TYPE_LM75, 0x4C);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 1),
>                              TYPE_LM75, 0x4C);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 2),
>                              TYPE_LM75, 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 3),
>                              TYPE_LM75, 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 4),
>                              TYPE_LM75, 0x48);
>  
>      /* I2C9 Fan Controller (MAX31785) */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              "max31785", 0x52);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              "max31785", 0x54);
>  }
>  
> @@ -1589,7 +1589,7 @@ static void
> ast1030_evb_i2c_init(AspeedMachineState *bmc)
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
> eeprom_buf);
>  
>      /* U11 LM75 connects to SDA/SCL Group 2 by default */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4d);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4d);
>  }
>  
>  static void
> aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> index 0a4b6f29b1..e53ba57d3f 100644
> --- a/hw/arm/bananapi_m2u.c
> +++ b/hw/arm/bananapi_m2u.c
> @@ -113,7 +113,7 @@ static void bpim2u_init(MachineState *machine)
>  
>      /* Connect AXP221 */
>      i2c = I2C_BUS(qdev_get_child_bus(DEVICE(&r40->i2c0), "i2c"));
> -    i2c_slave_create_simple(i2c, "axp221_pmu", 0x34);
> +    i2c_target_create_simple(i2c, "axp221_pmu", 0x34);
>  
>      /* SDRAM */
>      memory_region_add_subregion(get_system_memory(),
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index b976727eef..82a2e2642b 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -80,7 +80,7 @@ static void cubieboard_init(MachineState *machine)
>  
>      /* Connect AXP 209 */
>      i2c = I2C_BUS(qdev_get_child_bus(DEVICE(&a10->i2c0), "i2c"));
> -    i2c_slave_create_simple(i2c, "axp209_pmu", 0x34);
> +    i2c_target_create_simple(i2c, "axp209_pmu", 0x34);
>  
>      /* Retrieve SD bus */
>      di = drive_get(IF_SD, 0, 0);
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 2020f73a57..54e2385d96 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1203,7 +1203,7 @@ static void musicpal_init(MachineState
> *machine)
>      DeviceState *i2c_dev;
>      DeviceState *lcd_dev;
>      DeviceState *key_dev;
> -    I2CSlave *wm8750_dev;
> +    I2CTarget *wm8750_dev;
>      SysBusDevice *s;
>      I2CBus *i2c;
>      int i;
> @@ -1316,11 +1316,11 @@ static void musicpal_init(MachineState
> *machine)
>          qdev_connect_gpio_out(key_dev, i, qdev_get_gpio_in(dev, i +
> 15));
>      }
>  
> -    wm8750_dev = i2c_slave_new(TYPE_WM8750, MP_WM_ADDR);
> +    wm8750_dev = i2c_target_new(TYPE_WM8750, MP_WM_ADDR);
>      if (machine->audiodev) {
>          qdev_prop_set_string(DEVICE(wm8750_dev), "audiodev",
> machine->audiodev);
>      }
> -    i2c_slave_realize_and_unref(wm8750_dev, i2c, &error_abort);
> +    i2c_target_realize_and_unref(wm8750_dev, i2c, &error_abort);
>  
>      dev = qdev_new(TYPE_MV88W8618_AUDIO);
>      s = SYS_BUS_DEVICE(dev);
> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> index e229efb447..27fd8afa66 100644
> --- a/hw/arm/npcm7xx_boards.c
> +++ b/hw/arm/npcm7xx_boards.c
> @@ -197,13 +197,13 @@ static void
> npcm7xx_connect_pwm_fan(NPCM7xxState *soc, SplitIRQ *splitter,
>  static void npcm750_evb_i2c_init(NPCM7xxState *soc)
>  {
>      /* lm75 temperature sensor on SVB, tmp105 is compatible */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 0), "tmp105",
> 0x48);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 0), "tmp105",
> 0x48);
>      /* lm75 temperature sensor on EB, tmp105 is compatible */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105",
> 0x48);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105",
> 0x48);
>      /* tmp100 temperature sensor on EB, tmp105 is compatible */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105",
> 0x48);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105",
> 0x48);
>      /* tmp100 temperature sensor on SVB, tmp105 is compatible */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 6), "tmp105",
> 0x48);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 6), "tmp105",
> 0x48);
>  }
>  
>  static void npcm750_evb_fan_init(NPCM7xxMachine *machine,
> NPCM7xxState *soc)
> @@ -233,10 +233,10 @@ static void npcm750_evb_fan_init(NPCM7xxMachine
> *machine, NPCM7xxState *soc)
>  static void quanta_gsj_i2c_init(NPCM7xxState *soc)
>  {
>      /* GSJ machine have 4 max31725 temperature sensors, tmp105 is
> compatible. */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105",
> 0x5c);
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105",
> 0x5c);
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 3), "tmp105",
> 0x5c);
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4), "tmp105",
> 0x5c);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105",
> 0x5c);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105",
> 0x5c);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 3), "tmp105",
> 0x5c);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 4), "tmp105",
> 0x5c);
>  
>      at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 9), 0x55, 8192);
>      at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 10), 0x55, 8192);
> @@ -252,7 +252,7 @@ static void quanta_gsj_i2c_init(NPCM7xxState
> *soc)
>       * - ucd90160@6b
>       */
>  
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 15), "pca9548",
> 0x75);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 15),
> "pca9548", 0x75);
>  }
>  
>  static void quanta_gsj_fan_init(NPCM7xxMachine *machine,
> NPCM7xxState *soc)
> @@ -330,31 +330,31 @@ static void quanta_gbs_i2c_init(NPCM7xxState
> *soc)
>  
>  static void kudo_bmc_i2c_init(NPCM7xxState *soc)
>  {
> -    I2CSlave *i2c_mux;
> +    I2CTarget *i2c_mux;
>  
> -    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1),
> +    i2c_mux = i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1),
>                                        TYPE_PCA9548, 0x75);
>  
>      /* tmp105 is compatible with the lm75 */
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4),
> "tmp105", 0x5c);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> "tmp105", 0x5c);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
> "tmp105", 0x5c);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7),
> "tmp105", 0x5c);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 4),
> "tmp105", 0x5c);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> "tmp105", 0x5c);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
> "tmp105", 0x5c);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 7),
> "tmp105", 0x5c);
>  
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1),
> TYPE_PCA9548, 0x77);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1),
> TYPE_PCA9548, 0x77);
>  
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4),
> TYPE_PCA9548, 0x77);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 4),
> TYPE_PCA9548, 0x77);
>  
>      at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192); /*
> mbfru */
>  
> -    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 13),
> +    i2c_mux = i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 13),
>                                        TYPE_PCA9548, 0x77);
>  
>      /* tmp105 is compatible with the lm75 */
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
> "tmp105", 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3),
> "tmp105", 0x49);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4),
> "tmp105", 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> "tmp105", 0x49);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
> "tmp105", 0x48);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 3),
> "tmp105", 0x49);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 4),
> "tmp105", 0x48);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> "tmp105", 0x49);
>  
>      at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192); /*
> bmcfru */
>  
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index 35364312c7..0f10bb5ade 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -218,7 +218,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
>      I2CBus *i2c = omap_i2c_bus(s->mpu->i2c[0]);
>  
>      /* Attach a menelaus PM chip */
> -    dev = DEVICE(i2c_slave_create_simple(i2c, "twl92230",
> N8X0_MENELAUS_ADDR));
> +    dev = DEVICE(i2c_target_create_simple(i2c, "twl92230",
> N8X0_MENELAUS_ADDR));
>      qdev_connect_gpio_out(dev, 3,
>                            qdev_get_gpio_in(s->mpu->ih[0],
>                                             OMAP_INT_24XX_SYS_NIRQ));
> @@ -227,7 +227,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
>      qemu_register_powerdown_notifier(&n8x0_system_powerdown_notifier
> );
>  
>      /* Attach a TMP105 PM chip (A0 wired to ground) */
> -    dev = DEVICE(i2c_slave_create_simple(i2c, TYPE_TMP105,
> N8X0_TMP105_ADDR));
> +    dev = DEVICE(i2c_target_create_simple(i2c, TYPE_TMP105,
> N8X0_TMP105_ADDR));
>      qdev_connect_gpio_out(dev, 0, tmp_irq);
>  }
>  
> @@ -419,7 +419,7 @@ static void n810_kbd_setup(struct n800_s *s)
>  
>      /* Attach the LM8322 keyboard to the I2C bus,
>       * should happen in n8x0_i2c_setup and s->kbd be initialised
> here.  */
> -    s->kbd = DEVICE(i2c_slave_create_simple(omap_i2c_bus(s->mpu-
> >i2c[0]),
> +    s->kbd = DEVICE(i2c_target_create_simple(omap_i2c_bus(s->mpu-
> >i2c[0]),
>                                              TYPE_LM8323,
> N810_LM8323_ADDR));
>      qdev_connect_gpio_out(s->kbd, 0, kbd_irq);
>  }
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index 6b2e54473b..3b658680ac 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -1243,10 +1243,10 @@ static const TypeInfo pxa2xx_rtc_sysbus_info
> = {
>  /* I2C Interface */
>  
>  #define TYPE_PXA2XX_I2C_SLAVE "pxa2xx-i2c-slave"
> -OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxI2CSlaveState, PXA2XX_I2C_SLAVE)
> +OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxI2CTargetState, PXA2XX_I2C_SLAVE)
>  
> -struct PXA2xxI2CSlaveState {
> -    I2CSlave parent_obj;
> +struct PXA2xxI2CTargetState {
> +    I2CTarget parent_obj;
>  
>      PXA2xxI2CState *host;
>  };
> @@ -1257,7 +1257,7 @@ struct PXA2xxI2CState {
>      /*< public >*/
>  
>      MemoryRegion iomem;
> -    PXA2xxI2CSlaveState *slave;
> +    PXA2xxI2CTargetState *slave;
>      I2CBus *bus;
>      qemu_irq irq;
>      uint32_t offset;
> @@ -1286,9 +1286,9 @@ static void pxa2xx_i2c_update(PXA2xxI2CState
> *s)
>  }
>  
>  /* These are only stubs now.  */
> -static int pxa2xx_i2c_event(I2CSlave *i2c, enum i2c_event event)
> +static int pxa2xx_i2c_event(I2CTarget *i2c, enum i2c_event event)
>  {
> -    PXA2xxI2CSlaveState *slave = PXA2XX_I2C_SLAVE(i2c);
> +    PXA2xxI2CTargetState *slave = PXA2XX_I2C_SLAVE(i2c);
>      PXA2xxI2CState *s = slave->host;
>  
>      switch (event) {
> @@ -1314,9 +1314,9 @@ static int pxa2xx_i2c_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t pxa2xx_i2c_rx(I2CSlave *i2c)
> +static uint8_t pxa2xx_i2c_rx(I2CTarget *i2c)
>  {
> -    PXA2xxI2CSlaveState *slave = PXA2XX_I2C_SLAVE(i2c);
> +    PXA2xxI2CTargetState *slave = PXA2XX_I2C_SLAVE(i2c);
>      PXA2xxI2CState *s = slave->host;
>  
>      if ((s->control & (1 << 14)) || !(s->control & (1 << 6))) {
> @@ -1331,9 +1331,9 @@ static uint8_t pxa2xx_i2c_rx(I2CSlave *i2c)
>      return s->data;
>  }
>  
> -static int pxa2xx_i2c_tx(I2CSlave *i2c, uint8_t data)
> +static int pxa2xx_i2c_tx(I2CTarget *i2c, uint8_t data)
>  {
> -    PXA2xxI2CSlaveState *slave = PXA2XX_I2C_SLAVE(i2c);
> +    PXA2xxI2CTargetState *slave = PXA2XX_I2C_SLAVE(i2c);
>      PXA2xxI2CState *s = slave->host;
>  
>      if ((s->control & (1 << 14)) || !(s->control & (1 << 6))) {
> @@ -1353,7 +1353,7 @@ static uint64_t pxa2xx_i2c_read(void *opaque,
> hwaddr addr,
>                                  unsigned size)
>  {
>      PXA2xxI2CState *s = (PXA2xxI2CState *) opaque;
> -    I2CSlave *slave;
> +    I2CTarget *slave;
>  
>      addr -= s->offset;
>      switch (addr) {
> @@ -1440,7 +1440,7 @@ static void pxa2xx_i2c_write(void *opaque,
> hwaddr addr,
>          break;
>  
>      case ISAR:
> -        i2c_slave_set_address(I2C_SLAVE(s->slave), value & 0x7f);
> +        i2c_target_set_address(I2C_SLAVE(s->slave), value & 0x7f);
>          break;
>  
>      case IDBR:
> @@ -1465,7 +1465,7 @@ static const VMStateDescription
> vmstate_pxa2xx_i2c_slave = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, PXA2xxI2CSlaveState),
> +        VMSTATE_I2C_TARGET(parent_obj, PXA2xxI2CTargetState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -1480,14 +1480,14 @@ static const VMStateDescription
> vmstate_pxa2xx_i2c = {
>          VMSTATE_UINT8(ibmr, PXA2xxI2CState),
>          VMSTATE_UINT8(data, PXA2xxI2CState),
>          VMSTATE_STRUCT_POINTER(slave, PXA2xxI2CState,
> -                               vmstate_pxa2xx_i2c_slave,
> PXA2xxI2CSlaveState),
> +                               vmstate_pxa2xx_i2c_slave,
> PXA2xxI2CTargetState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>  
>  static void pxa2xx_i2c_slave_class_init(ObjectClass *klass, void
> *data)
>  {
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      k->event = pxa2xx_i2c_event;
>      k->recv = pxa2xx_i2c_rx;
> @@ -1496,8 +1496,8 @@ static void
> pxa2xx_i2c_slave_class_init(ObjectClass *klass, void *data)
>  
>  static const TypeInfo pxa2xx_i2c_slave_info = {
>      .name          = TYPE_PXA2XX_I2C_SLAVE,
> -    .parent        = TYPE_I2C_SLAVE,
> -    .instance_size = sizeof(PXA2xxI2CSlaveState),
> +    .parent        = TYPE_I2C_TARGET,
> +    .instance_size = sizeof(PXA2xxI2CTargetState),
>      .class_init    = pxa2xx_i2c_slave_class_init,
>  };
>  
> @@ -1522,7 +1522,7 @@ PXA2xxI2CState *pxa2xx_i2c_init(hwaddr base,
>      sysbus_connect_irq(i2c_dev, 0, irq);
>  
>      s = PXA2XX_I2C(i2c_dev);
> -    s->slave = PXA2XX_I2C_SLAVE(i2c_slave_create_simple(i2cbus,
> +    s->slave = PXA2XX_I2C_SLAVE(i2c_target_create_simple(i2cbus,
>                                                          TYPE_PXA2XX_
> I2C_SLAVE,
>                                                          0));
>      s->slave->host = s;
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index b186f965c6..dc18ce8d23 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -314,7 +314,7 @@ static void realview_init(MachineState *machine,
>  
>      dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000,
> NULL);
>      i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", 0x68);
> +    i2c_target_create_simple(i2c, "ds1338", 0x68);
>  
>      /* Memory map for RealView Emulation Baseboard:  */
>      /* 0x10000000 System registers.  */
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 62cd55ba91..1fe466bab9 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -767,11 +767,11 @@ static void spitz_microdrive_attach(PXA2xxState
> *cpu, int slot)
>  
>  static void spitz_wm8750_addr(void *opaque, int line, int level)
>  {
> -    I2CSlave *wm = (I2CSlave *) opaque;
> +    I2CTarget *wm = (I2CTarget *) opaque;
>      if (level)
> -        i2c_slave_set_address(wm, SPITZ_WM_ADDRH);
> +        i2c_target_set_address(wm, SPITZ_WM_ADDRH);
>      else
> -        i2c_slave_set_address(wm, SPITZ_WM_ADDRL);
> +        i2c_target_set_address(wm, SPITZ_WM_ADDRL);
>  }
>  
>  static void spitz_i2c_setup(MachineState *machine, PXA2xxState *cpu)
> @@ -780,13 +780,13 @@ static void spitz_i2c_setup(MachineState
> *machine, PXA2xxState *cpu)
>      I2CBus *bus = pxa2xx_i2c_bus(cpu->i2c[0]);
>  
>      /* Attach a WM8750 to the bus */
> -    I2CSlave *i2c_dev = i2c_slave_new(TYPE_WM8750, 0);
> +    I2CTarget *i2c_dev = i2c_target_new(TYPE_WM8750, 0);
>      DeviceState *wm = DEVICE(i2c_dev);
>  
>      if (machine->audiodev) {
>          qdev_prop_set_string(wm, "audiodev", machine->audiodev);
>      }
> -    i2c_slave_realize_and_unref(i2c_dev, bus, &error_abort);
> +    i2c_target_realize_and_unref(i2c_dev, bus, &error_abort);
>  
>      spitz_wm8750_addr(wm, 0, 0);
>      qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_WM,
> @@ -801,7 +801,7 @@ static void spitz_i2c_setup(MachineState
> *machine, PXA2xxState *cpu)
>  static void spitz_akita_i2c_setup(PXA2xxState *cpu)
>  {
>      /* Attach a Max7310 to Akita I2C bus.  */
> -    i2c_slave_create_simple(pxa2xx_i2c_bus(cpu->i2c[0]), "max7310",
> +    i2c_target_create_simple(pxa2xx_i2c_bus(cpu->i2c[0]), "max7310",
>                       AKITA_MAX_ADDR);
>  }
>  
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index a2f998bf9e..7246bcc560 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1176,7 +1176,7 @@ static void stellaris_init(MachineState *ms,
> stellaris_board_info *board)
>                                     qdev_get_gpio_in(nvic, 8));
>          i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
>          if (board->peripherals & BP_OLED_I2C) {
> -            i2c_slave_create_simple(i2c, "ssd0303", 0x3d);
> +            i2c_target_create_simple(i2c, "ssd0303", 0x3d);
>          }
>      }
>  
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index 5891f6064f..8529a57ef7 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -163,13 +163,13 @@ static void tosa_ssp_realize(SSIPeripheral
> *dev, Error **errp)
>  OBJECT_DECLARE_SIMPLE_TYPE(TosaDACState, TOSA_DAC)
>  
>  struct TosaDACState {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      int len;
>      char buf[3];
>  };
>  
> -static int tosa_dac_send(I2CSlave *i2c, uint8_t data)
> +static int tosa_dac_send(I2CTarget *i2c, uint8_t data)
>  {
>      TosaDACState *s = TOSA_DAC(i2c);
>  
> @@ -189,7 +189,7 @@ static int tosa_dac_send(I2CSlave *i2c, uint8_t
> data)
>      return 0;
>  }
>  
> -static int tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
> +static int tosa_dac_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      TosaDACState *s = TOSA_DAC(i2c);
>  
> @@ -215,7 +215,7 @@ static int tosa_dac_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t tosa_dac_recv(I2CSlave *s)
> +static uint8_t tosa_dac_recv(I2CTarget *s)
>  {
>      printf("%s: recv not supported!!!\n", __func__);
>      return 0xff;
> @@ -224,7 +224,7 @@ static uint8_t tosa_dac_recv(I2CSlave *s)
>  static void tosa_tg_init(PXA2xxState *cpu)
>  {
>      I2CBus *bus = pxa2xx_i2c_bus(cpu->i2c[0]);
> -    i2c_slave_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);
> +    i2c_target_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);
>      ssi_create_peripheral(cpu->ssp[1], "tosa-ssp");
>  }
>  
> @@ -277,7 +277,7 @@ DEFINE_MACHINE("tosa", tosapda_machine_init)
>  
>  static void tosa_dac_class_init(ObjectClass *klass, void *data)
>  {
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      k->event = tosa_dac_event;
>      k->recv = tosa_dac_recv;
> @@ -286,7 +286,7 @@ static void tosa_dac_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo tosa_dac_info = {
>      .name          = TYPE_TOSA_DAC,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(TosaDACState),
>      .class_init    = tosa_dac_class_init,
>  };
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index d48235453e..73d8047ca8 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -338,7 +338,7 @@ static void versatile_init(MachineState *machine,
> int board_id)
>  
>      dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000,
> NULL);
>      i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", 0x68);
> +    i2c_target_create_simple(i2c, "ds1338", 0x68);
>  
>      /* Add PL041 AACI Interface to the LM4549 codec */
>      pl041 = qdev_new("pl041");
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index de815d84cc..355905e0b7 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -650,7 +650,7 @@ static void vexpress_common_init(MachineState
> *machine)
>  
>      dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C,
> map[VE_SERIALDVI], NULL);
>      i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "sii9022", 0x39);
> +    i2c_target_create_simple(i2c, "sii9022", 0x39);
>  
>      sysbus_create_simple("pl031", map[VE_RTC], pic[4]); /* RTC */
>  
> diff --git a/hw/arm/z2.c b/hw/arm/z2.c
> index fc5672e7ab..24bc303f06 100644
> --- a/hw/arm/z2.c
> +++ b/hw/arm/z2.c
> @@ -192,13 +192,13 @@ static const TypeInfo zipit_lcd_info = {
>  OBJECT_DECLARE_SIMPLE_TYPE(AER915State, AER915)
>  
>  struct AER915State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      int len;
>      uint8_t buf[3];
>  };
>  
> -static int aer915_send(I2CSlave *i2c, uint8_t data)
> +static int aer915_send(I2CTarget *i2c, uint8_t data)
>  {
>      AER915State *s = AER915(i2c);
>  
> @@ -215,7 +215,7 @@ static int aer915_send(I2CSlave *i2c, uint8_t
> data)
>      return 0;
>  }
>  
> -static int aer915_event(I2CSlave *i2c, enum i2c_event event)
> +static int aer915_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      AER915State *s = AER915(i2c);
>  
> @@ -235,7 +235,7 @@ static int aer915_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t aer915_recv(I2CSlave *slave)
> +static uint8_t aer915_recv(I2CTarget *slave)
>  {
>      AER915State *s = AER915(slave);
>      int retval = 0x00;
> @@ -272,7 +272,7 @@ static const VMStateDescription
> vmstate_aer915_state = {
>  static void aer915_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      k->event = aer915_event;
>      k->recv = aer915_recv;
> @@ -282,7 +282,7 @@ static void aer915_class_init(ObjectClass *klass,
> void *data)
>  
>  static const TypeInfo aer915_info = {
>      .name          = TYPE_AER915,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(AER915State),
>      .class_init    = aer915_class_init,
>  };
> @@ -296,7 +296,7 @@ static void z2_init(MachineState *machine)
>      void *z2_lcd;
>      I2CBus *bus;
>      DeviceState *wm;
> -    I2CSlave *i2c_dev;
> +    I2CTarget *i2c_dev;
>  
>      /* Setup CPU & memory */
>      mpu = pxa270_init(z2_binfo.ram_size, machine->cpu_type);
> @@ -319,15 +319,15 @@ static void z2_init(MachineState *machine)
>      z2_lcd = ssi_create_peripheral(mpu->ssp[1], TYPE_ZIPIT_LCD);
>      bus = pxa2xx_i2c_bus(mpu->i2c[0]);
>  
> -    i2c_slave_create_simple(bus, TYPE_AER915, 0x55);
> +    i2c_target_create_simple(bus, TYPE_AER915, 0x55);
>  
> -    i2c_dev = i2c_slave_new(TYPE_WM8750, 0x1b);
> +    i2c_dev = i2c_target_new(TYPE_WM8750, 0x1b);
>      wm = DEVICE(i2c_dev);
>  
>      if (machine->audiodev) {
>          qdev_prop_set_string(wm, "audiodev", machine->audiodev);
>      }
> -    i2c_slave_realize_and_unref(i2c_dev, bus, &error_abort);
> +    i2c_target_realize_and_unref(i2c_dev, bus, &error_abort);
>  
>      mpu->i2s->opaque = wm;
>      mpu->i2s->codec_out = wm8750_dac_dat;
> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
> index ec2c4e1374..6e2da41419 100644
> --- a/hw/audio/wm8750.c
> +++ b/hw/audio/wm8750.c
> @@ -30,7 +30,7 @@ typedef struct {
>  OBJECT_DECLARE_SIMPLE_TYPE(WM8750State, WM8750)
>  
>  struct WM8750State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      uint8_t i2c_data[2];
>      int i2c_len;
> @@ -261,7 +261,7 @@ static void wm8750_clk_update(WM8750State *s, int
> ext)
>      }
>  }
>  
> -static void wm8750_reset(I2CSlave *i2c)
> +static void wm8750_reset(I2CTarget *i2c)
>  {
>      WM8750State *s = WM8750(i2c);
>  
> @@ -305,7 +305,7 @@ static void wm8750_reset(I2CSlave *i2c)
>      s->i2c_len = 0;
>  }
>  
> -static int wm8750_event(I2CSlave *i2c, enum i2c_event event)
> +static int wm8750_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      WM8750State *s = WM8750(i2c);
>  
> @@ -364,7 +364,7 @@ static int wm8750_event(I2CSlave *i2c, enum
> i2c_event event)
>  #define WM8750_ROUT2V	0x29
>  #define WM8750_MOUTV	0x2a
>  
> -static int wm8750_tx(I2CSlave *i2c, uint8_t data)
> +static int wm8750_tx(I2CTarget *i2c, uint8_t data)
>  {
>      WM8750State *s = WM8750(i2c);
>      uint8_t cmd;
> @@ -564,7 +564,7 @@ static int wm8750_tx(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>  
> -static uint8_t wm8750_rx(I2CSlave *i2c)
> +static uint8_t wm8750_rx(I2CTarget *i2c)
>  {
>      return 0x00;
>  }
> @@ -615,7 +615,7 @@ static const VMStateDescription vmstate_wm8750 =
> {
>          VMSTATE_UINT8(format, WM8750State),
>          VMSTATE_UINT8(power, WM8750State),
>          VMSTATE_UINT8(rate_vmstate, WM8750State),
> -        VMSTATE_I2C_SLAVE(parent_obj, WM8750State),
> +        VMSTATE_I2C_TARGET(parent_obj, WM8750State),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -632,7 +632,7 @@ static void wm8750_realize(DeviceState *dev,
> Error **errp)
>  }
>  
>  #if 0
> -static void wm8750_fini(I2CSlave *i2c)
> +static void wm8750_fini(I2CTarget *i2c)
>  {
>      WM8750State *s = WM8750(i2c);
>  
> @@ -714,7 +714,7 @@ static Property wm8750_properties[] = {
>  static void wm8750_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc = I2C_TARGET_CLASS(klass);
>  
>      dc->realize = wm8750_realize;
>      sc->event = wm8750_event;
> @@ -726,7 +726,7 @@ static void wm8750_class_init(ObjectClass *klass,
> void *data)
>  
>  static const TypeInfo wm8750_info = {
>      .name          = TYPE_WM8750,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(WM8750State),
>      .class_init    = wm8750_class_init,
>  };
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 8d2501bd82..3341ef7800 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1000,8 +1000,8 @@ static void ati_vga_realize(PCIDevice *dev,
> Error **errp)
>      /* ddc, edid */
>      I2CBus *i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
>      bitbang_i2c_init(&s->bbi2c, i2cbus);
> -    I2CSlave *i2cddc = I2C_SLAVE(qdev_new(TYPE_I2CDDC));
> -    i2c_slave_set_address(i2cddc, 0x50);
> +    I2CTarget *i2cddc = I2C_SLAVE(qdev_new(TYPE_I2CDDC));
> +    i2c_target_set_address(i2cddc, 0x50);
>      qdev_realize_and_unref(DEVICE(i2cddc), BUS(i2cbus),
> &error_abort);
>  
>      /* mmio register space */
> diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
> index 3f9d1e1f6f..66107b5b31 100644
> --- a/hw/display/i2c-ddc.c
> +++ b/hw/display/i2c-ddc.c
> @@ -42,7 +42,7 @@ static void i2c_ddc_reset(DeviceState *ds)
>      s->reg = 0;
>  }
>  
> -static int i2c_ddc_event(I2CSlave *i2c, enum i2c_event event)
> +static int i2c_ddc_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      I2CDDCState *s = I2CDDC(i2c);
>  
> @@ -53,7 +53,7 @@ static int i2c_ddc_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t i2c_ddc_rx(I2CSlave *i2c)
> +static uint8_t i2c_ddc_rx(I2CTarget *i2c)
>  {
>      I2CDDCState *s = I2CDDC(i2c);
>  
> @@ -63,7 +63,7 @@ static uint8_t i2c_ddc_rx(I2CSlave *i2c)
>      return value;
>  }
>  
> -static int i2c_ddc_tx(I2CSlave *i2c, uint8_t data)
> +static int i2c_ddc_tx(I2CTarget *i2c, uint8_t data)
>  {
>      I2CDDCState *s = I2CDDC(i2c);
>      if (s->firstbyte) {
> @@ -103,7 +103,7 @@ static Property i2c_ddc_properties[] = {
>  static void i2c_ddc_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> -    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
> +    I2CTargetClass *isc = I2C_TARGET_CLASS(oc);
>  
>      dc->reset = i2c_ddc_reset;
>      dc->vmsd = &vmstate_i2c_ddc;
> @@ -115,7 +115,7 @@ static void i2c_ddc_class_init(ObjectClass *oc,
> void *data)
>  
>  static const TypeInfo i2c_ddc_info = {
>      .name = TYPE_I2CDDC,
> -    .parent = TYPE_I2C_SLAVE,
> +    .parent = TYPE_I2C_TARGET,
>      .instance_size = sizeof(I2CDDCState),
>      .instance_init = i2c_ddc_init,
>      .class_init = i2c_ddc_class_init
> diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
> index 60c3f78549..095fd862dd 100644
> --- a/hw/display/sii9022.c
> +++ b/hw/display/sii9022.c
> @@ -39,7 +39,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(sii9022_state, SII9022)
>  
>  struct sii9022_state {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>      uint8_t ptr;
>      bool addr_byte;
>      bool ddc_req;
> @@ -52,7 +52,7 @@ static const VMStateDescription vmstate_sii9022 = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, sii9022_state),
> +        VMSTATE_I2C_TARGET(parent_obj, sii9022_state),
>          VMSTATE_UINT8(ptr, sii9022_state),
>          VMSTATE_BOOL(addr_byte, sii9022_state),
>          VMSTATE_BOOL(ddc_req, sii9022_state),
> @@ -62,7 +62,7 @@ static const VMStateDescription vmstate_sii9022 = {
>      }
>  };
>  
> -static int sii9022_event(I2CSlave *i2c, enum i2c_event event)
> +static int sii9022_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      sii9022_state *s = SII9022(i2c);
>  
> @@ -83,7 +83,7 @@ static int sii9022_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t sii9022_rx(I2CSlave *i2c)
> +static uint8_t sii9022_rx(I2CTarget *i2c)
>  {
>      sii9022_state *s = SII9022(i2c);
>      uint8_t res = 0x00;
> @@ -112,7 +112,7 @@ static uint8_t sii9022_rx(I2CSlave *i2c)
>      return res;
>  }
>  
> -static int sii9022_tx(I2CSlave *i2c, uint8_t data)
> +static int sii9022_tx(I2CTarget *i2c, uint8_t data)
>  {
>      sii9022_state *s = SII9022(i2c);
>  
> @@ -164,13 +164,13 @@ static void sii9022_realize(DeviceState *dev,
> Error **errp)
>      I2CBus *bus;
>  
>      bus = I2C_BUS(qdev_get_parent_bus(dev));
> -    i2c_slave_create_simple(bus, TYPE_I2CDDC, 0x50);
> +    i2c_target_create_simple(bus, TYPE_I2CDDC, 0x50);
>  }
>  
>  static void sii9022_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      k->event = sii9022_event;
>      k->recv = sii9022_rx;
> @@ -182,7 +182,7 @@ static void sii9022_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo sii9022_info = {
>      .name          = TYPE_SII9022,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(sii9022_state),
>      .class_init    = sii9022_class_init,
>  };
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 26dc8170d8..a549c9149f 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1908,7 +1908,7 @@ static void sm501_init(SM501State *s,
> DeviceState *dev,
>      s->i2c_bus = i2c_init_bus(dev, "sm501.i2c");
>      /* ddc */
>      I2CDDCState *ddc = I2CDDC(qdev_new(TYPE_I2CDDC));
> -    i2c_slave_set_address(I2C_SLAVE(ddc), 0x50);
> +    i2c_target_set_address(I2C_SLAVE(ddc), 0x50);
>      qdev_realize_and_unref(DEVICE(ddc), BUS(s->i2c_bus),
> &error_abort);
>  
>      /* mmio */
> diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
> index e292cff44e..45d789d23e 100644
> --- a/hw/display/ssd0303.c
> +++ b/hw/display/ssd0303.c
> @@ -50,7 +50,7 @@ enum ssd0303_cmd {
>  OBJECT_DECLARE_SIMPLE_TYPE(ssd0303_state, SSD0303)
>  
>  struct ssd0303_state {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      QemuConsole *con;
>      int row;
> @@ -66,13 +66,13 @@ struct ssd0303_state {
>      uint8_t framebuffer[132*8];
>  };
>  
> -static uint8_t ssd0303_recv(I2CSlave *i2c)
> +static uint8_t ssd0303_recv(I2CTarget *i2c)
>  {
>      BADF("Reads not implemented\n");
>      return 0xff;
>  }
>  
> -static int ssd0303_send(I2CSlave *i2c, uint8_t data)
> +static int ssd0303_send(I2CTarget *i2c, uint8_t data)
>  {
>      ssd0303_state *s = SSD0303(i2c);
>      enum ssd0303_cmd old_cmd_state;
> @@ -183,7 +183,7 @@ static int ssd0303_send(I2CSlave *i2c, uint8_t
> data)
>      return 0;
>  }
>  
> -static int ssd0303_event(I2CSlave *i2c, enum i2c_event event)
> +static int ssd0303_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      ssd0303_state *s = SSD0303(i2c);
>  
> @@ -293,7 +293,7 @@ static const VMStateDescription vmstate_ssd0303 =
> {
>          VMSTATE_UINT32(mode, ssd0303_state),
>          VMSTATE_UINT32(cmd_state, ssd0303_state),
>          VMSTATE_BUFFER(framebuffer, ssd0303_state),
> -        VMSTATE_I2C_SLAVE(parent_obj, ssd0303_state),
> +        VMSTATE_I2C_TARGET(parent_obj, ssd0303_state),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -314,7 +314,7 @@ static void ssd0303_realize(DeviceState *dev,
> Error **errp)
>  static void ssd0303_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      dc->realize = ssd0303_realize;
>      k->event = ssd0303_event;
> @@ -325,7 +325,7 @@ static void ssd0303_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo ssd0303_info = {
>      .name          = TYPE_SSD0303,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(ssd0303_state),
>      .class_init    = ssd0303_class_init,
>  };
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index c42fc388dc..fd1cc371d3 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1273,7 +1273,7 @@ static void xlnx_dp_init(Object *obj)
>      object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
>  
>      s->edid = I2CDDC(qdev_new("i2c-ddc"));
> -    i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
> +    i2c_target_set_address(I2C_SLAVE(s->edid), 0x50);
>      object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
>  
>      fifo8_create(&s->rx_fifo, 16);
> diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
> index 86315714fb..e911647812 100644
> --- a/hw/gpio/max7310.c
> +++ b/hw/gpio/max7310.c
> @@ -19,7 +19,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(MAX7310State, MAX7310)
>  
>  struct MAX7310State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      int i2c_command_byte;
>      int len;
> @@ -44,7 +44,7 @@ static void max7310_reset(DeviceState *dev)
>      s->command = 0x00;
>  }
>  
> -static uint8_t max7310_rx(I2CSlave *i2c)
> +static uint8_t max7310_rx(I2CTarget *i2c)
>  {
>      MAX7310State *s = MAX7310(i2c);
>  
> @@ -75,7 +75,7 @@ static uint8_t max7310_rx(I2CSlave *i2c)
>      return 0xff;
>  }
>  
> -static int max7310_tx(I2CSlave *i2c, uint8_t data)
> +static int max7310_tx(I2CTarget *i2c, uint8_t data)
>  {
>      MAX7310State *s = MAX7310(i2c);
>      uint8_t diff;
> @@ -129,7 +129,7 @@ static int max7310_tx(I2CSlave *i2c, uint8_t
> data)
>      return 0;
>  }
>  
> -static int max7310_event(I2CSlave *i2c, enum i2c_event event)
> +static int max7310_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      MAX7310State *s = MAX7310(i2c);
>      s->len = 0;
> @@ -163,7 +163,7 @@ static const VMStateDescription vmstate_max7310 =
> {
>          VMSTATE_UINT8(polarity, MAX7310State),
>          VMSTATE_UINT8(status, MAX7310State),
>          VMSTATE_UINT8(command, MAX7310State),
> -        VMSTATE_I2C_SLAVE(parent_obj, MAX7310State),
> +        VMSTATE_I2C_TARGET(parent_obj, MAX7310State),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -192,7 +192,7 @@ static void max7310_realize(DeviceState *dev,
> Error **errp)
>  static void max7310_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      dc->realize = max7310_realize;
>      k->event = max7310_event;
> @@ -204,7 +204,7 @@ static void max7310_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo max7310_info = {
>      .name          = TYPE_MAX7310,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(MAX7310State),
>      .class_init    = max7310_class_init,
>  };
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 27d4db0680..8c691b805a 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -26,7 +26,7 @@
>  
>  struct PCA955xClass {
>      /*< private >*/
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>      /*< public >*/
>  
>      uint8_t pin_count;
> @@ -217,7 +217,7 @@ static void pca955x_autoinc(PCA955xState *s)
>      }
>  }
>  
> -static uint8_t pca955x_recv(I2CSlave *i2c)
> +static uint8_t pca955x_recv(I2CTarget *i2c)
>  {
>      PCA955xState *s = PCA955X(i2c);
>      uint8_t ret;
> @@ -245,7 +245,7 @@ static uint8_t pca955x_recv(I2CSlave *i2c)
>      return ret;
>  }
>  
> -static int pca955x_send(I2CSlave *i2c, uint8_t data)
> +static int pca955x_send(I2CTarget *i2c, uint8_t data)
>  {
>      PCA955xState *s = PCA955X(i2c);
>  
> @@ -262,7 +262,7 @@ static int pca955x_send(I2CSlave *i2c, uint8_t
> data)
>      return 0;
>  }
>  
> -static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
> +static int pca955x_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      PCA955xState *s = PCA955X(i2c);
>  
> @@ -354,7 +354,7 @@ static const VMStateDescription pca9552_vmstate =
> {
>          VMSTATE_UINT8(pointer, PCA955xState),
>          VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
>          VMSTATE_UINT8_ARRAY(ext_state, PCA955xState,
> PCA955X_PIN_COUNT_MAX),
> -        VMSTATE_I2C_SLAVE(i2c, PCA955xState),
> +        VMSTATE_I2C_TARGET(i2c, PCA955xState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -436,7 +436,7 @@ static Property pca955x_properties[] = {
>  static void pca955x_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      k->event = pca955x_event;
>      k->recv = pca955x_recv;
> @@ -447,7 +447,7 @@ static void pca955x_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo pca955x_info = {
>      .name          = TYPE_PCA955X,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_init = pca955x_initfn,
>      .instance_size = sizeof(PCA955xState),
>      .class_init    = pca955x_class_init,
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 7d10a64ba7..7bd0a29c66 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -22,7 +22,7 @@
>  
>  struct PCA9554Class {
>      /*< private >*/
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>      /*< public >*/
>  };
>  typedef struct PCA9554Class PCA9554Class;
> @@ -115,7 +115,7 @@ static void pca9554_write(PCA9554State *s,
> uint8_t reg, uint8_t data)
>      }
>  }
>  
> -static uint8_t pca9554_recv(I2CSlave *i2c)
> +static uint8_t pca9554_recv(I2CTarget *i2c)
>  {
>      PCA9554State *s = PCA9554(i2c);
>      uint8_t ret;
> @@ -125,7 +125,7 @@ static uint8_t pca9554_recv(I2CSlave *i2c)
>      return ret;
>  }
>  
> -static int pca9554_send(I2CSlave *i2c, uint8_t data)
> +static int pca9554_send(I2CTarget *i2c, uint8_t data)
>  {
>      PCA9554State *s = PCA9554(i2c);
>  
> @@ -140,7 +140,7 @@ static int pca9554_send(I2CSlave *i2c, uint8_t
> data)
>      return 0;
>  }
>  
> -static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
> +static int pca9554_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      PCA9554State *s = PCA9554(i2c);
>  
> @@ -227,7 +227,7 @@ static const VMStateDescription pca9554_vmstate =
> {
>          VMSTATE_UINT8(pointer, PCA9554State),
>          VMSTATE_UINT8_ARRAY(regs, PCA9554State, PCA9554_NR_REGS),
>          VMSTATE_UINT8_ARRAY(ext_state, PCA9554State,
> PCA9554_PIN_COUNT),
> -        VMSTATE_I2C_SLAVE(i2c, PCA9554State),
> +        VMSTATE_I2C_TARGET(i2c, PCA9554State),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -299,7 +299,7 @@ static Property pca9554_properties[] = {
>  static void pca9554_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      k->event = pca9554_event;
>      k->recv = pca9554_recv;
> @@ -312,7 +312,7 @@ static void pca9554_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo pca9554_info = {
>      .name          = TYPE_PCA9554,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_init = pca9554_initfn,
>      .instance_size = sizeof(PCA9554State),
>      .class_init    = pca9554_class_init,
> diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
> index d37909e2ad..460023ceb3 100644
> --- a/hw/gpio/pcf8574.c
> +++ b/hw/gpio/pcf8574.c
> @@ -39,7 +39,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
>  #define PORTS_COUNT (8)
>  
>  struct PCF8574State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>      uint8_t  lastrq;     /* Last requested state. If changed -
> assert irq */
>      uint8_t  input;      /* external electrical line state */
>      uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
> @@ -61,7 +61,7 @@ static inline uint8_t
> pcf8574_line_state(PCF8574State *s)
>      return s->input & s->output;
>  }
>  
> -static uint8_t pcf8574_rx(I2CSlave *i2c)
> +static uint8_t pcf8574_rx(I2CTarget *i2c)
>  {
>      PCF8574State *s = PCF8574(i2c);
>      uint8_t linestate = pcf8574_line_state(s);
> @@ -74,7 +74,7 @@ static uint8_t pcf8574_rx(I2CSlave *i2c)
>      return linestate;
>  }
>  
> -static int pcf8574_tx(I2CSlave *i2c, uint8_t data)
> +static int pcf8574_tx(I2CTarget *i2c, uint8_t data)
>  {
>      PCF8574State *s = PCF8574(i2c);
>      uint8_t prev;
> @@ -105,7 +105,7 @@ static const VMStateDescription vmstate_pcf8574 =
> {
>      .version_id         = 0,
>      .minimum_version_id = 0,
>      .fields = (VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, PCF8574State),
> +        VMSTATE_I2C_TARGET(parent_obj, PCF8574State),
>          VMSTATE_UINT8(lastrq, PCF8574State),
>          VMSTATE_UINT8(input,  PCF8574State),
>          VMSTATE_UINT8(output, PCF8574State),
> @@ -141,7 +141,7 @@ static void pcf8574_realize(DeviceState *dev,
> Error **errp)
>  static void pcf8574_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass   *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k  = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k  = I2C_TARGET_CLASS(klass);
>  
>      k->recv     = pcf8574_rx;
>      k->send     = pcf8574_tx;
> @@ -153,7 +153,7 @@ static void pcf8574_class_init(ObjectClass
> *klass, void *data)
>  static const TypeInfo pcf8574_infos[] = {
>      {
>          .name          = TYPE_PCF8574,
> -        .parent        = TYPE_I2C_SLAVE,
> +        .parent        = TYPE_I2C_TARGET,
>          .instance_size = sizeof(PCF8574State),
>          .class_init    = pcf8574_class_init,
>      }
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index b43afd250d..8ed67d5f0c 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -536,7 +536,7 @@ static void
> aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>          SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_STOP_CMD, 0);
>          aspeed_i2c_set_state(bus, I2CD_IDLE);
>  
> -        i2c_schedule_pending_master(bus->bus);
> +        i2c_schedule_pending_controller(bus->bus);
>      }
>  
>      if (aspeed_i2c_bus_pkt_mode_en(bus)) {
> @@ -693,7 +693,7 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus
> *bus, hwaddr offset,
>          } else {
>              bus->regs[R_I2CS_CMD] = value;
>          }
> -        i2c_slave_set_address(bus->slave, bus-
> >regs[R_I2CS_DEV_ADDR]);
> +        i2c_target_set_address(bus->slave, bus-
> >regs[R_I2CS_DEV_ADDR]);
>          break;
>      case A_I2CS_INTR_CTRL:
>          bus->regs[R_I2CS_INTR_CTRL] = value;
> @@ -738,7 +738,7 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus
> *bus, hwaddr offset,
>      switch (offset) {
>      case A_I2CD_FUN_CTRL:
>          if (SHARED_FIELD_EX32(value, SLAVE_EN)) {
> -            i2c_slave_set_address(bus->slave, bus-
> >regs[R_I2CD_DEV_ADDR]);
> +            i2c_target_set_address(bus->slave, bus-
> >regs[R_I2CD_DEV_ADDR]);
>          }
>          bus->regs[R_I2CD_FUN_CTRL] = value & 0x0071C3FF;
>          break;
> @@ -1112,7 +1112,7 @@ static int
> aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,
>      return 0;
>  }
>  
> -static int aspeed_i2c_bus_slave_event(I2CSlave *slave, enum
> i2c_event event)
> +static int aspeed_i2c_bus_slave_event(I2CTarget *slave, enum
> i2c_event event)
>  {
>      BusState *qbus = qdev_get_parent_bus(DEVICE(slave));
>      AspeedI2CBus *bus = ASPEED_I2C_BUS(qbus->parent);
> @@ -1167,7 +1167,7 @@ static void
> aspeed_i2c_bus_new_slave_send_async(AspeedI2CBus *bus, uint8_t data)
>      i2c_ack(bus->bus);
>  }
>  
> -static void aspeed_i2c_bus_slave_send_async(I2CSlave *slave, uint8_t
> data)
> +static void aspeed_i2c_bus_slave_send_async(I2CTarget *slave,
> uint8_t data)
>  {
>      BusState *qbus = qdev_get_parent_bus(DEVICE(slave));
>      AspeedI2CBus *bus = ASPEED_I2C_BUS(qbus->parent);
> @@ -1187,7 +1187,7 @@ static void
> aspeed_i2c_bus_slave_send_async(I2CSlave *slave, uint8_t data)
>  static void aspeed_i2c_bus_slave_class_init(ObjectClass *klass, void
> *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc = I2C_TARGET_CLASS(klass);
>  
>      dc->desc = "Aspeed I2C Bus Slave";
>  
> @@ -1197,7 +1197,7 @@ static void
> aspeed_i2c_bus_slave_class_init(ObjectClass *klass, void *data)
>  
>  static const TypeInfo aspeed_i2c_bus_slave_info = {
>      .name           = TYPE_ASPEED_I2C_BUS_SLAVE,
> -    .parent         = TYPE_I2C_SLAVE,
> +    .parent         = TYPE_I2C_TARGET,
>      .instance_size  = sizeof(AspeedI2CBusSlave),
>      .class_init     = aspeed_i2c_bus_slave_class_init,
>  };
> @@ -1226,7 +1226,7 @@ static void aspeed_i2c_bus_realize(DeviceState
> *dev, Error **errp)
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>  
>      s->bus = i2c_init_bus(dev, name);
> -    s->slave = i2c_slave_create_simple(s->bus,
> TYPE_ASPEED_I2C_BUS_SLAVE,
> +    s->slave = i2c_target_create_simple(s->bus,
> TYPE_ASPEED_I2C_BUS_SLAVE,
>                                         0xff);
>  
>      memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 4cf30b2c86..fd34a6bc83 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -19,7 +19,7 @@
>  #define I2C_BROADCAST 0x00
>  
>  static Property i2c_props[] = {
> -    DEFINE_PROP_UINT8("address", struct I2CSlave, address, 0),
> +    DEFINE_PROP_UINT8("address", struct I2CTarget, address, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -63,12 +63,12 @@ I2CBus *i2c_init_bus(DeviceState *parent, const
> char *name)
>  
>      bus = I2C_BUS(qbus_new(TYPE_I2C_BUS, parent, name));
>      QLIST_INIT(&bus->current_devs);
> -    QSIMPLEQ_INIT(&bus->pending_masters);
> +    QSIMPLEQ_INIT(&bus->pending_controllers);
>      vmstate_register_any(NULL, &vmstate_i2c_bus, bus);
>      return bus;
>  }
>  
> -void i2c_slave_set_address(I2CSlave *dev, uint8_t address)
> +void i2c_target_set_address(I2CTarget *dev, uint8_t address)
>  {
>      dev->address = address;
>  }
> @@ -86,8 +86,8 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address,
> bool broadcast,
>  
>      QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
>          DeviceState *qdev = kid->child;
> -        I2CSlave *candidate = I2C_SLAVE(qdev);
> -        I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(candidate);
> +        I2CTarget *candidate = I2C_SLAVE(qdev);
> +        I2CTargetClass *sc = I2C_TARGET_GET_CLASS(candidate);
>  
>          if (sc->match_and_add(candidate, address, broadcast,
> current_devs)) {
>              if (!broadcast) {
> @@ -122,7 +122,7 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address,
> bool broadcast,
>  static int i2c_do_start_transfer(I2CBus *bus, uint8_t address,
>                                   enum i2c_event event)
>  {
> -    I2CSlaveClass *sc;
> +    I2CTargetClass *sc;
>      I2CNode *node;
>      bool bus_scanned = false;
>  
> @@ -153,10 +153,10 @@ static int i2c_do_start_transfer(I2CBus *bus,
> uint8_t address,
>      }
>  
>      QLIST_FOREACH(node, &bus->current_devs, next) {
> -        I2CSlave *s = node->elt;
> +        I2CTarget *s = node->elt;
>          int rv;
>  
> -        sc = I2C_SLAVE_GET_CLASS(s);
> +        sc = I2C_TARGET_GET_CLASS(s);
>          /* If the bus is already busy, assume this is a repeated
>             start condition.  */
>  
> @@ -183,31 +183,31 @@ int i2c_start_transfer(I2CBus *bus, uint8_t
> address, bool is_recv)
>                                                 : I2C_START_SEND);
>  }
>  
> -void i2c_bus_master(I2CBus *bus, QEMUBH *bh)
> +void i2c_bus_controller(I2CBus *bus, QEMUBH *bh)
>  {
> -    I2CPendingMaster *node = g_new(struct I2CPendingMaster, 1);
> +    I2CPendingController *node = g_new(struct I2CPendingController,
> 1);
>      node->bh = bh;
>  
> -    QSIMPLEQ_INSERT_TAIL(&bus->pending_masters, node, entry);
> +    QSIMPLEQ_INSERT_TAIL(&bus->pending_controllers, node, entry);
>  }
>  
> -void i2c_schedule_pending_master(I2CBus *bus)
> +void i2c_schedule_pending_controller(I2CBus *bus)
>  {
> -    I2CPendingMaster *node;
> +    I2CPendingController *node;
>  
>      if (i2c_bus_busy(bus)) {
>          /* someone is already controlling the bus; wait for it to
> release it */
>          return;
>      }
>  
> -    if (QSIMPLEQ_EMPTY(&bus->pending_masters)) {
> +    if (QSIMPLEQ_EMPTY(&bus->pending_controllers)) {
>          return;
>      }
>  
> -    node = QSIMPLEQ_FIRST(&bus->pending_masters);
> +    node = QSIMPLEQ_FIRST(&bus->pending_controllers);
>      bus->bh = node->bh;
>  
> -    QSIMPLEQ_REMOVE_HEAD(&bus->pending_masters, entry);
> +    QSIMPLEQ_REMOVE_HEAD(&bus->pending_controllers, entry);
>      g_free(node);
>  
>      qemu_bh_schedule(bus->bh);
> @@ -217,7 +217,7 @@ void i2c_bus_release(I2CBus *bus)
>  {
>      bus->bh = NULL;
>  
> -    i2c_schedule_pending_master(bus);
> +    i2c_schedule_pending_controller(bus);
>  }
>  
>  int i2c_start_recv(I2CBus *bus, uint8_t address)
> @@ -237,12 +237,12 @@ int i2c_start_send_async(I2CBus *bus, uint8_t
> address)
>  
>  void i2c_end_transfer(I2CBus *bus)
>  {
> -    I2CSlaveClass *sc;
> +    I2CTargetClass *sc;
>      I2CNode *node, *next;
>  
>      QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
> -        I2CSlave *s = node->elt;
> -        sc = I2C_SLAVE_GET_CLASS(s);
> +        I2CTarget *s = node->elt;
> +        sc = I2C_TARGET_GET_CLASS(s);
>          if (sc->event) {
>              trace_i2c_event("finish", s->address);
>              sc->event(s, I2C_FINISH);
> @@ -255,14 +255,14 @@ void i2c_end_transfer(I2CBus *bus)
>  
>  int i2c_send(I2CBus *bus, uint8_t data)
>  {
> -    I2CSlaveClass *sc;
> -    I2CSlave *s;
> +    I2CTargetClass *sc;
> +    I2CTarget *s;
>      I2CNode *node;
>      int ret = 0;
>  
>      QLIST_FOREACH(node, &bus->current_devs, next) {
>          s = node->elt;
> -        sc = I2C_SLAVE_GET_CLASS(s);
> +        sc = I2C_TARGET_GET_CLASS(s);
>          if (sc->send) {
>              trace_i2c_send(s->address, data);
>              ret = ret || sc->send(s, data);
> @@ -277,8 +277,8 @@ int i2c_send(I2CBus *bus, uint8_t data)
>  int i2c_send_async(I2CBus *bus, uint8_t data)
>  {
>      I2CNode *node = QLIST_FIRST(&bus->current_devs);
> -    I2CSlave *slave = node->elt;
> -    I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(slave);
> +    I2CTarget *slave = node->elt;
> +    I2CTargetClass *sc = I2C_TARGET_GET_CLASS(slave);
>  
>      if (!sc->send_async) {
>          return -1;
> @@ -294,11 +294,11 @@ int i2c_send_async(I2CBus *bus, uint8_t data)
>  uint8_t i2c_recv(I2CBus *bus)
>  {
>      uint8_t data = 0xff;
> -    I2CSlaveClass *sc;
> -    I2CSlave *s;
> +    I2CTargetClass *sc;
> +    I2CTarget *s;
>  
>      if (!QLIST_EMPTY(&bus->current_devs) && !bus->broadcast) {
> -        sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)-
> >elt);
> +        sc = I2C_TARGET_GET_CLASS(QLIST_FIRST(&bus->current_devs)-
> >elt);
>          if (sc->recv) {
>              s = QLIST_FIRST(&bus->current_devs)->elt;
>              data = sc->recv(s);
> @@ -311,7 +311,7 @@ uint8_t i2c_recv(I2CBus *bus)
>  
>  void i2c_nack(I2CBus *bus)
>  {
> -    I2CSlaveClass *sc;
> +    I2CTargetClass *sc;
>      I2CNode *node;
>  
>      if (QLIST_EMPTY(&bus->current_devs)) {
> @@ -319,7 +319,7 @@ void i2c_nack(I2CBus *bus)
>      }
>  
>      QLIST_FOREACH(node, &bus->current_devs, next) {
> -        sc = I2C_SLAVE_GET_CLASS(node->elt);
> +        sc = I2C_TARGET_GET_CLASS(node->elt);
>          if (sc->event) {
>              trace_i2c_event("nack", node->elt->address);
>              sc->event(node->elt, I2C_NACK);
> @@ -340,7 +340,7 @@ void i2c_ack(I2CBus *bus)
>  
>  static int i2c_slave_post_load(void *opaque, int version_id)
>  {
> -    I2CSlave *dev = opaque;
> +    I2CTarget *dev = opaque;
>      I2CBus *bus;
>      I2CNode *node;
>  
> @@ -354,18 +354,18 @@ static int i2c_slave_post_load(void *opaque,
> int version_id)
>      return 0;
>  }
>  
> -const VMStateDescription vmstate_i2c_slave = {
> -    .name = "I2CSlave",
> +const VMStateDescription vmstate_i2c_target = {
> +    .name = "I2CTarget",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .post_load = i2c_slave_post_load,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_UINT8(address, I2CSlave),
> +        VMSTATE_UINT8(address, I2CTarget),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>  
> -I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
> +I2CTarget *i2c_target_new(const char *name, uint8_t addr)
>  {
>      DeviceState *dev;
>  
> @@ -374,21 +374,21 @@ I2CSlave *i2c_slave_new(const char *name,
> uint8_t addr)
>      return I2C_SLAVE(dev);
>  }
>  
> -bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error
> **errp)
> +bool i2c_target_realize_and_unref(I2CTarget *dev, I2CBus *bus, Error
> **errp)
>  {
>      return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
>  }
>  
> -I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name,
> uint8_t addr)
> +I2CTarget *i2c_target_create_simple(I2CBus *bus, const char *name,
> uint8_t addr)
>  {
> -    I2CSlave *dev = i2c_slave_new(name, addr);
> +    I2CTarget *dev = i2c_target_new(name, addr);
>  
> -    i2c_slave_realize_and_unref(dev, bus, &error_abort);
> +    i2c_target_realize_and_unref(dev, bus, &error_abort);
>  
>      return dev;
>  }
>  
> -static bool i2c_slave_match(I2CSlave *candidate, uint8_t address,
> +static bool i2c_slave_match(I2CTarget *candidate, uint8_t address,
>                              bool broadcast, I2CNodeList
> *current_devs)
>  {
>      if ((candidate->address == address) || (broadcast)) {
> @@ -405,7 +405,7 @@ static bool i2c_slave_match(I2CSlave *candidate,
> uint8_t address,
>  static void i2c_slave_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k = DEVICE_CLASS(klass);
> -    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc = I2C_TARGET_CLASS(klass);
>      set_bit(DEVICE_CATEGORY_MISC, k->categories);
>      k->bus_type = TYPE_I2C_BUS;
>      device_class_set_props(k, i2c_props);
> @@ -413,11 +413,11 @@ static void i2c_slave_class_init(ObjectClass
> *klass, void *data)
>  }
>  
>  static const TypeInfo i2c_slave_type_info = {
> -    .name = TYPE_I2C_SLAVE,
> +    .name = TYPE_I2C_TARGET,
>      .parent = TYPE_DEVICE,
> -    .instance_size = sizeof(I2CSlave),
> +    .instance_size = sizeof(I2CTarget),
>      .abstract = true,
> -    .class_size = sizeof(I2CSlaveClass),
> +    .class_size = sizeof(I2CTargetClass),
>      .class_init = i2c_slave_class_init,
>  };
>  
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index db5db956a6..53c33ac3ff 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -64,7 +64,7 @@ OBJECT_DECLARE_TYPE(Pca954xState, Pca954xClass,
> PCA954X)
>  /*
>   * For each channel, if it's enabled, recursively call match on
> those children.
>   */
> -static bool pca954x_match(I2CSlave *candidate, uint8_t address,
> +static bool pca954x_match(I2CTarget *candidate, uint8_t address,
>                            bool broadcast,
>                            I2CNodeList *current_devs)
>  {
> @@ -163,7 +163,7 @@ static void pca954x_enter_reset(Object *obj,
> ResetType type)
>      pca954x_write(s, 0);
>  }
>  
> -I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
> +I2CBus *pca954x_i2c_get_bus(I2CTarget *mux, uint8_t channel)
>  {
>      Pca954xClass *pc = PCA954X_GET_CLASS(mux);
>      Pca954xState *pca954x = PCA954X(mux);
> @@ -218,7 +218,7 @@ static Property pca954x_props[] = {
>  
>  static void pca954x_class_init(ObjectClass *klass, void *data)
>  {
> -    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc = I2C_TARGET_CLASS(klass);
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      SMBusDeviceClass *k = SMBUS_DEVICE_CLASS(klass);
> diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
> index a25676f025..363e51fda1 100644
> --- a/hw/i2c/imx_i2c.c
> +++ b/hw/i2c/imx_i2c.c
> @@ -171,7 +171,7 @@ static void imx_i2c_write(void *opaque, hwaddr
> offset,
>      switch (offset) {
>      case IADR_ADDR:
>          s->iadr = value & IADR_MASK;
> -        /* i2c_slave_set_address(s->bus, (uint8_t)s->iadr); */
> +        /* i2c_target_set_address(s->bus, (uint8_t)s->iadr); */
>          break;
>      case IFDR_ADDR:
>          s->ifdr = value & IFDR_MASK;
> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
> index 9f9afc25a4..68acf01d1e 100644
> --- a/hw/i2c/smbus_slave.c
> +++ b/hw/i2c/smbus_slave.c
> @@ -64,7 +64,7 @@ static void smbus_do_write(SMBusDevice *dev)
>      }
>  }
>  
> -static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
> +static int smbus_i2c_event(I2CTarget *s, enum i2c_event event)
>  {
>      SMBusDevice *dev = SMBUS_DEVICE(s);
>  
> @@ -156,7 +156,7 @@ static int smbus_i2c_event(I2CSlave *s, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t smbus_i2c_recv(I2CSlave *s)
> +static uint8_t smbus_i2c_recv(I2CTarget *s)
>  {
>      SMBusDevice *dev = SMBUS_DEVICE(s);
>      SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
> @@ -179,7 +179,7 @@ static uint8_t smbus_i2c_recv(I2CSlave *s)
>      return ret;
>  }
>  
> -static int smbus_i2c_send(I2CSlave *s, uint8_t data)
> +static int smbus_i2c_send(I2CTarget *s, uint8_t data)
>  {
>      SMBusDevice *dev = SMBUS_DEVICE(s);
>  
> @@ -203,7 +203,7 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t
> data)
>  
>  static void smbus_device_class_init(ObjectClass *klass, void *data)
>  {
> -    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc = I2C_TARGET_CLASS(klass);
>  
>      sc->event = smbus_i2c_event;
>      sc->recv = smbus_i2c_recv;
> @@ -220,7 +220,7 @@ const VMStateDescription vmstate_smbus_device = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
> +        VMSTATE_I2C_TARGET(i2c, SMBusDevice),
>          VMSTATE_INT32(mode, SMBusDevice),
>          VMSTATE_INT32(data_len, SMBusDevice),
>          VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice,
> SMBUS_DATA_MAX_LEN),
> @@ -230,7 +230,7 @@ const VMStateDescription vmstate_smbus_device = {
>  
>  static const TypeInfo smbus_device_type_info = {
>      .name = TYPE_SMBUS_DEVICE,
> -    .parent = TYPE_I2C_SLAVE,
> +    .parent = TYPE_I2C_TARGET,
>      .instance_size = sizeof(SMBusDevice),
>      .abstract = true,
>      .class_size = sizeof(SMBusDeviceClass),
> diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
> index 59e5567afd..615d30a8bd 100644
> --- a/hw/input/lm832x.c
> +++ b/hw/input/lm832x.c
> @@ -31,7 +31,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(LM823KbdState, LM8323)
>  
>  struct LM823KbdState {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      uint8_t i2c_dir;
>      uint8_t i2c_cycle;
> @@ -388,7 +388,7 @@ static void lm_kbd_write(LM823KbdState *s, int
> reg, int byte, uint8_t value)
>      }
>  }
>  
> -static int lm_i2c_event(I2CSlave *i2c, enum i2c_event event)
> +static int lm_i2c_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      LM823KbdState *s = LM8323(i2c);
>  
> @@ -406,14 +406,14 @@ static int lm_i2c_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t lm_i2c_rx(I2CSlave *i2c)
> +static uint8_t lm_i2c_rx(I2CTarget *i2c)
>  {
>      LM823KbdState *s = LM8323(i2c);
>  
>      return lm_kbd_read(s, s->reg, s->i2c_cycle ++);
>  }
>  
> -static int lm_i2c_tx(I2CSlave *i2c, uint8_t data)
> +static int lm_i2c_tx(I2CTarget *i2c, uint8_t data)
>  {
>      LM823KbdState *s = LM8323(i2c);
>  
> @@ -442,7 +442,7 @@ static const VMStateDescription vmstate_lm_kbd =
> {
>      .minimum_version_id = 0,
>      .post_load = lm_kbd_post_load,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, LM823KbdState),
> +        VMSTATE_I2C_TARGET(parent_obj, LM823KbdState),
>          VMSTATE_UINT8(i2c_dir, LM823KbdState),
>          VMSTATE_UINT8(i2c_cycle, LM823KbdState),
>          VMSTATE_UINT8(reg, LM823KbdState),
> @@ -503,7 +503,7 @@ void lm832x_key_event(DeviceState *dev, int key,
> int state)
>  static void lm8323_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      dc->reset = lm_kbd_reset;
>      dc->realize = lm8323_realize;
> @@ -515,7 +515,7 @@ static void lm8323_class_init(ObjectClass *klass,
> void *data)
>  
>  static const TypeInfo lm8323_info = {
>      .name          = TYPE_LM8323,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(LM823KbdState),
>      .class_init    = lm8323_class_init,
>  };
> diff --git a/hw/misc/axp2xx.c b/hw/misc/axp2xx.c
> index af646878cd..430e70ae54 100644
> --- a/hw/misc/axp2xx.c
> +++ b/hw/misc/axp2xx.c
> @@ -45,7 +45,7 @@ OBJECT_DECLARE_TYPE(AXP2xxI2CState, AXP2xxClass,
> AXP2XX)
>  /* A simple I2C slave which returns values of ID or CNT register. */
>  typedef struct AXP2xxI2CState {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>      uint8_t regs[NR_REGS];  /* peripheral registers */
>      uint8_t ptr;            /* current register index */
> @@ -54,7 +54,7 @@ typedef struct AXP2xxI2CState {
>  
>  typedef struct AXP2xxClass {
>      /*< private >*/
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>      /*< public >*/
>      void (*reset_enter)(AXP2xxI2CState *s, ResetType type);
>  } AXP2xxClass;
> @@ -169,7 +169,7 @@ static void axp2xx_reset_enter(Object *obj,
> ResetType type)
>  }
>  
>  /* Handle events from master. */
> -static int axp2xx_event(I2CSlave *i2c, enum i2c_event event)
> +static int axp2xx_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      AXP2xxI2CState *s = AXP2XX(i2c);
>  
> @@ -179,7 +179,7 @@ static int axp2xx_event(I2CSlave *i2c, enum
> i2c_event event)
>  }
>  
>  /* Called when master requests read */
> -static uint8_t axp2xx_rx(I2CSlave *i2c)
> +static uint8_t axp2xx_rx(I2CTarget *i2c)
>  {
>      AXP2xxI2CState *s = AXP2XX(i2c);
>      uint8_t ret = 0xff;
> @@ -197,7 +197,7 @@ static uint8_t axp2xx_rx(I2CSlave *i2c)
>   * Called when master sends write.
>   * Update ptr with byte 0, then perform write with second byte.
>   */
> -static int axp2xx_tx(I2CSlave *i2c, uint8_t data)
> +static int axp2xx_tx(I2CTarget *i2c, uint8_t data)
>  {
>      AXP2xxI2CState *s = AXP2XX(i2c);
>  
> @@ -228,7 +228,7 @@ static const VMStateDescription vmstate_axp2xx =
> {
>  static void axp2xx_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> -    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
> +    I2CTargetClass *isc = I2C_TARGET_CLASS(oc);
>      ResettableClass *rc = RESETTABLE_CLASS(oc);
>  
>      rc->phases.enter = axp2xx_reset_enter;
> @@ -240,7 +240,7 @@ static void axp2xx_class_init(ObjectClass *oc,
> void *data)
>  
>  static const TypeInfo axp2xx_info = {
>      .name = TYPE_AXP2XX,
> -    .parent = TYPE_I2C_SLAVE,
> +    .parent = TYPE_I2C_TARGET,
>      .instance_size = sizeof(AXP2xxI2CState),
>      .class_size = sizeof(AXP2xxClass),
>      .class_init = axp2xx_class_init,
> diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
> index 5ae3d0817e..a966718c99 100644
> --- a/hw/misc/i2c-echo.c
> +++ b/hw/misc/i2c-echo.c
> @@ -24,7 +24,7 @@ enum i2c_echo_state {
>  };
>  
>  typedef struct I2CEchoState {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      I2CBus *bus;
>  
> @@ -72,7 +72,7 @@ release_bus:
>      state->state = I2C_ECHO_STATE_IDLE;
>  }
>  
> -static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
> +static int i2c_echo_event(I2CTarget *s, enum i2c_event event)
>  {
>      I2CEchoState *state = I2C_ECHO(s);
>  
> @@ -90,7 +90,7 @@ static int i2c_echo_event(I2CSlave *s, enum
> i2c_event event)
>      case I2C_FINISH:
>          state->pos = 0;
>          state->state = I2C_ECHO_STATE_START_SEND;
> -        i2c_bus_master(state->bus, state->bh);
> +        i2c_bus_controller(state->bus, state->bh);
>  
>          break;
>  
> @@ -104,7 +104,7 @@ static int i2c_echo_event(I2CSlave *s, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t i2c_echo_recv(I2CSlave *s)
> +static uint8_t i2c_echo_recv(I2CTarget *s)
>  {
>      I2CEchoState *state = I2C_ECHO(s);
>  
> @@ -115,7 +115,7 @@ static uint8_t i2c_echo_recv(I2CSlave *s)
>      return state->data[state->pos++];
>  }
>  
> -static int i2c_echo_send(I2CSlave *s, uint8_t data)
> +static int i2c_echo_send(I2CTarget *s, uint8_t data)
>  {
>      I2CEchoState *state = I2C_ECHO(s);
>  
> @@ -141,7 +141,7 @@ static void i2c_echo_realize(DeviceState *dev,
> Error **errp)
>  
>  static void i2c_echo_class_init(ObjectClass *oc, void *data)
>  {
> -    I2CSlaveClass *sc = I2C_SLAVE_CLASS(oc);
> +    I2CTargetClass *sc = I2C_TARGET_CLASS(oc);
>      DeviceClass *dc = DEVICE_CLASS(oc);
>  
>      dc->realize = i2c_echo_realize;
> @@ -153,7 +153,7 @@ static void i2c_echo_class_init(ObjectClass *oc,
> void *data)
>  
>  static const TypeInfo i2c_echo = {
>      .name = TYPE_I2C_ECHO,
> -    .parent = TYPE_I2C_SLAVE,
> +    .parent = TYPE_I2C_TARGET,
>      .instance_size = sizeof(I2CEchoState),
>      .class_init = i2c_echo_class_init,
>  };
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 4db83d0dd6..cb4cc2273c 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -35,7 +35,7 @@ DECLARE_INSTANCE_CHECKER(EEPROMState, AT24C_EE,
>                           TYPE_AT24C_EE)
>  
>  struct EEPROMState {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      /* address counter */
>      uint16_t cur;
> @@ -63,7 +63,7 @@ struct EEPROMState {
>  };
>  
>  static
> -int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
> +int at24c_eeprom_event(I2CTarget *s, enum i2c_event event)
>  {
>      EEPROMState *ee = AT24C_EE(s);
>  
> @@ -93,7 +93,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event
> event)
>  }
>  
>  static
> -uint8_t at24c_eeprom_recv(I2CSlave *s)
> +uint8_t at24c_eeprom_recv(I2CTarget *s)
>  {
>      EEPROMState *ee = AT24C_EE(s);
>      uint8_t ret;
> @@ -115,7 +115,7 @@ uint8_t at24c_eeprom_recv(I2CSlave *s)
>  }
>  
>  static
> -int at24c_eeprom_send(I2CSlave *s, uint8_t data)
> +int at24c_eeprom_send(I2CTarget *s, uint8_t data)
>  {
>      EEPROMState *ee = AT24C_EE(s);
>  
> @@ -143,19 +143,19 @@ int at24c_eeprom_send(I2CSlave *s, uint8_t
> data)
>      return 0;
>  }
>  
> -I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t
> rom_size)
> +I2CTarget *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t
> rom_size)
>  {
>      return at24c_eeprom_init_rom(bus, address, rom_size, NULL, 0);
>  }
>  
> -I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,
> +I2CTarget *at24c_eeprom_init_rom(I2CBus *bus,
>                                  uint8_t address, uint32_t rom_size,
>                                  const uint8_t *init_rom,
>                                  uint32_t init_rom_size)
>  {
>      EEPROMState *s;
>  
> -    s = AT24C_EE(i2c_slave_new(TYPE_AT24C_EE, address));
> +    s = AT24C_EE(i2c_target_new(TYPE_AT24C_EE, address));
>  
>      qdev_prop_set_uint32(DEVICE(s), "rom-size", rom_size);
>  
> @@ -163,7 +163,7 @@ I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,
>      s->init_rom = init_rom;
>      s->init_rom_size = init_rom_size;
>  
> -    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
> +    i2c_target_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
>  
>      return I2C_SLAVE(s);
>  }
> @@ -248,7 +248,7 @@ static
>  void at24c_eeprom_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      dc->realize = &at24c_eeprom_realize;
>      k->event = &at24c_eeprom_event;
> @@ -262,9 +262,9 @@ void at24c_eeprom_class_init(ObjectClass *klass,
> void *data)
>  static
>  const TypeInfo at24c_eeprom_type = {
>      .name = TYPE_AT24C_EE,
> -    .parent = TYPE_I2C_SLAVE,
> +    .parent = TYPE_I2C_TARGET,
>      .instance_size = sizeof(EEPROMState),
> -    .class_size = sizeof(I2CSlaveClass),
> +    .class_size = sizeof(I2CTargetClass),
>      .class_init = at24c_eeprom_class_init,
>  };
>  
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 3bd12b54ab..200c46eb3f 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1025,7 +1025,7 @@ void ppce500_init(MachineState *machine)
>      memory_region_add_subregion(ccsr_addr_space,
> MPC8544_I2C_REGS_OFFSET,
>                                  sysbus_mmio_get_region(s, 0));
>      i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
> +    i2c_target_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
>  
>      /* eSDHC */
>      if (pmc->has_esdhc) {
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec..c648c66eed 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2056,7 +2056,7 @@ static void
> pnv_rainier_i2c_init(PnvMachineState *pnv)
>           * Add a PCA9552 I2C device for PCIe hotplug control
>           * to engine 2, bus 1, address 0x63
>           */
> -        I2CSlave *dev = i2c_slave_create_simple(chip10-
> >i2c[2].busses[1],
> +        I2CTarget *dev = i2c_target_create_simple(chip10-
> >i2c[2].busses[1],
>                                                  "pca9552", 0x63);
>  
>          /*
> @@ -2074,7 +2074,7 @@ static void
> pnv_rainier_i2c_init(PnvMachineState *pnv)
>           * Add a PCA9554 I2C device for cable card presence
> detection
>           * to engine 2, bus 1, address 0x25
>           */
> -        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9554",
> 0x25);
> +        i2c_target_create_simple(chip10->i2c[2].busses[1],
> "pca9554", 0x25);
>      }
>  }
>  
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index d42b677898..e71cfacc2c 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -372,7 +372,7 @@ static void sam460ex_init(MachineState *machine)
>      spd_data[20] = 4; /* SO-DIMM module */
>      smbus_eeprom_init_one(i2c, 0x50, spd_data);
>      /* RTC */
> -    i2c_slave_create_simple(i2c, "m41t80", 0x68);
> +    i2c_target_create_simple(i2c, "m41t80", 0x68);
>  
>      dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800,
>                                 qdev_get_gpio_in(uic[0], 3));
> diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
> index e479661c39..47a4c93a5a 100644
> --- a/hw/rtc/ds1338.c
> +++ b/hw/rtc/ds1338.c
> @@ -33,7 +33,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
>  
>  struct DS1338State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      int64_t offset;
>      uint8_t wday_offset;
> @@ -47,7 +47,7 @@ static const VMStateDescription vmstate_ds1338 = {
>      .version_id = 2,
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, DS1338State),
> +        VMSTATE_I2C_TARGET(parent_obj, DS1338State),
>          VMSTATE_INT64(offset, DS1338State),
>          VMSTATE_UINT8_V(wday_offset, DS1338State, 2),
>          VMSTATE_UINT8_ARRAY(nvram, DS1338State, NVRAM_SIZE),
> @@ -97,7 +97,7 @@ static void inc_regptr(DS1338State *s)
>      }
>  }
>  
> -static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
> +static int ds1338_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      DS1338State *s = DS1338(i2c);
>  
> @@ -120,7 +120,7 @@ static int ds1338_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static uint8_t ds1338_recv(I2CSlave *i2c)
> +static uint8_t ds1338_recv(I2CTarget *i2c)
>  {
>      DS1338State *s = DS1338(i2c);
>      uint8_t res;
> @@ -130,7 +130,7 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
>      return res;
>  }
>  
> -static int ds1338_send(I2CSlave *i2c, uint8_t data)
> +static int ds1338_send(I2CTarget *i2c, uint8_t data)
>  {
>      DS1338State *s = DS1338(i2c);
>  
> @@ -218,7 +218,7 @@ static void ds1338_reset(DeviceState *dev)
>  static void ds1338_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      k->event = ds1338_event;
>      k->recv = ds1338_recv;
> @@ -229,7 +229,7 @@ static void ds1338_class_init(ObjectClass *klass,
> void *data)
>  
>  static const TypeInfo ds1338_info = {
>      .name          = TYPE_DS1338,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(DS1338State),
>      .class_init    = ds1338_class_init,
>  };
> diff --git a/hw/rtc/m41t80.c b/hw/rtc/m41t80.c
> index e045c864bb..d43184f1c8 100644
> --- a/hw/rtc/m41t80.c
> +++ b/hw/rtc/m41t80.c
> @@ -20,7 +20,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(M41t80State, M41T80)
>  
>  struct M41t80State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>      int8_t addr;
>  };
>  
> @@ -31,7 +31,7 @@ static void m41t80_realize(DeviceState *dev, Error
> **errp)
>      s->addr = -1;
>  }
>  
> -static int m41t80_send(I2CSlave *i2c, uint8_t data)
> +static int m41t80_send(I2CTarget *i2c, uint8_t data)
>  {
>      M41t80State *s = M41T80(i2c);
>  
> @@ -43,7 +43,7 @@ static int m41t80_send(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>  
> -static uint8_t m41t80_recv(I2CSlave *i2c)
> +static uint8_t m41t80_recv(I2CTarget *i2c)
>  {
>      M41t80State *s = M41T80(i2c);
>      struct tm now;
> @@ -84,7 +84,7 @@ static uint8_t m41t80_recv(I2CSlave *i2c)
>      }
>  }
>  
> -static int m41t80_event(I2CSlave *i2c, enum i2c_event event)
> +static int m41t80_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      M41t80State *s = M41T80(i2c);
>  
> @@ -97,7 +97,7 @@ static int m41t80_event(I2CSlave *i2c, enum
> i2c_event event)
>  static void m41t80_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc = I2C_TARGET_CLASS(klass);
>  
>      dc->realize = m41t80_realize;
>      sc->send = m41t80_send;
> @@ -107,7 +107,7 @@ static void m41t80_class_init(ObjectClass *klass,
> void *data)
>  
>  static const TypeInfo m41t80_info = {
>      .name          = TYPE_M41T80,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(M41t80State),
>      .class_init    = m41t80_class_init,
>  };
> diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
> index efd19a76e6..d69bb62f51 100644
> --- a/hw/rtc/twl92230.c
> +++ b/hw/rtc/twl92230.c
> @@ -37,7 +37,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(MenelausState, TWL92230)
>  
>  struct MenelausState {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>  
>      int firstbyte;
>      uint8_t reg;
> @@ -134,7 +134,7 @@ static void menelaus_rtc_hz(void *opaque)
>      menelaus_update(s);
>  }
>  
> -static void menelaus_reset(I2CSlave *i2c)
> +static void menelaus_reset(I2CTarget *i2c)
>  {
>      MenelausState *s = TWL92230(i2c);
>  
> @@ -701,7 +701,7 @@ static void menelaus_write(void *opaque, uint8_t
> addr, uint8_t value)
>      }
>  }
>  
> -static int menelaus_event(I2CSlave *i2c, enum i2c_event event)
> +static int menelaus_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      MenelausState *s = TWL92230(i2c);
>  
> @@ -711,7 +711,7 @@ static int menelaus_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>  
> -static int menelaus_tx(I2CSlave *i2c, uint8_t data)
> +static int menelaus_tx(I2CTarget *i2c, uint8_t data)
>  {
>      MenelausState *s = TWL92230(i2c);
>  
> @@ -725,7 +725,7 @@ static int menelaus_tx(I2CSlave *i2c, uint8_t
> data)
>      return 0;
>  }
>  
> -static uint8_t menelaus_rx(I2CSlave *i2c)
> +static uint8_t menelaus_rx(I2CTarget *i2c)
>  {
>      MenelausState *s = TWL92230(i2c);
>  
> @@ -836,7 +836,7 @@ static const VMStateDescription vmstate_menelaus
> = {
>          VMSTATE_STRUCT(rtc.alm, MenelausState, 0,
> vmstate_menelaus_tm,
>                         struct tm),
>          VMSTATE_UINT8(pwrbtn_state, MenelausState),
> -        VMSTATE_I2C_SLAVE(parent_obj, MenelausState),
> +        VMSTATE_I2C_TARGET(parent_obj, MenelausState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -858,7 +858,7 @@ static void twl92230_realize(DeviceState *dev,
> Error **errp)
>  static void twl92230_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc = I2C_TARGET_CLASS(klass);
>  
>      dc->realize = twl92230_realize;
>      sc->event = menelaus_event;
> @@ -869,7 +869,7 @@ static void twl92230_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo twl92230_info = {
>      .name          = TYPE_TWL92230,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(MenelausState),
>      .class_init    = twl92230_class_init,
>  };
> diff --git a/hw/sensor/dps310.c b/hw/sensor/dps310.c
> index 01c776dd7a..bc21024e75 100644
> --- a/hw/sensor/dps310.c
> +++ b/hw/sensor/dps310.c
> @@ -18,7 +18,7 @@
>  
>  typedef struct DPS310State {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>  
>      /*< public >*/
>      uint8_t regs[NUM_REGISTERS];
> @@ -133,7 +133,7 @@ static void dps310_write(DPS310State *s, uint8_t
> reg, uint8_t data)
>      }
>  }
>  
> -static uint8_t dps310_rx(I2CSlave *i2c)
> +static uint8_t dps310_rx(I2CTarget *i2c)
>  {
>      DPS310State *s = DPS310(i2c);
>  
> @@ -144,7 +144,7 @@ static uint8_t dps310_rx(I2CSlave *i2c)
>      }
>  }
>  
> -static int dps310_tx(I2CSlave *i2c, uint8_t data)
> +static int dps310_tx(I2CTarget *i2c, uint8_t data)
>  {
>      DPS310State *s = DPS310(i2c);
>  
> @@ -162,7 +162,7 @@ static int dps310_tx(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>  
> -static int dps310_event(I2CSlave *i2c, enum i2c_event event)
> +static int dps310_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      DPS310State *s = DPS310(i2c);
>  
> @@ -192,7 +192,7 @@ static const VMStateDescription vmstate_dps310 =
> {
>          VMSTATE_UINT8(len, DPS310State),
>          VMSTATE_UINT8_ARRAY(regs, DPS310State, NUM_REGISTERS),
>          VMSTATE_UINT8(pointer, DPS310State),
> -        VMSTATE_I2C_SLAVE(i2c, DPS310State),
> +        VMSTATE_I2C_TARGET(i2c, DPS310State),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -200,7 +200,7 @@ static const VMStateDescription vmstate_dps310 =
> {
>  static void dps310_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      k->event = dps310_event;
>      k->recv = dps310_rx;
> @@ -211,7 +211,7 @@ static void dps310_class_init(ObjectClass *klass,
> void *data)
>  
>  static const TypeInfo dps310_info = {
>      .name          = TYPE_DPS310,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(DPS310State),
>      .class_init    = dps310_class_init,
>  };
> diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
> index 95079558e8..0bc44423b5 100644
> --- a/hw/sensor/emc141x.c
> +++ b/hw/sensor/emc141x.c
> @@ -30,7 +30,7 @@
>  #define SENSORS_COUNT_MAX    4
>  
>  struct EMC141XState {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>      struct {
>          uint8_t raw_temp_min;
>          uint8_t raw_temp_current;
> @@ -42,7 +42,7 @@ struct EMC141XState {
>  };
>  
>  struct EMC141XClass {
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>      uint8_t model;
>      unsigned sensors_count;
>  };
> @@ -184,7 +184,7 @@ static void emc141x_write(EMC141XState *s)
>      }
>  }
>  
> -static uint8_t emc141x_rx(I2CSlave *i2c)
> +static uint8_t emc141x_rx(I2CTarget *i2c)
>  {
>      EMC141XState *s = EMC141X(i2c);
>  
> @@ -196,7 +196,7 @@ static uint8_t emc141x_rx(I2CSlave *i2c)
>      }
>  }
>  
> -static int emc141x_tx(I2CSlave *i2c, uint8_t data)
> +static int emc141x_tx(I2CTarget *i2c, uint8_t data)
>  {
>      EMC141XState *s = EMC141X(i2c);
>  
> @@ -212,7 +212,7 @@ static int emc141x_tx(I2CSlave *i2c, uint8_t
> data)
>      return 0;
>  }
>  
> -static int emc141x_event(I2CSlave *i2c, enum i2c_event event)
> +static int emc141x_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      EMC141XState *s = EMC141X(i2c);
>  
> @@ -232,7 +232,7 @@ static const VMStateDescription vmstate_emc141x =
> {
>          VMSTATE_UINT8(len, EMC141XState),
>          VMSTATE_UINT8(data, EMC141XState),
>          VMSTATE_UINT8(pointer, EMC141XState),
> -        VMSTATE_I2C_SLAVE(parent_obj, EMC141XState),
> +        VMSTATE_I2C_TARGET(parent_obj, EMC141XState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -268,7 +268,7 @@ static void emc141x_initfn(Object *obj)
>  static void emc141x_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      dc->reset = emc141x_reset;
>      k->event = emc141x_event;
> @@ -297,7 +297,7 @@ static void emc1414_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo emc141x_info = {
>      .name          = TYPE_EMC141X,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(EMC141XState),
>      .class_size    = sizeof(EMC141XClass),
>      .instance_init = emc141x_initfn,
> diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
> index 343ff98990..2e2fa74873 100644
> --- a/hw/sensor/lsm303dlhc_mag.c
> +++ b/hw/sensor/lsm303dlhc_mag.c
> @@ -49,7 +49,7 @@ enum LSM303DLHCMagReg {
>  };
>  
>  typedef struct LSM303DLHCMagState {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>      uint8_t cra;
>      uint8_t crb;
>      uint8_t mr;
> @@ -299,7 +299,7 @@ static void
> lsm303dlhc_mag_write(LSM303DLHCMagState *s)
>  /*
>   * Low-level master-to-slave transaction handler.
>   */
> -static int lsm303dlhc_mag_send(I2CSlave *i2c, uint8_t data)
> +static int lsm303dlhc_mag_send(I2CTarget *i2c, uint8_t data)
>  {
>      LSM303DLHCMagState *s = LSM303DLHC_MAG(i2c);
>  
> @@ -321,7 +321,7 @@ static int lsm303dlhc_mag_send(I2CSlave *i2c,
> uint8_t data)
>  /*
>   * Low-level slave-to-master transaction handler (read attempts).
>   */
> -static uint8_t lsm303dlhc_mag_recv(I2CSlave *i2c)
> +static uint8_t lsm303dlhc_mag_recv(I2CTarget *i2c)
>  {
>      LSM303DLHCMagState *s = LSM303DLHC_MAG(i2c);
>      uint8_t resp;
> @@ -412,7 +412,7 @@ static uint8_t lsm303dlhc_mag_recv(I2CSlave *i2c)
>  /*
>   * Bus state change handler.
>   */
> -static int lsm303dlhc_mag_event(I2CSlave *i2c, enum i2c_event event)
> +static int lsm303dlhc_mag_event(I2CTarget *i2c, enum i2c_event
> event)
>  {
>      LSM303DLHCMagState *s = LSM303DLHC_MAG(i2c);
>  
> @@ -444,7 +444,7 @@ static const VMStateDescription
> vmstate_lsm303dlhc_mag = {
>      .minimum_version_id = 0,
>      .fields = (const VMStateField[]) {
>  
> -        VMSTATE_I2C_SLAVE(parent_obj, LSM303DLHCMagState),
> +        VMSTATE_I2C_TARGET(parent_obj, LSM303DLHCMagState),
>          VMSTATE_UINT8(len, LSM303DLHCMagState),
>          VMSTATE_UINT8(buf, LSM303DLHCMagState),
>          VMSTATE_UINT8(pointer, LSM303DLHCMagState),
> @@ -498,7 +498,7 @@ static void
> lsm303dlhc_mag_default_cfg(LSM303DLHCMagState *s)
>   */
>  static void lsm303dlhc_mag_reset(DeviceState *dev)
>  {
> -    I2CSlave *i2c = I2C_SLAVE(dev);
> +    I2CTarget *i2c = I2C_SLAVE(dev);
>      LSM303DLHCMagState *s = LSM303DLHC_MAG(i2c);
>  
>      /* Set the device into its default reset state. */
> @@ -533,7 +533,7 @@ static void lsm303dlhc_mag_initfn(Object *obj)
>  static void lsm303dlhc_mag_class_init(ObjectClass *klass, void
> *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      dc->reset = lsm303dlhc_mag_reset;
>      dc->vmsd = &vmstate_lsm303dlhc_mag;
> @@ -544,7 +544,7 @@ static void lsm303dlhc_mag_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo lsm303dlhc_mag_info = {
>      .name = TYPE_LSM303DLHC_MAG,
> -    .parent = TYPE_I2C_SLAVE,
> +    .parent = TYPE_I2C_TARGET,
>      .instance_size = sizeof(LSM303DLHCMagState),
>      .instance_init = lsm303dlhc_mag_initfn,
>      .class_init = lsm303dlhc_mag_class_init,
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index a8730d0b7f..cc5a9e099e 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -170,7 +170,7 @@ static void tmp105_write(TMP105State *s)
>      }
>  }
>  
> -static uint8_t tmp105_rx(I2CSlave *i2c)
> +static uint8_t tmp105_rx(I2CTarget *i2c)
>  {
>      TMP105State *s = TMP105(i2c);
>  
> @@ -181,7 +181,7 @@ static uint8_t tmp105_rx(I2CSlave *i2c)
>      }
>  }
>  
> -static int tmp105_tx(I2CSlave *i2c, uint8_t data)
> +static int tmp105_tx(I2CTarget *i2c, uint8_t data)
>  {
>      TMP105State *s = TMP105(i2c);
>  
> @@ -199,7 +199,7 @@ static int tmp105_tx(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>  
> -static int tmp105_event(I2CSlave *i2c, enum i2c_event event)
> +static int tmp105_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      TMP105State *s = TMP105(i2c);
>  
> @@ -257,7 +257,7 @@ static const VMStateDescription vmstate_tmp105 =
> {
>          VMSTATE_INT16(temperature, TMP105State),
>          VMSTATE_INT16_ARRAY(limit, TMP105State, 2),
>          VMSTATE_UINT8(alarm, TMP105State),
> -        VMSTATE_I2C_SLAVE(i2c, TMP105State),
> +        VMSTATE_I2C_TARGET(i2c, TMP105State),
>          VMSTATE_END_OF_LIST()
>      },
>      .subsections = (const VMStateDescription * const []) {
> @@ -266,7 +266,7 @@ static const VMStateDescription vmstate_tmp105 =
> {
>      }
>  };
>  
> -static void tmp105_reset(I2CSlave *i2c)
> +static void tmp105_reset(I2CTarget *i2c)
>  {
>      TMP105State *s = TMP105(i2c);
>  
> @@ -285,7 +285,7 @@ static void tmp105_reset(I2CSlave *i2c)
>  
>  static void tmp105_realize(DeviceState *dev, Error **errp)
>  {
> -    I2CSlave *i2c = I2C_SLAVE(dev);
> +    I2CTarget *i2c = I2C_SLAVE(dev);
>      TMP105State *s = TMP105(i2c);
>  
>      qdev_init_gpio_out(&i2c->qdev, &s->pin, 1);
> @@ -303,7 +303,7 @@ static void tmp105_initfn(Object *obj)
>  static void tmp105_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>  
>      dc->realize = tmp105_realize;
>      k->event = tmp105_event;
> @@ -314,7 +314,7 @@ static void tmp105_class_init(ObjectClass *klass,
> void *data)
>  
>  static const TypeInfo tmp105_info = {
>      .name          = TYPE_TMP105,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(TMP105State),
>      .instance_init = tmp105_initfn,
>      .class_init    = tmp105_class_init,
> diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
> index b6f0b62ab1..c7ae40f6ce 100644
> --- a/hw/sensor/tmp421.c
> +++ b/hw/sensor/tmp421.c
> @@ -51,7 +51,7 @@ static const DeviceInfo devices[] = {
>  
>  struct TMP421State {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>  
>      int16_t temperature[4];
> @@ -67,7 +67,7 @@ struct TMP421State {
>  };
>  
>  struct TMP421Class {
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>      DeviceInfo *dev;
>  };
>  
> @@ -224,7 +224,7 @@ static void tmp421_read(TMP421State *s)
>      }
>  }
>  
> -static void tmp421_reset(I2CSlave *i2c);
> +static void tmp421_reset(I2CTarget *i2c);
>  
>  static void tmp421_write(TMP421State *s)
>  {
> @@ -244,7 +244,7 @@ static void tmp421_write(TMP421State *s)
>      }
>  }
>  
> -static uint8_t tmp421_rx(I2CSlave *i2c)
> +static uint8_t tmp421_rx(I2CTarget *i2c)
>  {
>      TMP421State *s = TMP421(i2c);
>  
> @@ -255,7 +255,7 @@ static uint8_t tmp421_rx(I2CSlave *i2c)
>      }
>  }
>  
> -static int tmp421_tx(I2CSlave *i2c, uint8_t data)
> +static int tmp421_tx(I2CTarget *i2c, uint8_t data)
>  {
>      TMP421State *s = TMP421(i2c);
>  
> @@ -274,7 +274,7 @@ static int tmp421_tx(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>  
> -static int tmp421_event(I2CSlave *i2c, enum i2c_event event)
> +static int tmp421_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      TMP421State *s = TMP421(i2c);
>  
> @@ -298,12 +298,12 @@ static const VMStateDescription vmstate_tmp421
> = {
>          VMSTATE_UINT8(status, TMP421State),
>          VMSTATE_UINT8(rate, TMP421State),
>          VMSTATE_INT16_ARRAY(temperature, TMP421State, 4),
> -        VMSTATE_I2C_SLAVE(i2c, TMP421State),
> +        VMSTATE_I2C_TARGET(i2c, TMP421State),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>  
> -static void tmp421_reset(I2CSlave *i2c)
> +static void tmp421_reset(I2CTarget *i2c)
>  {
>      TMP421State *s = TMP421(i2c);
>      TMP421Class *sc = TMP421_GET_CLASS(s);
> @@ -340,7 +340,7 @@ static void tmp421_realize(DeviceState *dev,
> Error **errp)
>  static void tmp421_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>      TMP421Class *sc = TMP421_CLASS(klass);
>  
>      dc->realize = tmp421_realize;
> @@ -366,7 +366,7 @@ static void tmp421_class_init(ObjectClass *klass,
> void *data)
>  
>  static const TypeInfo tmp421_info = {
>      .name          = TYPE_TMP421,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(TMP421State),
>      .class_size    = sizeof(TMP421Class),
>      .abstract      = true,
> diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
> index 4bb09655b4..e0da615fc8 100644
> --- a/hw/tpm/tpm_tis_i2c.c
> +++ b/hw/tpm/tpm_tis_i2c.c
> @@ -36,7 +36,7 @@
>  
>  typedef struct TPMStateI2C {
>      /*< private >*/
> -    I2CSlave    parent_obj;
> +    I2CTarget    parent_obj;
>  
>      uint8_t     offset;       /* offset into data[] */
>      uint8_t     operation;    /* OP_SEND & OP_RECV */
> @@ -303,7 +303,7 @@ static enum TPMVersion
> tpm_tis_i2c_get_tpm_version(TPMIf *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>  
> -static int tpm_tis_i2c_event(I2CSlave *i2c, enum i2c_event event)
> +static int tpm_tis_i2c_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      TPMStateI2C *i2cst = TPM_TIS_I2C(i2c);
>      int ret = 0;
> @@ -336,7 +336,7 @@ static int tpm_tis_i2c_event(I2CSlave *i2c, enum
> i2c_event event)
>   * otherwise it will be handled using single call to common code and
>   * cached in the local buffer.
>   */
> -static uint8_t tpm_tis_i2c_recv(I2CSlave *i2c)
> +static uint8_t tpm_tis_i2c_recv(I2CTarget *i2c)
>  {
>      int          ret = 0;
>      uint32_t     data_read;
> @@ -439,7 +439,7 @@ static uint8_t tpm_tis_i2c_recv(I2CSlave *i2c)
>   * Send function only remembers data in the buffer and then calls
>   * TPM TIS common code during FINISH event.
>   */
> -static int tpm_tis_i2c_send(I2CSlave *i2c, uint8_t data)
> +static int tpm_tis_i2c_send(I2CTarget *i2c, uint8_t data)
>  {
>      TPMStateI2C *i2cst = TPM_TIS_I2C(i2c);
>  
> @@ -534,7 +534,7 @@ static void tpm_tis_i2c_reset(DeviceState *dev)
>  static void tpm_tis_i2c_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k = I2C_TARGET_CLASS(klass);
>      TPMIfClass *tc = TPM_IF_CLASS(klass);
>  
>      dc->realize = tpm_tis_i2c_realizefn;
> @@ -554,7 +554,7 @@ static void tpm_tis_i2c_class_init(ObjectClass
> *klass, void *data)
>  
>  static const TypeInfo tpm_tis_i2c_info = {
>      .name          = TYPE_TPM_TIS_I2C,
> -    .parent        = TYPE_I2C_SLAVE,
> +    .parent        = TYPE_I2C_TARGET,
>      .instance_size = sizeof(TPMStateI2C),
>      .class_init    = tpm_tis_i2c_class_init,
>          .interfaces = (InterfaceInfo[]) {


