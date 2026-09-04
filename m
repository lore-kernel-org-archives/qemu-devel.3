Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64891C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YFH-00026X-8l; Fri, 04 Sep 2026 14:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2YFF-00025z-Fq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2YFD-0001HK-Eo
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788544949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xu7WipYE0vBrNVrbrQuBOrlI2YP7MfKt+pRTWpGeXu4=;
 b=MIZPpPp90ksfTGPi0G+bQKF7uATgQJ0p6MmDKtzdJsqUELXb0oTqkAKb8gPMO7tENPAhMK
 lufQroHTm3xjnenrJTmZ6r9+/735Hd8NULFPtQFXjwD6+Wd78Hy7a1oTNAjbY2s1pdj3L8
 Fo6n0mLLErwAZo7puxamiTk21zhOJvE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539--OKwcoD-NEysFuDQCB8CWg-1; Fri, 04 Sep 2026 14:02:27 -0400
X-MC-Unique: -OKwcoD-NEysFuDQCB8CWg-1
X-Mimecast-MFC-AGG-ID: -OKwcoD-NEysFuDQCB8CWg_1788544946
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-484362cb000so880463f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788544946; x=1789149746; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xu7WipYE0vBrNVrbrQuBOrlI2YP7MfKt+pRTWpGeXu4=;
 b=flo6f2Zfb4QdendVIXpL103JBcNjRNlOB1NHwEtxkkULsQh3g2ujIBCkKB1H5XwQSn
 oyaJp1I1eRJrVDad6EvyZ0GP+esF1DGR5V+oc1zJNXck9yNo1+GlnVBP0KFTm4wZMqWn
 ExC13ClCozQbGzonUVFVhwWGm3pudBSTO1DupvvO3sI0dPIG/t6obuu4bH7NSbbi1Qle
 ZA3lTxKMFRF8X0ntoLl05NP9MEgpy7m2uzKON/3bfhs4w3xtZW43hyM0/2LnGh7ae1M9
 9kMFQWXF9nK/Cttg8CrT84vHWDdLw291GmECYC8lAHNPI+jyo28xdxOtTsThXjspkCxA
 C/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788544946; x=1789149746;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xu7WipYE0vBrNVrbrQuBOrlI2YP7MfKt+pRTWpGeXu4=;
 b=GJgo+nP/sWY/xywlIWTfoDAQSRtM4xYr7mFxT5XbIw07WMNXgyfsaN5S9k5RQ79HYz
 uGotE79EUujzL9wn/S8DWK2I0s1083cYNr5Uw12BJ8WUA4RdcasAigecRgAIeiSHHVwU
 vyyl9jDnNqztgBcqNtGZDul6UXclu/kLCPls+7FXRR7wHrXA/d2nPSaK+lpH2BQUHyjO
 JZd4wjE9VbN67vtjPIBdXTHuwfMx5hIpqpqxFDkzuVyBbIgFHBjQtBO3YT9XCCSBVJF2
 Tp6C0qdm88afPXMqVvvhy3Vve9bMQCQRkDxaQwSOjxJphP81pLJ69amtC/XUGRIitPb2
 Ietw==
X-Gm-Message-State: AFuF++mAbE1k2/Q29AmmTCKFD21VrGT+JXhaP7amXYVVtHYeqdiy1Pt1
 2iS9OGa1tIhjsFy01AJCZ7R+upVvO6HEPd7niz4qbHotoPdYXg4T0krR7hL2zdReGVgz9N6AHem
 DRQ1XI2ZFDIKSnvZwZbRDZ96DapnhaU9iMMXFPI7f1Tndeb5stnl20rwe
