Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BB5CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssmCa-0005lP-ML; Mon, 23 Sep 2024 12:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ssmCY-0005kp-FT
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ssmCU-0003Eo-UI
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727109972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/E046NKuLRix9wdg4Ky8Uw42deeirBI7YPgJV80iJo=;
 b=BBd84IJZrMJ57kNINxMDYKdhaJ8PV/nRBbwI5xcZT3azhWxwsfguNR2nwDIoMb2GRlKq0u
 UEH/ymIVJOLsMzD7+k2Qe6FdW+issNTVsrgJS8aden6lKSQQ+Uc7V9DDubt2IPxVjq4qDY
 Rx/bQuNUKwWEbK+DsLzDbud83eg43EE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-ZWtIzqyqMGCw09XgifZNqw-1; Mon,
 23 Sep 2024 12:46:09 -0400
X-MC-Unique: ZWtIzqyqMGCw09XgifZNqw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2F36195FE0E; Mon, 23 Sep 2024 16:46:07 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BFD19560A3; Mon, 23 Sep 2024 16:46:01 +0000 (UTC)
Date: Mon, 23 Sep 2024 18:45:57 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] Add -build-info and -build-info-json CLI arguments
Message-ID: <ZvGbRWSPPLJDx7BX@redhat.com>
References: <20240923-feature-build-info-cli-v2-1-66b3462f16a1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923-feature-build-info-cli-v2-1-66b3462f16a1@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 23, 2024 at 09:05:24AM +0300, Manos Pitsidianakis wrote:
> Add -build-info and -build-info-json CLI arguments for human and machine
> readable output of build/compile-time configuration data. The source for
> this data is the meson generated config-host.h.
> 
> This information is mainly of interest to developers and other folk who
> deal with many different builds of QEMU and need a way to properly
> differentiate them.
> 
> Because there's always the chance someone will want to consume an
> interface programmatically, also add a -json option that does the same
> but outputs a machine-readable JSON object.

This turns our build system configuration information into a
defacto public API, and while its using JSON, it isn't yusing
QAPI.

To some degree we leak our build system config names externally
because the "if" stanzas in the QAPI schema get copied into the
docs.

Overall though I don't think we should be exposing this build
config infomation externally. We've had many times, particularly
with testing, where people have wanted to access CONFIG_XXX info
about a QEMU binary, but IIRC we've always steered people towards
querying for the actual feature they want, rather than looking
at CONFIG_XXX settings.

ie, look a query-audiodevs to discover what audio baxckends are
built-in, don't look for CONFIG_XXX settings related to audio.
If there are gaps in information we can query from QMP, we should
aim to close those gaps.

IOW, I don't think we should expose this build info info in either
human readable or machine readable format.

> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v2:
> - Fixed alignment of command and documentation in -h output.
> - Link to v1: https://lore.kernel.org/r/20240923-feature-build-info-cli-v1-1-e8c42d845390@linaro.org
> ---
> Notes:
> Sample output:
> 
> $ ./qemu-system-aarch64 -build-info
> ./qemu-system-aarch64 version 9.1.50 (v9.0.0-3444-g8d988656d8) build information
> 
>   configuration key          key value
>   -----------------          ---------
>   accept4                    
>   af_vsock                   
>   asan_iface_fiber           
>   atomic64                   
>   attr                       
>   audio_alsa                 
>   audio_drivers              pa,sndio,oss
>   audio_oss                  
>   audio_pa                   
>   audio_pipewire             
>   audio_sdl                  
>   audio_sndio                
>   avx2_opt                   
>   avx512bw_opt               
>   bdrv_ro_whitelist          
>   bdrv_rw_whitelist          
>   bindir                     /usr/local/bin
>   blkzoned                   
>   brlapi                     
>   capstone                   
>   clock_adjtime              
>   close_range                
>   coroutine_pool             
>   cpuid_h                    
>   curl                       
>   curses                     
>   dbus_display               
>   debug_graph_lock           
>   debug_mutex                
>   debug_tcg                  
>   dup3                       
>   ebpf                       
>   epoll                      
>   epoll_create1              
>   eventfd                    
>   fallocate                  
>   fallocate_punch_hole       
>   fallocate_zero_range       
>   fdatasync                  
>   fdt                        
>   fiemap                     
>   fsfreeze                   
>   fstrim                     
>   fuse                       
>   fuse_lseek                 
>   gbm                        
>   getauxval                  
>   getcpu                     
>   getrandom                  
>   gettid                     
>   gio                        
>   gnutls                     
>   gnutls_crypto              
>   gtk                        
>   hexagon_idef_parser        
>   host_dsosuf                .so
>   iasl                       /bin/iasl
>   inotify                    
>   inotify1                   
>   int128                     
>   int128_type                
>   iovec                      
>   keyutils                   
>   kvm_targets                i386-softmmu,x86_64-softmmu
>   l2tpv3                     
>   libdw                      
>   libudev                    
>   linux                      
>   linux_io_uring             
>   linux_magic_h              
>   madvise                    
>   malloc_trim                
>   memalign                   
>   memfd                      
>   opengl                     
>   open_by_handle             
>   pixman                     
>   plugin                     
>   png                        
>   posix                      
>   posix_fallocate            
>   posix_madvise              
>   posix_memalign             
>   ppoll                      
>   prctl_pr_set_timerslack    
>   preadv                     
>   prefix                     /usr/local
>   pthread_affinity_np        
>   pthread_setname_np_w_tid   
>   qemu_confdir               /usr/local/etc/qemu
>   qemu_datadir               /usr/local/share/qemu
>   qemu_desktopdir            /usr/local/share/applications
>   qemu_firmwarepath          /usr/local/share/qemu-firmware
>   qemu_helperdir             /usr/local/libexec
>   qemu_icondir               /usr/local/share/icons
>   qemu_localedir             /usr/local/share/locale
>   qemu_localstatedir         /var/local
>   qemu_moddir                /usr/local/lib/x86_64-linux-gnu/qemu
>   qom_cast_debug             
>   relocatable                
>   replication                
>   rtnetlink                  
>   sdl                        
>   seccomp                    
>   seccomp_sysrawrc           
>   secret_keyring             
>   selinux                    
>   sendfile                   
>   setns                      
>   signalfd                   
>   slirp                      
>   smbd_command               /usr/sbin/smbd
>   splice                     
>   statx                      
>   statx_mnt_id               
>   syncfs                     
>   sync_file_range            
>   sysconfdir                 /usr/local/etc
>   sysmacros                  
>   tasn1                      
>   tcg                        1
>   timerfd                    
>   tls_priority               NORMAL
>   tpm                        
>   trace_file                 trace
>   trace_log                  
>   usbfs                      
>   usb_libusb                 
>   valgrind_h                 
>   valloc                     
>   vduse_blk_export           
>   vhost                      
>   vhost_crypto               
>   vhost_kernel               
>   vhost_net                  
>   vhost_net_user             
>   vhost_net_vdpa             
>   vhost_user                 
>   vhost_user_blk_server      
>   vhost_vdpa                 
>   virtfs                     
>   vnc                        
>   vnc_jpeg                   
>   vte                        
>   x11                        
>   xen_backend                
>   xen_ctrl_interface_version 41700
>   xkbcommon                  
>   zstd                       
>   blk_zone_rep_capacity      
>   btrfs_h                    
>   copy_file_range            
>   drm_h                      
>   fsxattr                    
>   getifaddrs                 
>   host_block_device          
>   ipproto_mptcp              
>   mlockall                   
>   openpty                    
>   pty_h                      
>   strchrnul                  
>   struct_stat_st_atim        
>   system_function            
>   utmpx                      
>   virgl_d3d_info_ext         
>   host_x86_64                1
>   qemu_version               9.1.50
>   qemu_version_major         9
>   qemu_version_micro         50
>   qemu_version_minor         1
> 
> To: qemu-devel@nongnu.org
> Cc: "Cleber Rosa" <crosa@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: "John Snow" <jsnow@redhat.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "Alex Bennée" <alex.bennee@linaro.org>
> Cc: "Gustavo Romero" <gustavo.romero@linaro.org>
> Cc: "Peter Maydell" <peter.maydell@linaro.org>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>
> Cc: "Richard Henderson" <richard.henderson@linaro.org>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  meson.build               | 15 +++++++-
>  qemu-options.hx           | 15 ++++++++
>  scripts/build_info_gen.py | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  system/vl.c               | 41 +++++++++++++++++++++
>  4 files changed, 161 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 10464466ff..eff2ee323a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3292,7 +3292,20 @@ endif
>  # Generated sources #
>  #####################
>  
> -genh += configure_file(output: 'config-host.h', configuration: config_host_data)
> +config_host_h = configure_file(output: 'config-host.h', configuration: config_host_data)
> +genh += config_host_h
> +
> +build_info_h = custom_target('build-info.h',
> +                             output: 'build-info.h',
> +                             command: [
> +                               find_program('scripts/build_info_gen.py'),
> +                               '--config-headers',
> +                               config_host_h
> +                             ],
> +                             capture: true,
> +                             build_by_default: true,
> +                             build_always_stale: true)
> +genh += build_info_h
>  
>  hxtool = find_program('scripts/hxtool')
>  shaderinclude = find_program('scripts/shaderinclude.py')
> diff --git a/qemu-options.hx b/qemu-options.hx
> index d94e2cbbae..6a32e0624f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -24,6 +24,21 @@ SRST
>      Display version information and exit
>  ERST
>  
> +DEF("build-info", 0, QEMU_OPTION_build_info,
> +    "-build-info     display build information of executable and exit\n", QEMU_ARCH_ALL)
> +SRST
> +``-build-info``
> +    Display build information of executable and exit
> +ERST
> +
> +DEF("build-info-json", 0, QEMU_OPTION_build_info_json,
> +    "-build-info-json\n"
> +    "                dump build information of executable in JSON format and exit\n", QEMU_ARCH_ALL)
> +SRST
> +``-build-info-json``
> +    Dump build information of executable in JSON format and exit
> +ERST
> +
>  DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "-machine [type=]name[,prop[=value][,...]]\n"
>      "                selects emulated machine ('-machine help' for list)\n"
> diff --git a/scripts/build_info_gen.py b/scripts/build_info_gen.py
> new file mode 100755
> index 0000000000..37a9421651
> --- /dev/null
> +++ b/scripts/build_info_gen.py
> @@ -0,0 +1,91 @@
> +#!/usr/bin/env python3
> +
> +"""
> +Generate build information header, build-info.h,
> +for output of -build-info* command line arguments.
> +
> +SPDX-FileContributor: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +SPDX-FileCopyrightText: 2024 Linaro Ltd.
> +SPDX-License-Identifier: GPL-2.0-or-later
> +"""
> +
> +# Formatted with black --line-length 80 scripts/build-info-gen.py
> +
> +import argparse
> +import logging
> +
> +
> +def generate_key_val(header: str) -> str:
> +    # pylint: disable=missing-function-docstring
> +
> +    with open(header, encoding="utf-8") as cfg:
> +        config = [l.split()[1:] for l in cfg if l.startswith("#define")]
> +
> +    for cfg in config:
> +        if cfg[0].startswith("HAVE_"):
> +            yield (cfg[0].removeprefix("HAVE_").lower(), None)
> +            continue
> +        yield (
> +            cfg[0].removeprefix("CONFIG_").lower(),
> +            (
> +                cfg[1]
> +                if len(cfg) == 2
> +                else "".join(cfg[1:]).replace('"', "") if len(cfg) > 2 else None
> +            ),
> +        )
> +
> +
> +def main() -> None:
> +    # pylint: disable=missing-function-docstring
> +    parser = argparse.ArgumentParser()
> +    parser.add_argument("-v", "--verbose", action="store_true")
> +    parser.add_argument(
> +        "--config-headers",
> +        metavar="CONFIG_HEADER",
> +        action="append",
> +        dest="config_headers",
> +        help="paths to configuration host C headers (*.h files)",
> +        required=False,
> +        default=[],
> +    )
> +    args = parser.parse_args()
> +    if args.verbose:
> +        logging.basicConfig(level=logging.ERROR)
> +    logging.debug("args: %s", args)
> +    print(
> +        """// @generated by scripts/build-info-gen.py
> +
> +#include <stddef.h>"""
> +    )
> +    print(
> +        """static struct build_info_t {
> +    const char *key;
> +    const char *value;
> +} BUILD_INFO[] = {"""
> +    )
> +    total = 0
> +    header_width = 0
> +    for header in args.config_headers:
> +        for key, val in generate_key_val(header):
> +            total += 1
> +            header_width = max(header_width, len(key))
> +            print(
> +                '{"',
> +                key,
> +                '", "',
> +                val.strip('"').strip(",").strip('"') if val else "",
> +                '"},',
> +                sep="",
> +            )
> +    print("};")
> +    print("\nstatic size_t BUILD_INFO_SIZE = ", total, ";", sep="")
> +    print(
> +        "static unsigned int BUILD_INFO_HEADER_WIDTH = ",
> +        header_width,
> +        ";",
> +        sep="",
> +    )
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/system/vl.c b/system/vl.c
> index fe547ca47c..5266b85d22 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -908,6 +908,41 @@ static void help(int exitcode)
>      exit(exitcode);
>  }
>  
> +static void build_info(const char *execname, bool as_json)
> +{
> +#include "build-info.h"
> +    if (as_json) {
> +        printf("{\n");
> +        for (size_t i = 0; i + 1 < BUILD_INFO_SIZE ; i++) {
> +            printf("\"%s\":\"%s\",\n",
> +                   BUILD_INFO[i].key,
> +                   BUILD_INFO[i].value);
> +        }
> +        if (BUILD_INFO_SIZE > 0) {
> +            printf("\"%s\":\"%s\"\n",
> +                   BUILD_INFO[BUILD_INFO_SIZE - 1].key,
> +                   BUILD_INFO[BUILD_INFO_SIZE - 1].value);
> +        }
> +        printf("}\n");
> +    } else {
> +        printf("%s version "
> +               QEMU_FULL_VERSION
> +               " build information\n\n", execname ?:"QEMU");
> +        printf("  %-*s key value\n",
> +               BUILD_INFO_HEADER_WIDTH,
> +               "configuration key");
> +        printf("  %-*s ---------\n",
> +               BUILD_INFO_HEADER_WIDTH,
> +               "-----------------");
> +        for (size_t i = 0; i < BUILD_INFO_SIZE ; i++) {
> +            printf("  %-*s %s\n",
> +                   BUILD_INFO_HEADER_WIDTH,
> +                   BUILD_INFO[i].key,
> +                   BUILD_INFO[i].value);
> +        }
> +    }
> +}
> +
>  enum {
>  
>  #define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
> @@ -3019,6 +3054,12 @@ void qemu_init(int argc, char **argv)
>                  version();
>                  exit(0);
>                  break;
> +            case QEMU_OPTION_build_info:
> +                /* fallthrough */
> +            case QEMU_OPTION_build_info_json:
> +                build_info(argv[0], popt->index != QEMU_OPTION_build_info);
> +                exit(0);
> +                break;
>              case QEMU_OPTION_m:
>                  opts = qemu_opts_parse_noisily(qemu_find_opts("memory"), optarg, true);
>                  if (opts == NULL) {
> 
> ---
> base-commit: 01dc65a3bc262ab1bec8fe89775e9bbfa627becb
> change-id: 20240922-feature-build-info-cli-c9e08e34c34b
> 
> --
> γαῖα πυρί μιχθήτω
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


