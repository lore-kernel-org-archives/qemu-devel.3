Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F10C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 13:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thqjT-0005N9-V1; Tue, 11 Feb 2025 08:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s5.kumari@samsung.com>)
 id 1thpI4-0003tx-4p
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:23:00 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s5.kumari@samsung.com>)
 id 1thpHz-00065C-0s
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:22:59 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250211122243epoutp02eb6d02de2fa2f8c349f877d49e9c0d0f~jJtGxL_aU0854208542epoutp02M
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 12:22:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250211122243epoutp02eb6d02de2fa2f8c349f877d49e9c0d0f~jJtGxL_aU0854208542epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1739276563;
 bh=TGWNpM2ZKsTvZgF9SHocDjG+BrgBd4wjsTUpwQtRVq4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kzdvbZGuaMXUHor1RI/EhWysdaERfzMl89Qi7ZUlfq3Ia3zEt1OFq8LWAfN8ZhnOa
 uxox0UpXzJ7d7V77fgiHBVSkPdxpd451gnxbnrrfcw+kZ7Jx6nM1Oo3uSrIL6KWXA6
 Sl698HYRTUuhz21BKfc2OuZa+wWzTf6zWyu6mDxg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20250211122242epcas5p3fcd92d68123feaafaea3c6521a35c11d~jJtGQ53t-0629106291epcas5p3y;
 Tue, 11 Feb 2025 12:22:42 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4YsgZ92Rjqz4x9Pv; Tue, 11 Feb
 2025 12:22:41 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D1.C5.19933.1114BA76; Tue, 11 Feb 2025 21:22:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250211110814epcas5p380959628ce355b2b9eb5a388c10c0378~jIsE7KrWA1150711507epcas5p3J;
 Tue, 11 Feb 2025 11:08:14 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20250211110814epsmtrp21dcd1cc211740fa17b9a0156ef0dea6f~jIsE6cN0l0682706827epsmtrp2a;
 Tue, 11 Feb 2025 11:08:14 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-35-67ab4111d7ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 8F.C1.33707.E9F2BA76; Tue, 11 Feb 2025 20:08:14 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250211110812epsmtip23a47e8b5a86eed95f4c3e6be433a1b90~jIsDbSTKk3049430494epsmtip2G;
 Tue, 11 Feb 2025 11:08:12 +0000 (GMT)