X-Gm-Gg: AYBFou3Vu7U00uuEpHwhuLBRbriv7YGkuUl6TcEN9MciKnBZmIExx3sNO0bRq7pRkPs
 yzvAON3dxX4ITT9bZ6oKTvCnJPcA9gObcAh/fillaCq4VqEGXSvz0sMxq6j5u/udEBp53Zppi6U
 1XpL6fXAz47fPwcRkJ/5QM3Wc+cJpTviHjRCa6lZMwwXHe7ShlqsCrsnN+VMke6lCODJ9MBf1Nk
 5IkulZlVj0kU89HNGu9PcF5uNUenUt2aAh/H4R0ECK4YNk2zkN0Qmop6FRdOnsC/WhyykD9OceR
 7Ystxuz1vmgaNM3T1UHdAdU3Tle3kknLoVjxrKCzGW+SPScrAJlE6WP3aScjVwiKlFfztnhgwJg
 sROAYWO2ezVpctnQitjuabdQ=
X-Received: by 2002:a05:6000:455c:b0:485:8df2:6460 with SMTP id
 ffacd0b85a97d-4858df26482mr2844230f8f.20.1788544946163; 
 Fri, 04 Sep 2026 11:02:26 -0700 (PDT)
X-Received: by 2002:a05:6000:455c:b0:485:8df2:6460 with SMTP id
 ffacd0b85a97d-4858df26482mr2844138f8f.20.1788544945489; 
 Fri, 04 Sep 2026 11:02:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm8126195f8f.1.2026.09.04.11.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:02:24 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:02:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, qemu-trivial@nongnu.org,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] net/tap-solaris: Fix resource leaks on error paths
Message-ID: <20260904135600-mutt-send-email-mst@kernel.org>
References: <20260724093809.810220-1-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724093809.810220-1-xiongwm2026@163.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Jul 24, 2026 at 05:38:09PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> The tap_alloc() function has multiple error paths where opened file
> descriptors (tap_fd, if_fd, ip_fd) are not closed before returning
> error. This leads to resource leaks.
> 
> Fix this by properly closing file descriptors before returning error
> in all error paths.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  net/tap-solaris.c | 47 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 1234567890ab..fedcba098765 4321006

mode 4321006? this line seems corrupt, at least it confuses my git am


> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -60,8 +60,6 @@
>   */
>  static int tap_alloc(char *dev, size_t dev_size, Error **errp)
>  {
> -    /* FIXME leaks like a sieve on error paths */
> -    /* FIXME suspicious: many errors are reported, then ignored */
>      int tap_fd, if_fd, ppa = -1;
>      static int ip_fd = 0;
>      char *ptr;
> @@ -102,18 +100,30 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
>      strioc_ppa.ic_dp = (char *)&ppa;
>      if ((ppa = ioctl (tap_fd, I_STR, &strioc_ppa)) < 0) {
>          error_report("Can't assign new interface");
> -        return -1;
> +        goto fail_tap_fd;
>      }
>  
>      if_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
>      if (if_fd < 0) {
>          error_setg_file_open(errp, errno, "/dev/tap");
> -        return -1;
> +        goto fail_tap_fd;
>      }
>      if(ioctl(if_fd, I_PUSH, "ip") < 0){
>          error_setg(errp, "Can't push IP module");
> -        return -1;
> +        goto fail_if_fd;
> +    }
> +
> +    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0) {
> +        error_report("Can't get flags");
> +        goto fail_if_fd;
> +    }
> +
> +    snprintf(actual_name, 32, "tap%d", ppa);
> +    pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
> +
> +    ifr.lifr_ppa = ppa;
> +    if (ioctl(if_fd, SIOCSLIFNAME, &ifr) < 0) {
> +        error_report("Can't set PPA %d", ppa);
> +        goto fail_if_fd;
>      }
>  
> -    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
> -        error_report("Can't get flags");
> +    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0) {
> +        error_report("Can't get flags");
> +        goto fail_if_fd;
> +    }
>  
> -    snprintf (actual_name, 32, "tap%d", ppa);
> -    pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
> -
> -    ifr.lifr_ppa = ppa;
> -    /* Assign ppa according to the unit number returned by tun device */
> -
> -    if (ioctl (if_fd, SIOCSLIFNAME, &ifr) < 0)
> -        error_report("Can't set PPA %d", ppa);
> -    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) <0)
> -        error_report("Can't get flags");
>      /* Push arp module to if_fd */
> -    if (ioctl (if_fd, I_PUSH, "arp") < 0)
> +    if (ioctl(if_fd, I_PUSH, "arp") < 0) {
>          error_report("Can't push ARP module (2)");
> +        goto fail_if_fd;
> +    }
>  
>      /* Push arp module to ip_fd */
> -    if (ioctl (ip_fd, I_POP, NULL) < 0)
> +    if (ioctl(ip_fd, I_POP, NULL) < 0) {
>          error_report("I_POP failed");
> -    if (ioctl (ip_fd, I_PUSH, "arp") < 0)
> +        goto fail_if_fd;
> +    }
> +    if (ioctl(ip_fd, I_PUSH, "arp") < 0) {
>          error_report("Can't push ARP module (3)");
> +        goto fail_if_fd;
> +    }
>      /* Open arp_fd */
>      arp_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
> -    if (arp_fd < 0)
> +    if (arp_fd < 0) {
>          error_report("Can't open %s", "/dev/tap");
> +        goto fail_if_fd;
> +    }
>  
>      /* Set ifname to arp */
>      strioc_if.ic_cmd = SIOCSLIFNAME;
> @@ -147,21 +172,37 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
>      strioc_if.ic_dp = (char *)&ifr;
>      if (ioctl(arp_fd, I_STR, &strioc_if) < 0){
>          error_report("Can't set ifname to arp");
> +        goto fail_arp_fd;
>      }
>  
>      if((ip_muxid = ioctl(ip_fd, I_LINK, if_fd)) < 0){
>          error_setg(errp, "Can't link TAP device to IP");
> -        return -1;
> +        goto fail_arp_fd;
>      }
>  
> -    if ((arp_muxid = ioctl (ip_fd, link_type, arp_fd)) < 0)
> +    if ((arp_muxid = ioctl(ip_fd, link_type, arp_fd)) < 0) {
>          error_report("Can't link TAP device to ARP");
> +        goto fail_ip_muxid;
> +    }
>  
>      close (if_fd);
> +    close(ip_fd);


so you close ip_fd here ...

>  
>      memset(&ifr, 0x0, sizeof(ifr));
>      pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
>      ifr.lifr_ip_muxid  = ip_muxid;
>      ifr.lifr_arp_muxid = arp_muxid;
>  
> -    if (ioctl (ip_fd, SIOCSLIFMUXID, &ifr) < 0)
> -    {
> -      ioctl (ip_fd, I_PUNLINK , arp_muxid);
> -      ioctl (ip_fd, I_PUNLINK, ip_muxid);
> -      error_report("Can't set multiplexor id");
> +    if (ioctl(ip_fd, SIOCSLIFMUXID, &ifr) < 0) {


and then try to do an ioctl on it?

> +        ioctl(ip_fd, I_PUNLINK, arp_muxid);
> +        ioctl(ip_fd, I_PUNLINK, ip_muxid);
> +        error_report("Can't set multiplexor id");
> +        goto fail_arp_muxid;
>      }
>  
>      snprintf(dev, dev_size, "tap%d", ppa);
>      return tap_fd;
> +
> +fail_arp_muxid:
> +    close(arp_fd);

arp_fd closed here

> +fail_ip_muxid:
> +    ioctl(ip_fd, I_PUNLINK, ip_muxid);
> +fail_arp_fd:
> +    close(arp_fd);

then again here

> +fail_if_fd:
> +    close(if_fd);
> +fail_tap_fd:
> +    close(tap_fd);
> +    if (ip_fd > 0) {
> +        close(ip_fd);
> +        ip_fd = 0;
> +    }
> +    return -1;
>  }


