Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4779C25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD06D-0003n4-Eb; Fri, 31 May 2024 07:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sD06A-0003mB-U4
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:07:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sD063-0000ji-0o
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:07:02 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240531110644epoutp045c6c8463902efdad244fd266600e084c~UjhsUDAuE0069000690epoutp04N
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 11:06:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240531110644epoutp045c6c8463902efdad244fd266600e084c~UjhsUDAuE0069000690epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1717153604;
 bh=hePVaZXMUOeM4IgRoaEfKBGLFixv+APcZxndAoLbeL0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dqNR1jefxDMaJvQDvFSz4VC+MYWvLAWCN7usTzsEXADuEOzM9lYHLCNvSapq6HX8r
 k9ETybDcz4KfT//8hGQx8GjcyxAkXJJEyQsk3Q68SXa16nnbMT9J6CxBFbHbA29WPq
 AXkJy990BSGHOGV0oBaRuzj81R7ms4XNnqA4DYYo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20240531110644epcas2p28166c655da9f079630a8e4cc8526a2b3~Ujhr0bVzl0146301463epcas2p2R;
 Fri, 31 May 2024 11:06:44 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VrL0g5LFxz4x9Pt; Fri, 31 May
 2024 11:06:43 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 81.99.09485.34FA9566; Fri, 31 May 2024 20:06:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20240531110643epcas2p2468e2706ee10986498c988e98002cfed~Ujhq1IAcT0132001320epcas2p2W;
 Fri, 31 May 2024 11:06:43 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240531110643epsmtrp1e25336c7223c0f5221c8b6eefe790a9b~Ujhq0V4EI0637006370epsmtrp1v;
 Fri, 31 May 2024 11:06:43 +0000 (GMT)
X-AuditID: b6c32a46-19bfa7000000250d-51-6659af431c01
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 7A.83.18846.34FA9566; Fri, 31 May 2024 20:06:43 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240531110642epsmtip2235bc0f7c6317c21bb31bd4a9c887cf2~Ujhqiyz8a0781107811epsmtip2H;
 Fri, 31 May 2024 11:06:42 +0000 (GMT)
