Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A275CE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXPo-0006zL-DA; Wed, 08 Jan 2025 09:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adam@rttst.com>) id 1tVXPh-0006z6-37
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:52:06 -0500
Received: from mta-231a.oxsus-vadesecure.net ([15.204.3.4]
 helo=nmtao201.oxsus-vadesecure.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adam@rttst.com>) id 1tVXPa-0003ZS-LH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:52:01 -0500
Authentication-Results: oxsus-vadesecure.net;
 auth=pass smtp.auth=3@204339 smtp.mailfrom=adam@rttst.com;
ARC-Seal: i=1; a=rsa-sha256; d=oxsus-vadesecure.net; s=arc-202309-rsa2048;
 t=1736347915; cv=none;
 b=abkAD25K611s883WXJkDA1h/1SEcDatpBqM8cvFceBu2XrS2+3mU0Gwk1ctClOfjXrjHQCHpDh+mEIka2RJ6tiFp+EOcPvSpiFFDpqduf7T1lWxRbYoKUMOhcgKV1H4yu28U1XfpIHi6DUHLQxD/SQT5o1eaf5SmbfzFpdfOCOrGcy3bsATimZb5x6IhwFU1FW9/zE6vgxoq96D8tqSv+xbmmIs9tOL84YW7nWCd0VCcSzyqvpOpxK9KtFsvRhvhH1IVdOq3/WbFGtC52ngt9nNCU1j7yJ0pGMqNaK1+srwWkPk+3l9Cl4uDgS47PspqMP1nKlAS37wPVJisBQMzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=oxsus-vadesecure.net;
 s=arc-202309-rsa2048; t=1736347915; c=relaxed/relaxed;
 h=from:reply-to:subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive;
 bh=+K3Drh4nQ4T68jZoiYlJL2Unji4JeZHpX09bvQKFSvc=;
 b=Vze+7ZPqcpDXVks9eOuPxE4RwweoBZKY3t0vJIfhTNzM1CkhK3J7Y5BdNeOByoo8sFS84f9rWnCMjjJJfS+ziI0nJFTVEh4S68Zj5DSYFKLUH2ijNPLQXkpfeTRkE+xcs0mQhUG280J/u/qbDAO/kg31El7d/VFI6ilTGIORwRWKEU7BW+02XVdDzp+eSHOyxDWsJlRZ2VKXb6o8RK1Is82x2OV4KyQ5GlMyCheqL+CgJDGJry/pk/U9z2eCOEUsVq7Z8Rgk42GSG6ZtbBFqdmxRtsuiFOW1UJ5jetb1RKemPCrYxR1dt+FceilkirXIIn8988C/kBrhbVUk9poJ4g==
ARC-Authentication-Results: i=1;
DKIM-Signature: v=1; a=rsa-sha256; bh=+K3Drh4nQ4T68jZoiYlJL2Unji4JeZHpX09bvQ
 KFSvc=; c=relaxed/relaxed; d=oxsus-vadesecure.net; h=from:reply-to:
 subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
 in-reply-to:references:list-id:list-help:list-unsubscribe:
 list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive;
 q=dns/txt; s=dkim-202410-rsa2048; t=1736347915; x=1736952715; b=GwcOJ6U
 bG2yaIXFNHEzTHgdMJivGDeOg2/Y3gt883HSfBLTR8+xJQwb7T0p7UfhJ+NQXH390LRUxyY
 bKUnBTfeFfhVHAmWVQCFa6VBbr+NGoCPh1HsRiJrazpPlQ31vRcdzTPXsE+LG1t+Y465E+r
 /XBG9FEm8oxSGJJs0Beqg7Ln8fIJwfvj9z69A1SBmxkaqoJ12Q0tZEFx9w6QXrJ5Bd25BmC
 M63TV2/WdFkVLvAn3kJ5pxqJVJcAdRDcJ6OFlpFqbFCLw1ykyu4+RbTMw3lg/88NUs7axSc
 sgvn4WJyKk3/s/fTD6znc4gZ5ZQPsTOKXVikWOWV6WdUSMcBljg==
Received: from proxy-19.proxy.cloudus.ewr.xion.oxcs.net ([107.143.227.186])
 by oxsus2nmtao01p.internal.vadesecure.com with ngmta
 id 8b95b1e9-1818bf3a5865ef04; Wed, 08 Jan 2025 14:51:55 +0000
Message-ID: <3fd90b0c-ff50-4dc7-921d-bdecb82c7777@rttst.com>
Date: Wed, 8 Jan 2025 08:51:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Adam <adam@rttst.com>
Subject: 86_64 host is not supported by hypervisor - 2024
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=15.204.3.4; envelope-from=adam@rttst.com;
 helo=nmtao201.oxsus-vadesecure.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: adam@rttst.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TWIMC:

Had an issue with VM networking that turned out to be the host. In the 
process of troubleshooting, I

     sudo apt reinstall libvirt   (and other QEMU/KVM virtualization 
dependencies)

Now I am getting this particular error when trying to use the 
host-passthrough for the CPU.

"error: unsupported configuration: CPU mode 'host-passthrough' for 
x86_64 qemu domain on x86_64 host is not supported by hypervisor"

This was working previously.  I found that two other domains are 
responding the same.

The configuration in xml file is:

     <metadata>
     <libosinfo:libosinfo 
xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
       <libosinfo:os id="http://libosinfo.org/linux/2022"/>
     </libosinfo:libosinfo>
   </metadata>
   <memory unit='KiB'>4194304</memory>
   <currentMemory unit='KiB'>4194304</currentMemory>
   <vcpu placement='static'>2</vcpu>
   <os>
     <type arch='x86_64' machine='pc-q35-7.2'>hvm</type>
     <boot dev='hd'/>
   </os>
   <features>
     <acpi/>
     <apic/>
     <vmport state='off'/>
   </features>
   <cpu mode='host-passthrough' check='none' migratable='on'/>
   <clock offset='utc'>

But i now have to use this for it to work but the system is quite slow now.

  <metadata>
     <libosinfo:libosinfo 
xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
       <libosinfo:os id="http://libosinfo.org/linux/2022"/>
     </libosinfo:libosinfo>
   </metadata>
   <memory unit='KiB'>4194304</memory>
   <currentMemory unit='KiB'>4194304</currentMemory>
   <vcpu placement='static'>2</vcpu>
   <os>
     <type arch='x86_64' machine='pc-q35-5.2'>hvm</type>
     <boot dev='hd'/>
   </os>
   <features>
     <acpi/>
     <apic/>
     <vmport state='off'/>
   </features>
   <cpu mode='custom' match='exact' check='none'>
     <model fallback='forbid'>qemu64</model>
   </cpu>


Any recommendations, given that this used to work.


Traceback error details are below this line:

Error starting domain: unsupported configuration: CPU mode 
'host-passthrough' for x86_64 qemu domain on x86_64 host is not 
supported by hypervisor

Traceback (most recent call last):
   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 72, in 
cb_wrapper
     callback(asyncjob, *args, **kwargs)
   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 108, in 
tmpcb
     callback(*args, **kwargs)
   File "/usr/share/virt-manager/virtManager/object/libvirtobject.py", 
line 57, in newfn
     ret = fn(self, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/share/virt-manager/virtManager/object/domain.py", line 
1402, in startup
     self._backend.create()
   File "/usr/lib/python3/dist-packages/libvirt.py", line 1373, in create
     raise libvirtError('virDomainCreate() failed')
libvirt.libvirtError: unsupported configuration: CPU mode 
'host-passthrough' for x86_64 qemu domain on x86_64 host is not 
supported by hypervisor


Thank you,

A>AM