Date: Tue, 11 Feb 2025 16:37:50 +0530
From: Sweta Kumari <s5.kumari@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 1/1] Added support for get/set alert configuration commands
Message-ID: <20250211110750.4ldvuzxc2cezgwsm@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250204111541.00002ef0@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmlq6g4+p0g4cr+S2mH1a0+HJ6D5vF
 6ptrGC1uHtjJZLFq4TU2i4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu0XLkLavH
 k2ubmTz6tqxi9Jg6u97j8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
 JYW8xNxUWyUXnwBdt8wcoMOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrF
 ibnFpXnpenmpJVaGBgZGpkCFCdkZWxesYStYE16x69wK1gbGK45djJwcEgImEk3HZrJ1MXJx
 CAnsZpQ4d+wSO4TziVHi3bqPLHDO3bmPWGFaDq98zwqR2MkocWnCOoSWvWtmMINUsQioSnxa
 doQdxGYT0JL48fkBWFxEwEji3Y1JjCANzAI3GSUaJz1jA0kICwRKvOx7ywhi8wo4Syze9ZkN
 whaUODnzCQuIzSlgKHH6+U4mkGYJgVYOiY/nzkDd5CIxq/kuC4QtLPHq+BZ2CFtK4vO7vWwQ
 drbE3a2dUHaJxIfbu5kgbHuJ1lP9YNcxC2RIbPvdAjVHVmLqqXVMEHE+id7fT6DqeSV2zIOx
 lSW2/FsOdYOkxIrPS6BsD4mZT5uZIMHyjFFi9azzzBMY5WYheWgWkn0QtpVE54cm1lmMHEC2
 tMTyfxwQpqbE+l36CxhZVzFKphYU56anFpsWGOWllsPjOTk/dxMjOLlqee1gfPjgg94hRiYO
 xkOMEhzMSiK8JgtXpAvxpiRWVqUW5ccXleakFh9iNAXG0ERmKdHkfGB6zyuJNzSxNDAxMzMz
 sTQ2M1QS523e2ZIuJJCeWJKanZpakFoE08fEwSnVwKQqoTchM2OxnNYp9+u7ZpycfeFn+9EZ
 aWkftj/QPWfJP0PC9st29sn+JR2qf66/f7q1uNlMVrBrwfnNBzsbLkad1t61WL9F7NuWc/oN
 G5KFrsks4mA6fOXbq+Yft/ODz7y5kLFubapQ0vZpXcf5rm43rJi+6XVpCM8E+4yqn1O+hU+R
 PyY4X+OEe3mYvKmBp9xNJ26Zdhbuh6Z++htzHk522CX64nCJ1uO+UPnfIdMt4m8ffekZKPxn
 /bb995ZNt3K5sO/6/oWvCteuO9c6VyZ+heninXFNHLWpM10rt+55y7ho1xrVzf+1NjxYv+3Q
 fifrqZzeRp6p12e1l3kxvqwSWpdjEM+42J/DtreHJVhFiaU4I9FQi7moOBEAebMIVjcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvO48/dXpBk++C1hMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLVwmtsFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfdo+XIW1aP
 J9c2M3n0bVnF6DF1dr3H501yAWxRXDYpqTmZZalF+nYJXBnTdx5jK7gXUrH21yvGBsYF9l2M
 nBwSAiYSh1e+Z+1i5OIQEtjOKPHrcRsbREJS4u2ZS4wQtrDEyn/P2SGKPjBKHLxzjwUkwSKg
 KvFp2RF2EJtNQEvix+cHzCC2iICRxLsbkxhBGpgFbjNK/N4N0SAsECjxsu8t2FReAWeJxbs+
 g20TEnjGKLHirwZEXFDi5MwnYPXMAmYS8zY/BBrKAWRLSyz/xwES5hQwlDj9fCfTBEaBWUg6
 ZiHpmIXQsYCReRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcCRoBe1gXLb+r94hRiYOxkOM
 EhzMSiK8JgtXpAvxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFw
 SjUwST2dtu53S3CwG7uxjElyzcaNUpIzbzh39K5env5hYaz/pbdFRysdGh/Y5EZ/6/Cd87ek
 PuFpZIBZ0oqp/nr5JwzP+317FJkidfXJ5elnuwqkO5ZNDlIVOx/5+81/izarNlWOK1Pi42Wq
 3hZKRR6zNrrLW7985dyOP7ufnr21+PmRgl6Fi+oOjxqytwv1JPtMZHFk2zxvr33KXuXwl1VH
 9xYfz/nq0iGivWp7R5uFUeDCzMssCrPPOE/I/GTw746d8WUDj77w58kql5PE5KtUFZZfmxDw
 xOzv4R9rl+faLy0S2R0qem7VezWed4fnG6W65oZ++3rlilo2x+MLkr9NnsU42M447u13UDlJ
 z2q1EktxRqKhFnNRcSIAlDGANfMCAAA=
X-CMS-MailID: 20250211110814epcas5p380959628ce355b2b9eb5a388c10c0378
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----knAlFONTECbX-FcfvlefBkarukSN3r7qQKLuxxl86w44aglH=_469ef_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611
References: <20250203114445.64088-1-s5.kumari@samsung.com>
 <CGME20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611@epcas5p3.samsung.com>
 <20250203114445.64088-2-s5.kumari@samsung.com>
 <20250204111541.00002ef0@huawei.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=s5.kumari@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Feb 2025 08:55:20 -0500
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

------knAlFONTECbX-FcfvlefBkarukSN3r7qQKLuxxl86w44aglH=_469ef_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/02/25 11:15AM, Jonathan Cameron wrote:
>On Mon,  3 Feb 2025 17:14:45 +0530
>Sweta Kumari <s5.kumari@samsung.com> wrote:
>
>> Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
>> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
>> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
>Hi Sweta,
>
>Thanks for the patch. Great to see someone working on these
>features.   As in previous thread, in general RB tags that are
>given before public posting aren't really very useful.  Reviews
>can mean very different things in different companies / groups within
>them.  Much prefer to see a final round of review done on the public
>mailing list if possible.
>
>Various comments inline.
>
>Jonathan
>
Hi Jonathan,