Date: Fri, 31 May 2024 19:55:23 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Minwoo Im <minwoo.im@samsung.com>
Subject: Re: [PATCH v4 09/10] hw/nvme: add reservation protocal command
Message-ID: <Zlmsm1vZS97egpk1@localhost>
MIME-Version: 1.0
In-Reply-To: <20240531033455.3774806-10-luchangqi.123@bytedance.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPb3t7YWly7XgdqzR1DKcQ+la5HGZw6kQdpPNQDRu02SyK720
 2Ke9LY8ZF+JjPAQ6sCyjEwZ7IYTJZKxSUB4dDJBAEWmdD5BtZDymsDbLhgTQlosL/31+3/we
 53t+52CIcBQVYZk6E23UURoJGsy1X9sRE5nY9E6GrKxqGzHW6QJEv/UAMTluAURn9wMeUe70
 AOL8TzRRUTjGJe4MdiFEp32VRzR+HULMXpziEN6qaj5hm89Hib6SVi5RUurjEXfL/+W9ipOr
 /Y0oaT3p4ZMlnYfIxeF8lHTYxvnkcKuLTzY3FKLkH57vUXLKc4VDLnS4UbK0pQGkbnpXvVtF
 UwraKKZ16XpFpk6ZINn3VlpiWkysTB4pjyfiJGIdpaUTJEn7UyOTMzV+OxJxFqUx+6VUimEk
 O1/ZbdSbTbRYpWdMCRLaoNAY4gxShtIyZp1SqqNNu+QyWVSMP/GIWnXOcRE12IpAjveCG80D
 J9KLQBAG8WjozrvJKwLBmBBvBbD43gKfDXwA3h9wIY+CoYpL/gBbK2m9nMTqDgBvdbavV0wD
 2GA/ywn05eLh0Nl/nhdgFN8O8yrmuAEOxV+EKw0+NMAIfp0DG5d1AQ7B98K64gkkwAL8eXhq
 eg6w/DgcqJxaqw3Ck6Br5gc0MAziNzBY7ZvisCaS4MyQD7AcAuf6Wvgsi+Cs5fg6Z8N//ipf
 z8mB3bbfUdbNHuiZVrDnUcHZvmo+K4fBnt+4rLwZFlxbWZcFsOC4kG0SBr1OJ8Lyk7Bu9C7K
 MgnLTnah7JWMAFhWM8w/AZ6xbXBj2zDN5m+L4DtgU9tOFp+CdavYBrUG8BrAFtrAaJU0E2WI
 erTfdL22Gaw97ojkVmD9+57UCTgYcAKIIZJQwZLyUIZQoKByj9JGfZrRrKEZJ4jxb6YMET2R
 rvf/Dp0pTR4dL4uOjZXHRcXI4iRbBROfVymEuJIy0WqaNtDG/+s4WJAoj5P1WAc2HpJ7tVYo
 qD1b6w2fko9893bl1uD735KK0fdHei5f6vik+YCV+TilfdW37OqRUhf2ceY2/Wk8xpFuc8lu
 pr48VPDZ6awH8nKP3vyCOehor1l0jHLHLyxl7Blqy2467e4OH3nvhvZT6Y+LY990O/aWPoyX
 zqtvuw9ukVkmDycWn1uyvDb/Bv0FbznXHvfh4pnnrth+Dq1fKfIuuiuzxUq1+tf6sJnN7aOO
 wZSn29oLre5dc0e+KunSPPtlxAABPvrAuWLVvt5/VdpbizyMqr89dmq7JceuL7klfUllp+nr
 DHEw/s5ETeOkpzd5/5n8CLFDGeRIObzQ8gvGRTSDb0q4jIqSRyBGhvoPFK3rbWUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSvK7z+sg0gxeN7BZX9p9ntDgxJczi
 wd1+Rov9B7+xWkw6dI3RYsnFVIupnVdYLJ6dPsBssX/bP1aLNSuELV4ue8Jk8XHuPHaLWe/a
 2SyO9+5gsejt+8Rq8XrSf1YHAY9/J9aweUyZdo3do3d/hMePc+1sHjtn3WX3OLfjPLvHplWd
 bB53ru1h83hybTOTx/t9V9k8+rasYgzgjuKySUnNySxLLdK3S+DKmN03g63gbjtjxcTVG9gb
 GN8kdDFycEgImEjs2ODSxcjFISSwnVHi9pZzjF2MnEBxSYl9p2+yQtjCEvdbjrBCFD1llFh3
 7AMzSIJFQFXi0IklYEVsAuoSDVNfsYDYIgI6En9XfWIDaWAWOMEk8XjZYrCEsIC7xPKee2DN
 vAIaEjOev2KEmHqBUaJnxTGohKDEyZlPwBqYgab+mXeJGeRUZgFpieX/OEDCnAIuEudf7GWb
 wCgwC0nHLCQdsxA6FjAyr2IUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIjjutoB2My9b/1TvE
 yMTBeIhRgoNZSYT3V3pEmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILU
 IpgsEwenVANTKP+yMtlHywLWtO90un9uueHN4N2/c+d9Pf7qQg9L0L54S4VXZrOaircrJas9
 eDZ35oHsvtY//SLv5Q0Ob5rOzsZVkvnwZMqMlqvV8bk//p77Gsxi+27G/BDFNT/yuwycTylG
 tXO9W+ffvW/2VzvvJQkrVES4/zOK3HvEy/zznPwiha3mc7a7HDj7t+ClbT7/6i0zLeR5Ot7a
 n9y0+jTXr6raWdpWf44xGp54pGjw806Ex/YjL8/qOYg+vjC1mlVs7aJS2ya1xU9DfbynWv5f
 eLk87OCzv6Uu0w8v8v6yUvD+wyTebA3xTpXOfqHSw/JtLX/Xz7KfMXFBnJJGsdL1SS9Utn4O
 KOp+Ljq9VbhDQ4mlOCPRUIu5qDgRALgTc1sqAwAA
X-CMS-MailID: 20240531110643epcas2p2468e2706ee10986498c988e98002cfed
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----3ZSP372dp81iX4EJ00Z5Ife_kMxy1Qk5ObWSk-4J55_.bDLc=_266c2_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531033753epcas2p1e3233d35e3192fb2e1cafc02b6c53a7a
References: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
 <CGME20240531033753epcas2p1e3233d35e3192fb2e1cafc02b6c53a7a@epcas2p1.samsung.com>
 <20240531033455.3774806-10-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=minwoo.im@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

------3ZSP372dp81iX4EJ00Z5Ife_kMxy1Qk5ObWSk-4J55_.bDLc=_266c2_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On 24-05-31 11:34:54, Changqi Lu wrote:
> Add reservation acquire, reservation register,
> reservation release and reservation report commands
> in the nvme device layer.
> 
> By introducing these commands, this enables the nvme
> device to perform reservation-related tasks, including
> querying keys, querying reservation status, registering
> reservation keys, initiating and releasing reservations,
> as well as clearing and preempting reservations held by
> other keys.
> 
> These commands are crucial for management and control of
> shared storage resources in a persistent manner.
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ctrl.c       | 321 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   4 +
>  include/block/nvme.h |  37 +++++
>  3 files changed, 361 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 182307a48b..033abd0afe 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -294,6 +294,10 @@ static const uint32_t nvme_cse_iocs_nvm[256] = {
>      [NVME_CMD_COMPARE]              = NVME_CMD_EFF_CSUPP,
>      [NVME_CMD_IO_MGMT_RECV]         = NVME_CMD_EFF_CSUPP,
>      [NVME_CMD_IO_MGMT_SEND]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
> +    [NVME_CMD_RESV_REGISTER]        = NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REPORT]          = NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_ACQUIRE]         = NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_RELEASE]         = NVME_CMD_EFF_CSUPP,
>  };
>  
>  static const uint32_t nvme_cse_iocs_zoned[256] = {
> @@ -308,6 +312,10 @@ static const uint32_t nvme_cse_iocs_zoned[256] = {
>      [NVME_CMD_ZONE_APPEND]          = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
>      [NVME_CMD_ZONE_MGMT_SEND]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
>      [NVME_CMD_ZONE_MGMT_RECV]       = NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REGISTER]        = NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_REPORT]          = NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_ACQUIRE]         = NVME_CMD_EFF_CSUPP,
> +    [NVME_CMD_RESV_RELEASE]         = NVME_CMD_EFF_CSUPP,
>  };
>  
>  static void nvme_process_sq(void *opaque);
> @@ -1745,6 +1753,7 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
>  
>      switch (req->cmd.opcode) {
>      case NVME_CMD_READ:
> +    case NVME_CMD_RESV_REPORT:
>          status = NVME_UNRECOVERED_READ;
>          break;
>      case NVME_CMD_FLUSH:
> @@ -1752,6 +1761,9 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
>      case NVME_CMD_WRITE_ZEROES:
>      case NVME_CMD_ZONE_APPEND:
>      case NVME_CMD_COPY:
> +    case NVME_CMD_RESV_REGISTER:
> +    case NVME_CMD_RESV_ACQUIRE:
> +    case NVME_CMD_RESV_RELEASE:
>          status = NVME_WRITE_FAULT;
>          break;
>      default:
> @@ -2127,7 +2139,10 @@ static inline bool nvme_is_write(NvmeRequest *req)
>  
>      return rw->opcode == NVME_CMD_WRITE ||
>             rw->opcode == NVME_CMD_ZONE_APPEND ||
> -           rw->opcode == NVME_CMD_WRITE_ZEROES;
> +           rw->opcode == NVME_CMD_WRITE_ZEROES ||
> +           rw->opcode == NVME_CMD_RESV_REGISTER ||
> +           rw->opcode == NVME_CMD_RESV_ACQUIRE ||
> +           rw->opcode == NVME_CMD_RESV_RELEASE;
>  }
>  
>  static void nvme_misc_cb(void *opaque, int ret)
> @@ -2692,6 +2707,302 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
>      return NVME_NO_COMPLETE;
>  }
>  
> +typedef struct NvmeKeyInfo {
> +    uint64_t cr_key;
> +    uint64_t nr_key;
> +} NvmeKeyInfo;
> +
> +static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    NvmeKeyInfo key_info;
> +    NvmeNamespace *ns = req->ns;
> +    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
> +    bool ignore_key = cdw10 >> 3 & 0x1;
> +    uint8_t action = cdw10 & 0x7;
> +    uint8_t ptpl = cdw10 >> 30 & 0x3;
> +    bool aptpl;
> +
> +    switch (ptpl) {
> +    case NVME_RESV_PTPL_NO_CHANGE:
> +        aptpl = (ns->id_ns.rescap & NVME_PR_CAP_PTPL) ? true : false;
> +        break;
> +    case NVME_RESV_PTPL_DISABLE:
> +        aptpl = false;
> +        break;
> +    case NVME_RESV_PTPL_ENABLE:
> +        aptpl = true;
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    ret = nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    switch (action) {
> +    case NVME_RESV_REGISTER_ACTION_REGISTER:
> +        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, 0,
> +                                         key_info.nr_key, 0, aptpl,
> +                                         ignore_key, nvme_misc_cb,
> +                                         req);
> +        break;
> +    case NVME_RESV_REGISTER_ACTION_UNREGISTER:
> +        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, key_info.cr_key, 0,
> +                                         0, aptpl, ignore_key,
> +                                         nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_REGISTER_ACTION_REPLACE:
> +        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, key_info.cr_key,
> +                                         key_info.nr_key, 0, aptpl, ignore_key,
> +                                         nvme_misc_cb, req);
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
> +static uint16_t nvme_resv_release(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    uint64_t cr_key;
> +    NvmeNamespace *ns = req->ns;
> +    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint8_t action = cdw10 & 0x7;
> +    NvmeResvType type = cdw10 >> 8 & 0xff;
> +
> +    ret = nvme_h2c(n, (uint8_t *)&cr_key, sizeof(cr_key), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    switch (action) {
> +    case NVME_RESV_RELEASE_ACTION_RELEASE:
> +        req->aiocb = blk_aio_pr_release(ns->blkconf.blk, cr_key,
> +                                        nvme_pr_type_to_block(type),
> +                                        nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_RELEASE_ACTION_CLEAR:
> +        req->aiocb = blk_aio_pr_clear(ns->blkconf.blk, cr_key,
> +                                      nvme_misc_cb, req);
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
> +static uint16_t nvme_resv_acquire(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    NvmeKeyInfo key_info;
> +    NvmeNamespace *ns = req->ns;
> +    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint8_t action = cdw10 & 0x7;
> +    NvmeResvType type = cdw10 >> 8 & 0xff;
> +
> +    ret = nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    switch (action) {
> +    case NVME_RESV_ACQUIRE_ACTION_ACQUIRE:
> +        req->aiocb = blk_aio_pr_reserve(ns->blkconf.blk, key_info.cr_key,
> +                                        nvme_pr_type_to_block(type),
> +                                        nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_ACQUIRE_ACTION_PREEMPT:
> +        req->aiocb = blk_aio_pr_preempt(ns->blkconf.blk,
> +                     key_info.cr_key, key_info.nr_key,
> +                     nvme_pr_type_to_block(type),
> +                     false, nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT:
> +        req->aiocb = blk_aio_pr_preempt(ns->blkconf.blk, key_info.cr_key,
> +                                        key_info.nr_key, type, true,
> +                                        nvme_misc_cb, req);
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
> +typedef struct NvmeResvKeys {
> +    uint32_t generation;
> +    uint32_t num_keys;
> +    uint64_t *keys;
> +    NvmeRequest *req;
> +} NvmeResvKeys;
> +
> +typedef struct NvmeReadReservation {
> +    uint32_t generation;
> +    uint64_t key;
> +    BlockPrType type;
> +    NvmeRequest *req;
> +    NvmeResvKeys *keys_info;
> +} NvmeReadReservation;
> +
> +static int nvme_read_reservation_cb(NvmeReadReservation *reservation)
> +{
> +    int rc;
> +    NvmeReservationStatus *nvme_status;
> +    NvmeRequest *req = reservation->req;
> +    NvmeCtrl *n = req->sq->ctrl;
> +    NvmeResvKeys *keys_info = reservation->keys_info;
> +    int len = sizeof(NvmeReservationStatusHeader) +
> +              sizeof(NvmeRegisteredCtrl) * keys_info->num_keys;
> +
> +    nvme_status = g_malloc(len);
> +    nvme_status->header.gen = reservation->generation;
> +    nvme_status->header.rtype = block_pr_type_to_nvme(reservation->type);
> +    nvme_status->header.regctl = keys_info->num_keys;
> +    for (int i = 0; i < keys_info->num_keys; i++) {
> +        nvme_status->regctl_ds[i].cntlid = nvme_ctrl(req)->cntlid;
> +        nvme_status->regctl_ds[i].rkey = keys_info->keys[i];
> +        nvme_status->regctl_ds[i].rcsts = keys_info->keys[i] ==
> +                                          reservation->key ? 1 : 0;
> +        /* hostid is not supported currently */
> +        memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
> +    }
> +
> +    rc = nvme_c2h(n, (uint8_t *)nvme_status, len, req);
> +    g_free(nvme_status);
> +    return rc;
> +}
> +
> +static int nvme_read_reservation_ext_cb(NvmeReadReservation *reservation)
> +{
> +    int rc;
> +    NvmeReservationStatusExt *nvme_status_ext;
> +    NvmeRequest *req = reservation->req;
> +    NvmeCtrl *n = req->sq->ctrl;
> +    NvmeResvKeys *keys_info = reservation->keys_info;
> +    int len = sizeof(NvmeReservationStatusHeader) +
> +              sizeof(uint8_t) * 40 +
> +              sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
> +
> +    nvme_status_ext = g_malloc(len);
> +    nvme_status_ext->header.gen = cpu_to_be32(reservation->generation);
> +    nvme_status_ext->header.rtype = block_pr_type_to_nvme(reservation->type);
> +    nvme_status_ext->header.regctl = cpu_to_be16(keys_info->num_keys);
> +
> +    for (int i = 0; i < keys_info->num_keys; i++) {
> +        uint16_t ctnlid = nvme_ctrl(req)->cntlid;
> +        nvme_status_ext->regctl_eds[i].cntlid = cpu_to_be16(ctnlid);
> +        nvme_status_ext->regctl_eds[i].rkey = cpu_to_be64(keys_info->keys[i]);
> +        nvme_status_ext->regctl_eds[i].rcsts = keys_info->keys[i] ==
> +                                               reservation->key ? 1 : 0;
> +        /* hostid is not supported currently */
> +        memset(&nvme_status_ext->regctl_eds[i].hostid, 0, 16);
> +    }
> +
> +    rc = nvme_c2h(n, (uint8_t *)nvme_status_ext, len, req);
> +    g_free(nvme_status_ext);
> +    return rc;
> +}
> +
> +static void nvme_resv_read_reservation_cb(void *opaque, int ret)
> +{
> +    NvmeReadReservation *reservation = opaque;
> +    NvmeRequest *req = reservation->req;
> +    bool eds = req->cmd.cdw11 & 0x1;
> +    NvmeResvKeys *keys_info = reservation->keys_info;
> +
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    if (eds) {
> +        ret = nvme_read_reservation_ext_cb(reservation);
> +    } else {
> +        ret = nvme_read_reservation_cb(reservation);
> +    }
> +
> +out:
> +    g_free(keys_info);
> +    g_free(reservation);
> +    nvme_misc_cb(req, ret);
> +}
> +
> +static void nvme_resv_read_keys_cb(void *opaque, int ret)
> +{
> +    NvmeResvKeys *keys_info = opaque;
> +    NvmeRequest *req = keys_info->req;
> +    NvmeNamespace *ns = req->ns;
> +    NvmeReadReservation *reservation;
> +
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    keys_info->num_keys = MIN(ret, keys_info->num_keys);
> +    reservation = g_new0(NvmeReadReservation, 1);
> +    memset(reservation, 0, sizeof(*reservation));
> +    reservation->req = req;
> +    reservation->keys_info = keys_info;
> +
> +    req->aiocb = blk_aio_pr_read_reservation(ns->blkconf.blk,
> +                 &reservation->generation, &reservation->key,
> +                 &reservation->type, nvme_resv_read_reservation_cb,
> +                 reservation);
> +    return;
> +
> +out:
> +    g_free(keys_info);
> +    nvme_misc_cb(req, ret);
> +}
> +
> +
> +static uint16_t nvme_resv_report(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int num_keys;
> +    uint32_t cdw10 = req->cmd.cdw10;
> +    uint32_t cdw11 = req->cmd.cdw11;
> +    int buflen = (cdw10 + 1) * sizeof(uint32_t);
> +    bool eds = cdw11 & 0x1;
> +    NvmeNamespace *ns = req->ns;
> +    NvmeResvKeys *keys_info;
> +
> +    if (eds) {
> +        if (buflen < sizeof(NvmeReservationStatusHeader) +
> +           sizeof(uint8_t) * 40) {
> +            return NVME_INVALID_FIELD;
> +        }
> +
> +        num_keys = (buflen - sizeof(NvmeReservationStatusHeader) -
> +                   sizeof(uint8_t) * 40) /
> +                   sizeof(struct NvmeRegisteredCtrlExt);
> +    } else {
> +        if (buflen < sizeof(NvmeReservationStatusHeader)) {
> +            return NVME_INVALID_FIELD;
> +        }
> +
> +        num_keys = (buflen - sizeof(NvmeReservationStatusHeader)) /
> +                   sizeof(struct NvmeRegisteredCtrl);
> +    }
> +
> +    keys_info = g_new0(NvmeResvKeys, 1);
> +    keys_info->generation = 0;
> +    /* num_keys is the maximum number of keys that can be transmitted */
> +    keys_info->num_keys = num_keys;
> +    keys_info->keys = g_malloc(sizeof(uint64_t) * num_keys);

Where will `keys_info->keys` it be freed?  Callbacks do not look like freeing
`keys` itself, but freeing `keys_info`.  Am I missing something?

> +    keys_info->req = req;
> +
> +    req->aiocb = blk_aio_pr_read_keys(ns->blkconf.blk, &keys_info->generation,
> +                                      keys_info->num_keys, keys_info->keys,
> +                                      nvme_resv_read_keys_cb, keys_info);
> +
> +    return NVME_NO_COMPLETE;
> +}
> +
>  typedef struct NvmeCopyAIOCB {
>      BlockAIOCB common;
>      BlockAIOCB *aiocb;
> @@ -4469,6 +4780,14 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
>          return nvme_dsm(n, req);
>      case NVME_CMD_VERIFY:
>          return nvme_verify(n, req);
> +    case NVME_CMD_RESV_REGISTER:
> +        return nvme_resv_register(n, req);
> +    case NVME_CMD_RESV_REPORT:
> +        return nvme_resv_report(n, req);
> +    case NVME_CMD_RESV_ACQUIRE:
> +        return nvme_resv_acquire(n, req);
> +    case NVME_CMD_RESV_RELEASE:
> +        return nvme_resv_release(n, req);
>      case NVME_CMD_COPY:
>          return nvme_copy(n, req);
>      case NVME_CMD_ZONE_MGMT_SEND:
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index b1ad27c8f2..808b26f086 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -470,6 +470,10 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
>      case NVME_CMD_ZONE_MGMT_SEND:   return "NVME_ZONED_CMD_MGMT_SEND";
>      case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_MGMT_RECV";
>      case NVME_CMD_ZONE_APPEND:      return "NVME_ZONED_CMD_ZONE_APPEND";
> +    case NVME_CMD_RESV_REGISTER:    return "NVME_CMD_RESV_REGISTER";
> +    case NVME_CMD_RESV_REPORT:      return "NVME_CMD_RESV_REPORT";
> +    case NVME_CMD_RESV_ACQUIRE:     return "NVME_CMD_RESV_ACQUIRE";
> +    case NVME_CMD_RESV_RELEASE:     return "NVME_CMD_RESV_RELEASE";
>      default:                        return "NVME_NVM_CMD_UNKNOWN";
>      }
>  }
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index da6ccb0f3b..3e88b8be69 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -702,6 +702,43 @@ typedef enum NVMEPrCap {
>                        NVME_PR_CAP_EX_AC_AR),
>  } NvmePrCap;
>  
> +typedef struct QEMU_PACKED NvmeRegisteredCtrl {
> +    uint16_t    cntlid;
> +    uint8_t     rcsts;
> +    uint8_t     rsvd3[5];
> +    uint8_t     hostid[8];
> +    uint64_t    rkey;
> +} NvmeRegisteredCtrl;
> +
> +typedef struct QEMU_PACKED NvmeRegisteredCtrlExt {
> +    uint16_t  cntlid;
> +    uint8_t   rcsts;
> +    uint8_t   rsvd3[5];
> +    uint64_t  rkey;
> +    uint8_t   hostid[16];
> +    uint8_t   rsvd32[32];
> +} NvmeRegisteredCtrlExt;
> +
> +typedef struct QEMU_PACKED NvmeReservationStatusHeader {
> +    uint32_t  gen;
> +    uint8_t   rtype;
> +    uint16_t  regctl;
> +    uint16_t  resv5;
> +    uint8_t   ptpls;
> +    uint8_t   resv10[14];
> +} NvmeReservationStatusHeader;
> +
> +typedef struct QEMU_PACKED NvmeReservationStatus {
> +    struct NvmeReservationStatusHeader header;
> +    struct NvmeRegisteredCtrl regctl_ds[];
> +} NvmeReservationStatus;
> +
> +typedef struct QEMU_PACKED NvmeReservationStatusExt {
> +    struct NvmeReservationStatusHeader header;
> +    uint8_t   rsvd24[40];
> +    struct NvmeRegisteredCtrlExt regctl_eds[];
> +} NvmeReservationStatusExt;
> +
>  typedef struct QEMU_PACKED NvmeDeleteQ {
>      uint8_t     opcode;
>      uint8_t     flags;
> -- 
> 2.20.1
> 
> 
> 

------3ZSP372dp81iX4EJ00Z5Ife_kMxy1Qk5ObWSk-4J55_.bDLc=_266c2_
Content-Type: text/plain; charset="utf-8"


------3ZSP372dp81iX4EJ00Z5Ife_kMxy1Qk5ObWSk-4J55_.bDLc=_266c2_--