Thank you for the feedback. I'll fix this in V2 patch.
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 91 +++++++++++++++++++++++++++++++++++++
>>  hw/mem/cxl_type3.c          | 20 ++++++++
>>  include/hw/cxl/cxl_device.h | 24 ++++++++++
>>  3 files changed, 135 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 9c7ea5bc35..7a054c059d 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -86,6 +86,9 @@ enum {
>>          #define GET_PARTITION_INFO     0x0
>>          #define GET_LSA       0x2
>>          #define SET_LSA       0x3
>> +    HEALTH_INFO_ALERTS = 0x42,
>> +        #define GET_ALERT_CONFIGURATION 0x1
>> +        #define SET_ALERT_CONFIGURATION 0x2
>>      SANITIZE    = 0x44,
>>          #define OVERWRITE     0x0
>>          #define SECURE_ERASE  0x1
>> @@ -1625,6 +1628,90 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +/* CXL r3.1 Section 8.2.9.9.3.2 Get Alert Configuration (Opcode 4201h) */
>
>For new commands, preference is for spec references being to
>the latest spec as that's the one that is downloadable via a click through
>on the website.
>
Ok, Will fix it in V2 patch.
>> +static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
>> +                                   uint8_t *payload_in,
>
>Align immediate after ( unless we have very long lines.
>
>> +                                   size_t len_in,
>> +                                   uint8_t *payload_out,
>> +                                   size_t *len_out,
>> +                                   CXLCCI *cci)
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLAlertConfig *out = (void *)payload_out;
>
>blank line here.
>
Ok.
>> +    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
>> +    *len_out = sizeof(ct3d->alert_config);
>
>blank line here.
>
Ok.
>> +    return CXL_MBOX_SUCCESS;
>> +
>> +}
>> +
>> +/* CXL r3.1 Section 8.2.9.9.3.3 Set Alert Configuration (Opcode 4202h) */
>> +static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
>> +                                   uint8_t *payload_in,
>> +                                   size_t len_in,
>> +                                   uint8_t *payload_out,
>> +                                   size_t *len_out,
>> +                                   CXLCCI *cci)
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
>> +    struct {
>> +        CXLValidEnableAlerts valid_alert_actions;
>> +        CXLValidEnableAlerts enable_alert_actions;
>
>uint8_t for both of these + defines.
>
>> +        uint8_t lupwt;
>
>Longer names here as below.
>
Ok, I'll update both with defines and longer names as suggested.
>> +        uint8_t reserve;
>> +        uint16_t dotpwt;
>> +        uint16_t dutpwt;
>> +        uint16_t cvmepwt;
>> +        uint16_t cpmepwt;
>> +    } QEMU_PACKED *in = (void *)payload_in;
>> +
>> +    if (in->valid_alert_actions.lupwt) {
>> +        if ((in->lupwt > 100) || (in->lupwt >= alert_config->lucat)) {
>
>Add a spec reference for these constraints. Looks like they
>are in the get alert configuration output table.
>
Ok, as you mentioned, I'll remove the if (in->lupwt > 100) check and
retain only the if (in->lupwt >= alert_config->lucat) check.
As per CXL spec 3.2. The life used warning threshold shall be less than
the life used critical alert value.
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +
>> +        if (in->enable_alert_actions.lupwt) {
>> +            alert_config->lupwt = in->lupwt;
>
>That's interesting.  Do we only write it when enabled. I would have
>thought valid was enough.  Spec reference in a comment would help
>for this first case at least. No need to replicate in the
>others if it is a common thing.
>
>
Based on your feedback, I'll remove the checks for enable alert actions and
rely only on valid alert actions to determine if the field should be processed,
as it is sufficient for this operation
>> +        }
>> +        alert_config->enable_alerts.lupwt = in->enable_alert_actions.lupwt;
>> +    }
>> +
>> +    if (in->valid_alert_actions.dotpwt) {
>> +        if (in->dotpwt >= alert_config->dotcat) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        if (in->enable_alert_actions.dotpwt) {
>> +            alert_config->dotpwt = in->dotpwt;
>> +        }
>> +        alert_config->enable_alerts.dotpwt = in->enable_alert_actions.dotpwt;
>> +    }
>> +
>> +    if (in->valid_alert_actions.dutpwt) {
>> +        if (in->dutpwt < alert_config->dutcat) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        if (in->enable_alert_actions.dutpwt) {
>> +            alert_config->dutpwt = in->dutpwt;
>> +        }
>> +        alert_config->enable_alerts.dutpwt = in->enable_alert_actions.dutpwt;
>> +    }
>> +
>> +    if (in->valid_alert_actions.cvmepwt) {
>> +        if (in->enable_alert_actions.cvmepwt) {
>> +            alert_config->cvmepwt = in->cvmepwt;
>> +        }
>> +        alert_config->enable_alerts.cvmepwt = in->valid_alert_actions.cvmepwt;
>> +    }
>> +
>> +    if (in->valid_alert_actions.cpmepwt) {
>> +        if (in->enable_alert_actions.cpmepwt) {
>> +            alert_config->cpmepwt = in->cpmepwt;
>> +        }
>> +        alert_config->enable_alerts.cpmepwt = in->valid_alert_actions.cpmepwt;
>> +    }
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  /* Perform the actual device zeroing */
>>  static void __do_sanitization(CXLType3Dev *ct3d)
>>  {
>> @@ -2859,6 +2946,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>>          ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
>> +    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIGURATION] = {"GET_ALERT_CONFIGURATION",
>> +        cmd_get_alert_config, 0, 0 },
>> +    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIGURATION] = {"SET_ALERT_CONFIGURATION",
>> +        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>>      [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
>>          (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>>           CXL_MBOX_SECURITY_STATE_CHANGE |
>> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>> index 5f365afb4d..ce5a4962da 100644
>> --- a/hw/mem/cxl_type3.c
>> +++ b/hw/mem/cxl_type3.c
>> @@ -956,6 +956,25 @@ static DOEProtocol doe_comp_prot[] = {
>>      { }
>>  };
>>
>> +/*
>> + * Initialize CXL device alerts with default threshold values.
>> + */
>> +static void init_alert_config(CXLType3Dev *ct3d)
>> +{
>> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
>> +
>> +    memset(&alert_config->valid_alerts, 0, sizeof(CXLValidEnableAlerts));
>> +    memset(&alert_config->enable_alerts, 0, sizeof(CXLValidEnableAlerts));
>> +    alert_config->lucat = 75;
>> +    alert_config->lupwt = 0;
>> +    alert_config->dotcat = 35;
>> +    alert_config->dutcat = 10;
>> +    alert_config->dotpwt = 25;
>> +    alert_config->dutpwt = 20;
>> +    alert_config->cvmepwt = 0;
>> +    alert_config->cpmepwt = 0;
>Easier to read as
>      ct3d_alert_config = (CXLAlertConfig) {
>          .life_used_critical_thresh = 75,
>...
>
>You can skip anything where a default of 0 is an obvious default.
>Perhaps the valid_alerts and enable alerts for instance.
>
Ok, I'll address this in V2 patch.
>      };
>> +}
>> +
>>  void ct3_realize(PCIDevice *pci_dev, Error **errp)
>>  {
>>      ERRP_GUARD();
>> @@ -1030,6 +1049,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
>>          goto err_free_special_ops;
>>      }
>>
>> +    init_alert_config(ct3d);
>>      pcie_cap_deverr_init(pci_dev);
>>      /* Leave a bit of room for expansion */
>>      rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index a64739be25..6acae7d74d 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -581,6 +581,28 @@ typedef struct CXLSetFeatureInfo {
>>      size_t data_size;
>>  } CXLSetFeatureInfo;
>>
>> +typedef struct CXLValidEnableAlerts {
>> +    uint8_t lupwt:1;
>
>Give these longer names.
>life_used_warning_threshold etc
>etc as we don't want to go find the spec to figure
>out what they are.
>
>
Ok, I'll update this in V2 patch.
>> +    uint8_t dotpwt:1;
>> +    uint8_t dutpwt:1;
>> +    uint8_t cvmepwt:1;
>> +    uint8_t cpmepwt:1;
>> +    uint8_t reserved:3;
>
>Generally bit fields do not play well with potential endian
>variations or low level code in general.  There is too much
>flexibility in how they are stored.  So better to use a
>uint8_t and some defines for the bits that are set.
>
>
Ok.
>> +} CXLValidEnableAlerts;
>> +
>> +typedef struct CXLAlertConfig {
>> +    CXLValidEnableAlerts valid_alerts;
>> +    CXLValidEnableAlerts enable_alerts;
>> +    uint8_t lucat;
>Longer names.  These want to be at least vaguely comprehensible
>without the spec in front of us.
>lif_used_critical_thresh
>life_used_warning_thresh (I'm not sure why programmable matters!)
>etc
>
Ok, will fix this in V2 patch.
>> +    uint8_t lupwt;
>> +    uint16_t dotcat;
>> +    uint16_t dutcat;
>> +    uint16_t dotpwt;
>> +    uint16_t dutpwt;
>> +    uint16_t cvmepwt;
>> +    uint16_t cpmepwt;
>> +} QEMU_PACKED CXLAlertConfig;
>> +
>>  struct CXLType3Dev {
>>      /* Private */
>>      PCIDevice parent_obj;
>> @@ -605,6 +627,8 @@ struct CXLType3Dev {
>>      CXLCCI vdm_fm_owned_ld_mctp_cci;
>>      CXLCCI ld0_cci;
>>
>> +    CXLAlertConfig alert_config;
>> +
>>      /* PCIe link characteristics */
>>      PCIExpLinkSpeed speed;
>>      PCIExpLinkWidth width;
>

------knAlFONTECbX-FcfvlefBkarukSN3r7qQKLuxxl86w44aglH=_469ef_
Content-Type: text/plain; charset="utf-8"


------knAlFONTECbX-FcfvlefBkarukSN3r7qQKLuxxl86w44aglH=_469ef_--

